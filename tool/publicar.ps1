# Publica apenas commits existentes e aguarda o CI antes de enviar a tag.
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$repository = 'gcorrea4/vozcidadao-flutter'
$tag = 'v1.0.0'
$projectRoot = Split-Path -Parent $PSScriptRoot

function Invoke-Checked {
    param([string]$Program, [string[]]$Arguments)
    & $Program @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Program falhou (codigo $LASTEXITCODE). Publicacao interrompida."
    }
}

function Read-GitHubJson {
    param([string[]]$Arguments)
    $output = & gh @Arguments
    if ($LASTEXITCODE -ne 0) { throw 'Falha ao consultar o GitHub. Confira autenticacao, conexao e permissoes.' }
    return (($output -join "`n") | ConvertFrom-Json)
}

function Wait-Workflow {
    param([string]$Commit, [string]$Branch)
    $limit = (Get-Date).AddMinutes(35)
    while ((Get-Date) -lt $limit) {
        $runs = @(Read-GitHubJson -Arguments @(
            'run', 'list', '--repo', $repository,
            '--commit', $Commit, '--event', 'push', '--limit', '20',
            '--json', 'databaseId,status,conclusion,headBranch,workflowName'
        ))
        $run = $runs | Where-Object {
            $_.headBranch -eq $Branch -and $_.workflowName -eq 'Flutter - testes e APK'
        } | Select-Object -First 1
        if ($null -ne $run) {
            if ($run.status -eq 'completed') {
                if ($run.conclusion -ne 'success') {
                    throw "Workflow $($run.databaseId) terminou com $($run.conclusion). Consulte gh run view $($run.databaseId) --repo $repository --log-failed."
                }
                Write-Host "Workflow $($run.databaseId) aprovado para $Branch."
                return
            }
            Write-Host "Aguardando workflow $($run.databaseId): $($run.status)..."
        } else {
            Write-Host "Aguardando o GitHub registrar o workflow de $Branch..."
        }
        Start-Sleep -Seconds 10
    }
    throw 'Tempo limite esperando o workflow. Nenhuma aprovacao foi presumida.'
}

Push-Location $projectRoot
try {
    Get-Command git, gh -ErrorAction Stop | Out-Null
    $profile = Read-GitHubJson -Arguments @('api', 'user')
    if ($profile.login -ne 'gcorrea4') { throw 'Autentique a conta gcorrea4 antes de publicar.' }

    $branch = (& git branch --show-current).Trim()
    if ($LASTEXITCODE -ne 0 -or $branch -ne 'main') { throw 'Execute na branch main do projeto.' }
    $changes = & git status --porcelain
    if ($LASTEXITCODE -ne 0 -or $changes) { throw 'Existem alteracoes sem commit. Revise e registre as alteracoes antes de publicar.' }
    foreach ($field in @('user.name', 'user.email')) {
        $identity = & git config --get $field
        if ($LASTEXITCODE -ne 0 -or -not $identity) { throw "Configure $field com seus dados reais antes de publicar." }
    }
    $commit = (& git rev-parse HEAD).Trim()
    if ($LASTEXITCODE -ne 0) { throw 'Nao foi possivel obter o commit atual.' }

    # Nao altera a visibilidade de um repositorio preexistente.
    $repoOutput = & gh repo view $repository --json nameWithOwner,isPrivate
    if ($LASTEXITCODE -ne 0) {
        Invoke-Checked -Program gh -Arguments @('repo', 'create', $repository, '--public', '--description', 'VozCidada: Flutter CitizenTech - Global Solution FIAP 2026/2')
    } else {
        $repo = ($repoOutput -join "`n") | ConvertFrom-Json
        if ($repo.isPrivate) { throw 'O repositorio existente e privado. Confira a visibilidade antes de prosseguir.' }
    }

    $remote = & git remote get-url origin
    if ($LASTEXITCODE -ne 0) {
        Invoke-Checked -Program git -Arguments @('remote', 'add', 'origin', "https://github.com/$repository.git")
    } elseif ($remote -notin @("https://github.com/$repository.git", "https://github.com/$repository", "git@github.com:$repository.git")) {
        throw 'O remote origin aponta para outro repositorio. Confira antes de publicar.'
    }
    Invoke-Checked -Program gh -Arguments @('auth', 'setup-git')
    Invoke-Checked -Program git -Arguments @('push', '-u', 'origin', 'main')
    Wait-Workflow -Commit $commit -Branch 'main'

    $localTag = & git show-ref --hash --verify "refs/tags/$tag"
    if ($LASTEXITCODE -eq 0 -and $localTag.Trim() -ne $commit) {
        throw 'A tag local ja existe em outro commit. Ela nao sera reescrita.'
    }
    $remoteTag = & git ls-remote --tags origin "refs/tags/$tag"
    if ($LASTEXITCODE -ne 0) { throw 'Falha ao consultar tags remotas.' }
    if ($remoteTag -and ($remoteTag -split '\s+')[0] -ne $commit) {
        throw 'A tag remota ja existe em outro objeto. Ela nao sera reescrita.'
    }
    if (-not $localTag) {
        Invoke-Checked -Program git -Arguments @('tag', $tag, $commit)
    }
    Invoke-Checked -Program git -Arguments @('push', 'origin', "refs/tags/$tag")
    Wait-Workflow -Commit $commit -Branch $tag

    $release = Read-GitHubJson -Arguments @('release', 'view', $tag, '--repo', $repository, '--json', 'url,assets,isDraft')
    if ($release.isDraft -or -not ($release.assets | Where-Object { $_.name -eq 'vozcidada.apk' })) {
        throw 'A Release publicada com o APK nao foi confirmada.'
    }
    Write-Host "Release confirmada: $($release.url)"
    Write-Host 'Atualize o status de publicacao no README apos conferir a instalacao em Android.'
} finally {
    Pop-Location
}
