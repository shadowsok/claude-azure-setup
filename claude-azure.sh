#!/usr/bin/env bash
# claude-azure.sh - Claude Code CLI wrapper with Azure Foundry auth

# Azure AI Foundry endpoint configuration
AZURE_FOUNDRY_ENDPOINT="https://YOUR-ENDPOINT.openai.azure.com"
AZURE_FOUNDRY_DEPLOYMENT="YOUR-DEPLOYMENT-NAME"  # Update with actual deployment name

# Function to get fresh Azure token
get_azure_token() {
    local token=$(az account get-access-token --resource https://cognitiveservices.azure.com --query accessToken -o tsv 2>/dev/null)
    if [ $? -eq 0 ] && [ -n "$token" ]; then
        echo "$token"
        return 0
    else
        echo "Failed to get Azure token. Run 'az login' first." >&2
        return 1
    fi
}

# Get fresh token
TOKEN=$(get_azure_token)
if [ -z "$TOKEN" ]; then
    echo "Azure authentication failed. Run 'az login --use-device-code' and try again." >&2
    exit 1
fi

# Export environment variables for Claude CLI
export AZURE_OPENAI_ENDPOINT="$AZURE_FOUNDRY_ENDPOINT"
export AZURE_OPENAI_API_KEY="$TOKEN"
export AZURE_OPENAI_DEPLOYMENT="$AZURE_FOUNDRY_DEPLOYMENT"

# Call claude with all passed arguments
exec ~/.local/bin/claude "$@"