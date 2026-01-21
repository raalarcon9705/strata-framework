# 🏗️ Strata Framework

**Compounding Agentic Engineering Framework** - Transform your development workflow from a linear "Feature Factory" to an Exponential System Evolution model.

## 🚀 Quick Start

### Installation

**⚠️ Before installing**: Replace `raalarcon9705` with your GitHub username and `strata-test` with your repository name in the commands below.

Install Strata Framework in your project with a single command:

```bash
bash <(curl -s https://raw.githubusercontent.com/raalarcon9705/strata-test/main/install.sh)
```

Or install in a specific directory:

```bash
bash <(curl -s https://raw.githubusercontent.com/raalarcon9705/strata-test/main/install.sh) --dir ./my-project
```

**Alternative**: Set the repository URL as an environment variable:

```bash
export STRATA_REPO="https://github.com/raalarcon9705/strata-test.git"
bash <(curl -s https://raw.githubusercontent.com/raalarcon9705/strata-test/main/install.sh)
```

For more installation options, see [INSTALL.md](INSTALL.md).

### Requirements

- **Git** - For version control and commits
- **jq** - For JSON processing in autopilot
- **Bash** - For running scripts

Install dependencies:

```bash
# macOS
brew install jq

# Linux (Debian/Ubuntu)
sudo apt-get install jq

# Linux (RHEL/CentOS)
sudo yum install jq
```

## 📖 What is Strata?

Strata is a **Spec-Driven Development** framework that enforces:

1. **Zero Hallucination** - No code without approved specifications
2. **Atomic Execution** - Binary verifiable units (Atoms)
3. **Compounding Context** - Every lesson learned is codified
4. **PPRE Cycle** - PRIME → PLAN → RESET → EXECUTE workflow

## 🎯 Two Ways to Work

### 1️⃣ Autopilot Mode (Recommended)

Run the interactive autopilot that guides you through the PPRE cycle:

```bash
./scripts/sdd/autopilot.sh
```

The autopilot will:
- Load stories from `docs/specs/stories.json`
- Guide you through PRIME → PLAN → RESET → EXECUTE phases
- Verify acceptance criteria
- Commit completed stories

### 2️⃣ Manual Mode with Cursor Commands

Use Cursor's command system:

- `/prime` - Load story and context
- `/plan` - Generate implementation plan (saved to `.strata/plan.md`)
- `/execute` - Execute the plan (reads from `.strata/plan.md`)

## 📂 Project Structure

```
.
├── .cursor/
│   ├── rules/
│   │   └── global.mdc          # Global rules (tracked in git)
│   └── commands/                # Cursor commands (tracked in git)
├── docs/
│   ├── specs/
│   │   ├── stories.json        # Atomic tasks with acceptance criteria
│   │   └── prd.md              # Product Requirements Document
│   ├── reference/              # Context sharding layer
│   └── strata_framework.md     # Framework documentation
├── scripts/
│   └── sdd/
│       └── autopilot.sh        # PPRE cycle automation
├── src/
│   └── **/agents.md            # Fractal memory (tactical knowledge)
└── logs/
    └── progress.txt            # Short-term memory
```

## 🔄 The PPRE Cycle

1. **PRIME** - Load current story and context
2. **PLAN** - Generate implementation plan (human approval required)
3. **RESET** - Clear context window (prevents "Context Rot")
4. **EXECUTE** - Implement code based on approved plan
5. **VERIFY** - Self-verify against acceptance criteria
6. **COMMIT** - Mark story complete and commit

## 📝 Creating Stories

Edit `docs/specs/stories.json`:

```json
{
  "epic": "Feature Name",
  "status": "active",
  "stories": [
    {
      "id": "FEAT-001",
      "description": "Implement user authentication",
      "files_to_touch": [
        "src/auth/login.ts",
        "src/auth/register.ts"
      ],
      "acceptance_criteria": [
        "User can log in with email and password",
        "User can register new account",
        "Authentication tokens are stored securely"
      ],
      "passes": false
    }
  ]
}
```

## 🧠 System Evolution (The Golden Rule)

> **Mandate**: If you fix a bug manually and do not update a `.md` file, you have failed the protocol. The system has not learned.

- **Logic Error?** → Update relevant `src/**/agents.md`
- **Style/Pattern Error?** → Update `.cursor/rules/global.mdc`
- **Process Error?** → Update `docs/reference/workflow.md`

## 🔧 Configuration

### .gitignore

The installer automatically configures `.gitignore` to:
- Track `.cursor/rules/` and `.cursor/commands/`
- Ignore other Cursor configurations
- Include Strata Framework patterns

### Customization

- **Global Rules**: Edit `.cursor/rules/global.mdc`
- **Stories**: Edit `docs/specs/stories.json`
- **Reference Docs**: Add files to `docs/reference/`

## 📚 Documentation

- **Framework Reference**: `docs/strata_framework.md`
- **API Guidelines**: `docs/reference/api_guidelines.md`
- **Database Schema**: `docs/reference/db_schema.md`
- **UI Patterns**: `docs/reference/ui_patterns.md`

## 🤝 Contributing

1. Follow the PPRE cycle
2. Document lessons learned in `agents.md`
3. Update specifications before writing code
4. Verify all acceptance criteria pass

## 📄 License

[Add your license here]

## 🙏 Acknowledgments

Strata Framework - Compounding Agentic Engineering
