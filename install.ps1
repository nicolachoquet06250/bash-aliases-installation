$repos=$args

$github_repo_search_url_base="https://api.github.com/search/repositories?q=nicolachoquet06250"

for ($i=0; $i -lt $repos.Length; $i++) {
    $repo_name = $repos[$i]

    Write-Output $repo_name

    $url = "$github_repo_search_url_base/$repo_name"
    Write-Output $url
    If ("$env:GITHUB_INSTALL_ACCESS_TOKEN" -ne "") {
        $curl_result = curl -s "$url" --header "Authorization: Bearer $env:GITHUB_INSTALL_ACCESS_TOKEN" | Out-String
    } else {
        $curl_result = curl -s "$url" | Out-String
    }

    $parsedJson = $curl_result | ConvertFrom-Json

    $total_count = $parsedJson.total_count

    If ($total_count -eq 0) {
        Write-Output "existe pas"
    } elseif ($total_count -gt 1) {
        Write-Output "trop grand"
    } elseif ($total_count -eq 1) {
        $repo = $parsedJson.items[0].ssh_url

        If (-not (Test-Path "$(Get-Location)/${repo_name}")) {
            git clone $repo
        }

        If ((Test-Path "$(Get-Location)/${repo_name}/.githooks/post-checkout.ps1")) {
            If ((Test-Path "$(Get-Location)/${repo_name}/.git/hooks/post-checkout.ps1")) {
                Remove-Item -Recurse -Force "$(Get-Location)/${repo_name}/.git/hooks/post-checkout.ps1"
            }
            New-Item -ItemType SymbolicLink -Path "$(Get-Location)/${repo_name}/.githooks/post-checkout.ps1" -Target "$(Get-Location)/${repo_name}/.git/hooks/post-checkout.ps1"

            Set-ExecutionPolicy Bypass -command "$(Get-Location)/${repo_name}/.githooks/post-checkout.ps1"

            . "$(Get-Location)/${repo_name}/.git/hooks/post-checkout.ps1" "install-script"
        } else {
            Write-Output "Pas de version Powershell"
        }
    }
}