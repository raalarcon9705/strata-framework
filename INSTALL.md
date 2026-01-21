# 📦 Installation Guide

## Quick Install

Install Strata Framework directly from GitHub:

```bash
bash <(curl -s https://raw.githubusercontent.com/raalarcon9705/strata-test/main/install.sh)
```

**⚠️ Important**: Replace `raalarcon9705` with your GitHub username and `strata-test` with your repository name.

## Installation Options

### Install in Current Directory

```bash
bash <(curl -s https://raw.githubusercontent.com/raalarcon9705/strata-test/main/install.sh)
```

### Install in Specific Directory

```bash
bash <(curl -s https://raw.githubusercontent.com/raalarcon9705/strata-test/main/install.sh) --dir ./my-project
```

### Using Environment Variables

```bash
export STRATA_REPO="https://github.com/raalarcon9705/strata-test.git"
export STRATA_BRANCH="main"
export INSTALL_DIR="./my-project"
bash <(curl -s https://raw.githubusercontent.com/raalarcon9705/strata-test/main/install.sh)
```

## Manual Installation

If you prefer to clone the repository manually:

```bash
# Clone the repository
git clone https://github.com/raalarcon9705/strata-test.git
cd strata-test

# Run the setup script
bash strata.sh
```

## Requirements

Before installing, ensure you have:

- **Git** - Version control
- **jq** - JSON processor (required for autopilot)
- **Bash** - Shell environment

### Installing Dependencies

#### macOS

```bash
brew install jq
```

#### Linux (Debian/Ubuntu)

```bash
sudo apt-get update
sudo apt-get install jq
```

#### Linux (RHEL/CentOS)

```bash
sudo yum install jq
```

## What Gets Installed

The installer will:

1. ✅ Check for required dependencies (git, jq)
2. ✅ Clone/download Strata Framework files
3. ✅ Copy essential files:
   - `strata.sh` - Main setup script
   - `scripts/sdd/autopilot.sh` - PPRE cycle automation
   - `docs/` - Documentation and specifications
   - `.cursor/rules/` - Cursor rules (tracked in git)
   - `.cursor/commands/` - Cursor commands (tracked in git)
4. ✅ Initialize git repository (if not already initialized)
5. ✅ Run `strata.sh` to complete setup
6. ✅ Configure `.gitignore` for Strata Framework

## Post-Installation

After installation:

1. **Review your stories**: Edit `docs/specs/stories.json`
2. **Start the autopilot**: Run `./scripts/sdd/autopilot.sh`
3. **Or use manual mode**: Use Cursor commands `/prime`, `/plan`, `/execute`

## Troubleshooting

### "jq: command not found"

Install jq using the instructions above for your operating system.

### "git: command not found"

Install git:
- macOS: `brew install git`
- Linux: `sudo apt-get install git` or `sudo yum install git`

### "Permission denied"

Make scripts executable:
```bash
chmod +x strata.sh
chmod +x scripts/sdd/autopilot.sh
```

### Repository not found

Make sure:
1. The repository URL is correct
2. The repository is public (or you have access)
3. You've replaced `raalarcon9705` with your actual GitHub username

## Updating Strata

To update Strata Framework in an existing project:

```bash
# Pull latest changes
git pull origin main

# Re-run setup if needed
bash strata.sh
```

## Uninstalling

To remove Strata Framework:

```bash
# Remove Strata-specific files
rm -rf scripts/sdd/
rm -rf docs/specs/
rm -rf docs/reference/
rm -rf .cursor/rules/
rm -rf .cursor/commands/
rm -f strata.sh

# Remove from .gitignore (optional)
# Edit .gitignore and remove Strata Framework sections
```

## Support

For issues or questions:
- Check `docs/strata_framework.md` for framework documentation
- Review `README.md` for usage instructions
- Open an issue on GitHub
