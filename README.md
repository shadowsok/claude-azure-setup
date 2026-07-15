# Azure AI Foundry + Claude Setup

Comprehensive guides for setting up **Claude via Azure AI Foundry** with automatic token refresh.

## 🚀 Quick Links

- **Just want it working NOW?** → [5-Minute Quick Start](Claude-Quick-Start.md)
- **Want full setup (VS Code, OpenCode, etc.)?** → [Comprehensive Setup Guide](Azure-AI-Foundry-Claude-Setup.md)
- **Getting errors?** → [Troubleshooting Flowchart](Troubleshooting-Flowchart.md)
- **Not sure which to follow?** → [Which Guide Should I Use?](WHICH-GUIDE.md)

## 📚 What's Included

| Guide | Time | What You Get |
|-------|------|--------------|
| **[Quick Start](Claude-Quick-Start.md)** | 5 min | Claude CLI in terminal |
| **[Comprehensive Setup](Azure-AI-Foundry-Claude-Setup.md)** | 30 min | CLI + VS Code + OpenCode + Visual Studio 2022 |
| **[Troubleshooting](Troubleshooting-Flowchart.md)** | As needed | Visual flowcharts for common issues |
| **[Which Guide?](WHICH-GUIDE.md)** | 2 min | Decision tree to pick the right path |

## 🛠️ Scripts Included

All scripts include **automatic Azure token refresh** (no more 401 errors after 60 minutes):

- **`claude-azure.ps1`** - Windows PowerShell wrapper
- **`claude-azure.sh`** - WSL/Linux bash wrapper
- **`azure-foundry-auth.js`** - OpenCode plugin

## ✅ What This Solves

- ❌ **401 Principal does not have access to API/Operation**
- ❌ Token expires after 60 minutes
- ❌ Manual token refresh every hour
- ❌ Confusing Azure authentication

✅ **After setup:** Claude works everywhere, tokens auto-refresh, no more 401 errors.

## 📋 Prerequisites

- Azure subscription with access to Azure AI Foundry endpoint
- Azure CLI installed
- RBAC permissions (Cognitive Services User role)
- Claude CLI binary

## 🎯 Platforms Supported

- ✅ Windows (PowerShell)
- ✅ WSL (Ubuntu/Debian)
- ✅ Visual Studio Code
- ✅ Visual Studio 2022
- ✅ OpenCode

## 📖 Quick Start (5 Minutes)

```powershell
# 1. Install Azure CLI
winget install -e --id Microsoft.AzureCLI

# 2. Login
az login --use-device-code

# 3. Set subscription (replace with your subscription name)
az account set --subscription "YourSubscriptionName"

# 4. Get the wrapper script (claude-azure.ps1 or claude-azure.sh)

# 5. Add to your shell profile and test
claude "Hello!"
```

See [Claude-Quick-Start.md](Claude-Quick-Start.md) for detailed steps.

## 🤝 Contributing

Found an issue or have an improvement? PRs welcome!

1. Fork this repo
2. Make your changes
3. Test on your environment
4. Submit a PR

## 📄 License

MIT License - feel free to use, modify, and distribute.

## 🙏 Credits

Created to solve Azure AI Foundry authentication challenges for teams using Claude CLI.

---

**Last Updated:** 2026-07-15