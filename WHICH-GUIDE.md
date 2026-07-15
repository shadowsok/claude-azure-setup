---
tags: [azure, setup, claude, comparison]
aliases: [Setup Comparison]
last_updated: 2026-07-15
---

# Which Setup Guide Should I Follow?

## Quick Comparison

| Feature | Quick Start | Comprehensive Setup |
|---------|-------------|---------------------|
| **Time to complete** | 5 minutes | 30 minutes |
| **What you get** | Claude CLI only | Claude CLI + VS Code + Visual Studio + OpenCode |
| **Platform support** | Windows OR WSL | Both Windows AND WSL |
| **Token refresh** | Manual wrapper script | Automatic (OpenCode plugin) |
| **Best for** | Just want to try it | Setting up full dev environment |

---

## Decision Tree

```
Do you just want to try Claude in your terminal?
â”œâ”€ YES â†’ Quick Start (Claude-Quick-Start.md)
â””â”€ NO
    â”‚
    Do you want Claude in VS Code or OpenCode?
    â”œâ”€ YES â†’ Comprehensive Setup (Azure-AI-Foundry-Claude-Setup.md)
    â””â”€ NO â†’ Quick Start is fine
```

---

## Setup Paths by Use Case

### Use Case: "I just want to see if this works"
**Guide:** Quick Start
**Time:** 5 minutes
**You'll get:** Claude CLI in terminal
**Next step:** If you like it, come back and do Comprehensive Setup

---

### Use Case: "I want Claude in VS Code while I code"
**Guide:** Comprehensive Setup (Part 3)
**Time:** 10 minutes (if you already did Quick Start)
**You'll get:** Claude panel in VS Code sidebar
**Prerequisite:** Complete Part 1-2 (Azure CLI + Claude CLI)

---

### Use Case: "I want Claude auto-refreshing tokens in OpenCode"
**Guide:** Comprehensive Setup (Part 5)
**Time:** 10 minutes (if you already did Quick Start)
**You'll get:** OpenCode with automatic token refresh (no 401 errors)
**Prerequisite:** Complete Part 1-2, have OpenCode installed

---

### Use Case: "I want it all â€” CLI, VS Code, OpenCode, Visual Studio"
**Guide:** Comprehensive Setup (all parts)
**Time:** 30 minutes
**You'll get:** Claude everywhere
**Prerequisite:** Admin rights (or ability to request installs via IT)

---

### Use Case: "I'm getting 401 errors and nothing works"
**Guide:** Troubleshooting Flowchart
**Time:** 5-10 minutes to diagnose, longer to fix (depends on RBAC approval)
**You'll get:** Clear diagnosis of the problem + who to contact

---

## By Role

### Developers (Full Stack, Backend, Frontend)
**Recommended:** Comprehensive Setup
**Why:** You'll want Claude in VS Code for inline coding assistance, and OpenCode for command-line workflows

### QA Engineers
**Recommended:** Quick Start, then add VS Code (Part 3) if you like it
**Why:** Quick Start gets you CLI for generating test cases, VS Code gives you panel for test documentation

### Architects / Tech Leads
**Recommended:** Comprehensive Setup
**Why:** You'll use Claude across multiple contexts (design docs, code review, architecture questions)

### DevOps / Platform Engineers
**Recommended:** Quick Start + OpenCode (Part 5)
**Why:** You live in the terminal, OpenCode is your primary workflow

---

## By Operating System Preference

### I use Windows PowerShell primarily
**Recommended:** Quick Start first, then Comprehensive Setup if you want more
**Scripts you need:** `claude-azure.ps1`

### I use WSL primarily
**Recommended:** Quick Start first, then Comprehensive Setup if you want more
**Scripts you need:** `claude-azure.sh`

### I switch between Windows and WSL
**Recommended:** Comprehensive Setup (covers both)
**Scripts you need:** Both `claude-azure.ps1` AND `claude-azure.sh`

---

## Prerequisites Checklist

Before starting ANY guide, make sure you have:

- [ ] AVD machine access
- [ ] your organization email account (v-*@your organization.com)
- [ ] Ability to install software (or submit IT ticket)
- [ ] Access to **YOUR_SUBSCRIPTION_NAME** Azure subscription (verify with: `az account list`)

**If you DON'T have YOUR_SUBSCRIPTION_NAME access:** Stop. Contact Your Azure Admin or Your Azure Admin FIRST.

---

## What If I Already Started One Guide?

### I did Quick Start, now I want VS Code
**Next:** Jump to Comprehensive Setup, Part 3 (VS Code Setup)
**Skip:** Parts 1-2 (you already have Azure CLI + Claude CLI)

### I did Quick Start, now I want OpenCode
**Next:** Jump to Comprehensive Setup, Part 5 (OpenCode Setup)
**Skip:** Parts 1-2 (you already have Azure CLI + Claude CLI)

### I did Comprehensive Setup on Windows, now I want WSL
**Next:** 
1. Install Azure CLI in WSL (Part 1.1, WSL section)
2. Run `az login` in WSL (Part 1.2)
3. Copy `claude-azure.sh` to `~/claude-azure.sh` (Part 2.2)
4. Add alias to `~/.bashrc` (Part 2.3)

---

## Support Matrix

| Tool | Quick Start | Comprehensive Setup |
|------|-------------|---------------------|
| Azure CLI | âœ… | âœ… |
| Claude CLI | âœ… | âœ… |
| Auto token refresh (CLI) | âœ… (manual script) | âœ… (manual script) |
| VS Code Claude panel | âŒ | âœ… |
| Visual Studio 2022 Claude | âŒ | âœ… (optional) |
| OpenCode integration | âŒ | âœ… |
| Auto token refresh (OpenCode) | âŒ | âœ… (plugin) |
| WSL instructions | âœ… (basic) | âœ… (complete) |
| Troubleshooting | âŒ (see separate doc) | âœ… (embedded) |

---

## Still Not Sure?

**Default recommendation:** Start with **Quick Start**. If you like it and want more, come back and do the relevant parts of Comprehensive Setup.

**Question?** Ask in team chat or ping Joseph (your-email@company.com).

---

**Last Updated:** 2026-07-15 (Joseph Perez)