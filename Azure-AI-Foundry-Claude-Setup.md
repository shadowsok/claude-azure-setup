---
tags: [azure, setup, claude, azure, foundry]
aliases: [Claude Setup Guide, Azure AI Foundry Setup]
last_updated: 2026-07-15
---

# Azure AI Foundry + Claude Setup Guide

## Overview

This guide will help you set up **Claude via Azure AI Foundry** on your your organization AVD machine. You'll be able to use Claude in:
- **Claude Code CLI** (terminal)
- **Visual Studio Code** (Claude panel)
- **Visual Studio 2022** (inline Claude agent)
- **OpenCode** (with automatic token refresh)

---

## Prerequisites

1. **AVD Machine** with admin rights (or ability to request admin-required installs via IT)
2. **Azure subscription access** to **YOUR_SUBSCRIPTION_NAME**
3. **GitHub account** with access to mti-dig organization
4. **RBAC permissions** on Azure AI Foundry endpoint (if you get 401 errors, contact Your Azure Admin or Your Azure Admin)

---

## Part 1: Azure CLI Installation & Authentication

### Step 1.1: Install Azure CLI

**Windows (Native):**
```powershell
# Download and install Azure CLI
winget install -e --id Microsoft.AzureCLI
```

**WSL (Ubuntu/Debian):**
```bash
# Install Azure CLI in WSL
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

**Verify installation:**
```powershell
az --version
```

You should see version 2.50+ (or newer).

---

### Step 1.2: Login to Azure

**Both Windows and WSL:**
```powershell
az login --use-device-code
```

**What happens:**
1. You'll see a URL and a code
2. Open browser, go to https://microsoft.com/devicelogin
3. Enter the code
4. Sign in with your **your-email@company.com** credentials
5. Return to terminal

**Verify subscriptions:**
```powershell
az account list --output table
```

**Expected output:**
| Name                | SubscriptionId                       | TenantId                             | State   |
|---------------------|--------------------------------------|--------------------------------------|---------|
| YOUR_SUBSCRIPTION_NAME  | 6db922a3-20f1-414f-acd0-0542ad9f80c1 | ...                                  | Enabled |
| MTI-AVD-CORP        | 1029544e-050b-4d68-8221-9ed32bfc8a18 | ...                                  | Enabled |

**Set the correct subscription:**
```powershell
az account set --subscription "YOUR_SUBSCRIPTION_NAME"
az account show
```

**Checkpoint:** You should see **YOUR_SUBSCRIPTION_NAME** as the active subscription.

---

## Part 2: Claude Code CLI Installation

### Step 2.1: Install Claude CLI

**Windows (Native):**
```powershell
# Create bin directory
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.local\bin"

# Download Claude CLI (replace URL with actual download link from Anthropic)
# Note: As of 2026-07-15, Claude CLI is in beta. Get download link from:
# https://claude.ai/download or contact Anthropic support

# For now, assuming you have claude.exe already (Joseph's setup):
# Copy from: Copy-Item "```

**WSL:**
```bash
# Create bin directory
mkdir -p ~/.local/bin

# Download Claude CLI (Linux version)
# Same note as above - get from Anthropic or IT

# Example (update URL as needed):
curl -L -o ~/.local/bin/claude https://downloads.anthropic.com/claude-cli/latest/linux/claude
chmod +x ~/.local/bin/claude
```

**Add to PATH (if not already):**

**Windows (PowerShell profile):**
```powershell
# Edit profile
code $PROFILE

# Add this line:
$env:Path = "$env:USERPROFILE\.local\bin;" + $env:Path
```

**WSL (.bashrc or .zshrc):**
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

---

### Step 2.2: Create Azure Token Refresh Script

**Why this is needed:**
Azure tokens expire after ~60 minutes. This script auto-refreshes the token before calling Claude.

**Windows: Save as claude-azure.ps1**

See separate file: `claude-azure.ps1`

**WSL: Save as ~/claude-azure.sh**

See separate file: `claude-azure.sh`

---

### Step 2.3: Add Wrapper Function to Shell Profile

**Windows (PowerShell profile):**
```powershell
# Edit profile
code $PROFILE

# Add this function:
function claude {
    & "$env:USERPROFILE\claude-azure.ps1" @args
}
```

**WSL (.bashrc or .zshrc):**
```bash
# Add to ~/.bashrc or ~/.zshrc
alias claude='~/claude-azure.sh'
```

**Reload profile:**

**Windows:**
```powershell
. $PROFILE
```

**WSL:**
```bash
source ~/.bashrc
```

---

### Step 2.4: Test Claude CLI

**Both Windows and WSL:**
```bash
claude --version
```

**Expected output:**
```
Claude CLI v1.x.x
```

**Test a simple prompt:**
```bash
claude "What is 2+2?"
```

**Expected output:**
```
2 + 2 equals 4.
```

**Checkpoint:** If you get a response, Claude CLI is working!

**If you get 401 error:** See Troubleshooting section below.

---

## Part 3: Visual Studio Code Setup

### Step 3.1: Install VS Code Extension

1. Open **Visual Studio Code**
2. Go to Extensions (Ctrl+Shift+X)
3. Search for **"Claude"** (by Anthropic)
4. Click **Install**

---

### Step 3.2: Configure VS Code Extension

1. Open VS Code Settings (Ctrl+,)
2. Search for **"claude"**
3. Set these options:

| Setting | Value |
|---------|-------|
| **Claude: Provider** | `azure` |
| **Claude: Azure Endpoint** | `https://YOUR_SUBSCRIPTION_NAME.openai.azure.com` |
| **Claude: Azure Deployment** | `claude-sonnet-4-5` |
| **Claude: Auth Method** | `azure-cli` |

4. Save settings

---

### Step 3.3: Test VS Code Claude Panel

1. Open Claude panel (usually on left sidebar or Ctrl+Shift+P â†’ "Claude: Open Panel")
2. Type a message: "Hello Claude"
3. You should get a response

**Checkpoint:** Claude panel works in VS Code!

---

## Part 4: Visual Studio 2022 Setup (Optional)

### Step 4.1: Install Claude Extension (if available)

1. Open **Visual Studio 2022**
2. Go to **Extensions â†’ Manage Extensions**
3. Search for **"Claude"** or **"Anthropic"**
4. Install if available (as of 2026-07-15, this may still be in preview)

### Step 4.2: Configure (similar to VS Code)

- Set provider to **Azure**
- Set endpoint and deployment as above
- Set auth to **Azure CLI**

---

## Part 5: OpenCode Setup

### Step 5.1: Install OpenCode (if not already installed)

**Windows:**
```powershell
npm install -g @opencode/cli
```

**WSL:**
```bash
npm install -g @opencode/cli
```

---

### Step 5.2: Create OpenCode Azure Foundry Auth Plugin

**Save as: ~/.config/opencode/plugins/azure-foundry-auth.js**

See separate file: `azure-foundry-auth.js`

---

### Step 5.3: Configure OpenCode

**Edit: ~/.config/opencode/opencode.jsonc**

Add or update:

```jsonc
{
  "providers": [
    {
      "name": "azure-claude",
      "provider": "azure-openai",
      "endpoint": "https://YOUR_SUBSCRIPTION_NAME.openai.azure.com",
      "deployment": "claude-sonnet-4-5",
      "auth": "azure-cli"
    }
  ],
  
  "default_provider": "azure-claude",
  
  "plugins": [
    "./plugins/azure-foundry-auth.js"
  ]
}
```

---

### Step 5.4: Test OpenCode

**Both Windows and WSL:**
```bash
oc "What is the capital of France?"
```

**Expected output:**
```
The capital of France is Paris.
```

**Checkpoint:** OpenCode works with Azure Foundry!

---

## Troubleshooting

### Issue: `401 Principal does not have access to API/Operation`

**Cause:** Your Azure account doesn't have RBAC permissions on the AI Foundry endpoint.

**Solution:**
1. Verify you're on the correct subscription:
   ```powershell
   az account show
   ```
   Should show **YOUR_SUBSCRIPTION_NAME**.

2. If wrong subscription:
   ```powershell
   az account set --subscription "YOUR_SUBSCRIPTION_NAME"
   ```

3. If still 401, you need RBAC permissions granted. **Contact:**
   - **Your Azure Admin** (your-azure-admin@company.com) â€” Director, Platform
   - **Your Azure Admin** (your-azure-admin@company.com) â€” Director, Platform (Product Management)

4. Ask for: **"Cognitive Services User"** or **"Cognitive Services OpenAI User"** role on the AI Foundry endpoint.

---

### Issue: `az: command not found`

**Cause:** Azure CLI not in PATH.

**Solution:**

**Windows:**
```powershell
# Add to PowerShell profile
$env:Path = "C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin;" + $env:Path
```

**WSL:**
```bash
# Re-run install
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

---

### Issue: Token expires mid-session

**Cause:** Azure tokens last ~60 minutes.

**Solution:** The wrapper scripts (claude-azure.ps1 / claude-azure.sh) auto-refresh tokens. If using Claude CLI directly, re-run the wrapper.

For OpenCode, the azure-foundry-auth.js plugin auto-refreshes on every request.

---

### Issue: Claude CLI not found

**Cause:** claude.exe not in PATH or not installed.

**Solution:**

**Windows:**
```powershell
# Verify location
Test-Path "$env:USERPROFILE\.local\bin\claude.exe"

# If False, re-copy or download claude.exe
```

**WSL:**
```bash
# Verify location
ls ~/.local/bin/claude

# If missing, re-download
```

---

### Issue: OpenCode plugin not loading

**Cause:** Plugin path incorrect or syntax error in plugin file.

**Solution:**
```powershell
# Test plugin syntax (Windows)
node "$env:USERPROFILE\.config\opencode\plugins\azure-foundry-auth.js"

# Should return nothing (no errors)
```

If errors, check:
- File is valid JavaScript
- File is in plugins/ directory
- File is referenced in opencode.jsonc

---

## Summary Checklist

- [ ] Azure CLI installed (az --version works)
- [ ] Logged in to Azure (az login --use-device-code)
- [ ] Subscription set to **YOUR_SUBSCRIPTION_NAME** (az account show)
- [ ] Claude CLI installed (claude --version works)
- [ ] Wrapper script created (claude-azure.ps1 or claude-azure.sh)
- [ ] Wrapper function added to shell profile (claude command works)
- [ ] VS Code Claude extension installed and configured
- [ ] OpenCode configured with azure-claude provider
- [ ] OpenCode auth plugin created and loaded
- [ ] Tested all tools (Claude CLI, VS Code, OpenCode)

---

## Quick Reference

### Get Fresh Token Manually (for debugging)
```powershell
az account get-access-token --resource https://cognitiveservices.azure.com --query accessToken -o tsv
```

### Check Current Subscription
```powershell
az account show --query "{Name:name, SubscriptionId:id}" -o table
```

### Switch Subscription
```powershell
az account set --subscription "YOUR_SUBSCRIPTION_NAME"
```

### Test Claude CLI (with fresh token)
```powershell
claude "Hello"
```

### Test OpenCode
```powershell
oc "Hello"
```

---

## Contacts

| Issue | Contact | Email |
|-------|---------|-------|
| RBAC Permissions | Your Azure Admin | your-azure-admin@company.com |
| Azure Subscription Access | Your Azure Admin | your-azure-admin@company.com |
| IT / Software Install | IT Helpdesk | (AVD support ticket) |
| Claude CLI Issues | Your Technical Lead |
| OpenCode Setup | Joseph Perez | your-email@company.com |

---

## See Also

- ai-code-access-policy â€” your organization AI policy (Claude is approved)
- workspace-map â€” File locations for scripts and config
- [Azure AI Foundry Documentation](https://learn.microsoft.com/en-us/azure/ai-services/openai/)
- [Claude Code CLI Documentation](https://docs.anthropic.com/claude/cli)

---

**Last Updated:** 2026-07-15 (Joseph Perez)