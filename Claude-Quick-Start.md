---
tags: [azure, claude, quickstart, setup]
aliases: [Claude Quick Start]
last_updated: 2026-07-15
---

# Claude via Azure Foundry â€” Quick Start (5 Minutes)

**Goal:** Get Claude running in your terminal ASAP.

---

## Step 1: Install Azure CLI (1 minute)

**Windows:**
```powershell
winget install -e --id Microsoft.AzureCLI
```

**WSL:**
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

---

## Step 2: Login to Azure (1 minute)

```powershell
az login --use-device-code
```

Follow the prompts. Use your Azure AD organizational account.

---

## Step 3: Set Subscription (30 seconds)

```powershell
az account set --subscription "YOUR_SUBSCRIPTION_NAME"
az account show
```

You should see **YOUR_SUBSCRIPTION_NAME**.

---

## Step 4: Get the Scripts (30 seconds)

# Windows
Copy-Item "
# WSL
cp /mnt/avd-share/claude-setup/* ~/
```

**Option B: Download from this repo:**
- `claude-azure.ps1` (Windows)
- `claude-azure.sh` (WSL)

Save to:
- Windows: `C:\Users\<you>\claude-azure.ps1`
- WSL: `~/claude-azure.sh`

---

## Step 5: Add to Profile (1 minute)

**Windows (PowerShell):**
```powershell
code $PROFILE
```

Add these lines:
```powershell
$env:Path = "$env:USERPROFILE\.local\bin;" + $env:Path

function claude {
    & "$env:USERPROFILE\claude-azure.ps1" @args
}
```

Save and close. Then:
```powershell
. $PROFILE
```

**WSL (bash):**
```bash
nano ~/.bashrc
```

Add:
```bash
export PATH="$HOME/.local/bin:$PATH"
alias claude='~/claude-azure.sh'
```

Save (Ctrl+O, Enter, Ctrl+X). Then:
```bash
source ~/.bashrc
chmod +x ~/claude-azure.sh
```

---

## Step 6: Test It (30 seconds)

```bash
claude "What is 2+2?"
```

**Expected:**
```
2 + 2 equals 4.
```

---

## Troubleshooting

### Get 401 error?

You don't have permissions. Contact:
- **Your Azure Admin** (your-azure-admin@company.com)
- **Your Azure Admin** (your-azure-admin@company.com)

Ask for **"Cognitive Services User"** role on **YOUR_SUBSCRIPTION_NAME**.

### `az: command not found`?

Azure CLI not in PATH. Close and reopen your terminal, or:

**Windows:**
```powershell
$env:Path = "C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin;" + $env:Path
```

**WSL:**
```bash
export PATH="/usr/bin:$PATH"
```

### `claude: command not found`?

You didn't reload your profile. Run:

**Windows:**
```powershell
. $PROFILE
```

**WSL:**
```bash
source ~/.bashrc
```

---

## Next Steps

Once this works, you can set up:
- **VS Code Claude panel** (see full guide)
- **OpenCode with auto token refresh** (see full guide)
- **Visual Studio 2022 inline Claude** (see full guide)

See: `Azure-AI-Foundry-Claude-Setup.md` for comprehensive setup.

---

**Done!** You now have Claude running via Azure Foundry.