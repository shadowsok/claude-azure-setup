#!/usr/bin/env pwsh
# claude-azure.ps1 - Claude Code CLI wrapper with Azure Foundry auth

# Azure AI Foundry endpoint configuration
$AZURE_FOUNDRY_ENDPOINT = "https://YOUR-ENDPOINT.openai.azure.com"
$AZURE_FOUNDRY_DEPLOYMENT = "YOUR-DEPLOYMENT-NAME"  # Update with actual deployment name

# Function to get fresh Azure token
function Get-AzureToken {
    try {
        $tokenJson = az account get-access-token --resource https://cognitiveservices.azure.com --query accessToken -o json 2>$null
        if ($LASTEXITCODE -eq 0) {
            return ($tokenJson | ConvertFrom-Json)
        }
    } catch {
        Write-Error "Failed to get Azure token. Run 'az login' first."
        exit 1
    }
    return $null
}

# Get fresh token
$token = Get-AzureToken
if (-not $token) {
    Write-Error "Azure authentication failed. Run 'az login --use-device-code' and try again."
    exit 1
}

# Set environment variables for Claude CLI
$env:AZURE_OPENAI_ENDPOINT = $AZURE_FOUNDRY_ENDPOINT
$env:AZURE_OPENAI_API_KEY = $token
$env:AZURE_OPENAI_DEPLOYMENT = $AZURE_FOUNDRY_DEPLOYMENT

# Call claude.exe with all passed arguments
& "$env:USERPROFILE\.local\bin\claude.exe" @args