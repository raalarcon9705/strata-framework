#!/bin/bash
# Strata Framework Installer
# Install Strata Framework in your project from GitHub

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
# Try to detect repository from git remote, or use default
if [ -d ".git" ] && git remote get-url origin >/dev/null 2>&1; then
    DEFAULT_REPO=$(git remote get-url origin 2>/dev/null | sed 's/\.git$//' | sed 's/^git@github\.com:/https:\/\/github.com\//' || echo "")
    STRATA_REPO="${STRATA_REPO:-${DEFAULT_REPO:-https://github.com/raalarcon9705/strata-framework.git}}"
else
    STRATA_REPO="${STRATA_REPO:-https://github.com/raalarcon9705/strata-framework.git}"
fi
STRATA_BRANCH="${STRATA_BRANCH:-main}"
INSTALL_DIR="${INSTALL_DIR:-.}"

# Functions
print_error() {
    echo -e "${RED}❌ Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check dependencies
check_dependencies() {
    print_info "Checking dependencies..."
    
    local missing_deps=()
    
    if ! command_exists git; then
        missing_deps+=("git")
    fi
    
    if ! command_exists jq; then
        missing_deps+=("jq")
    fi
    
    if [ ${#missing_deps[@]} -gt 0 ]; then
        print_error "Missing required dependencies: ${missing_deps[*]}"
        echo ""
        echo "Install them with:"
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "  brew install ${missing_deps[*]}"
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            echo "  sudo apt-get install ${missing_deps[*]}  # Debian/Ubuntu"
            echo "  sudo yum install ${missing_deps[*]}      # RHEL/CentOS"
        fi
        exit 1
    fi
    
    print_success "All dependencies installed"
}

# Main installation function
install_strata() {
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🚀 Strata Framework Installer"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    # Check dependencies
    check_dependencies
    
    # Show repository information
    echo ""
    print_info "Repository: $STRATA_REPO"
    print_info "Branch: $STRATA_BRANCH"
    if [[ "$STRATA_REPO" == *"raalarcon9705"* ]]; then
        print_warning "Using default repository URL. Please set STRATA_REPO environment variable or use --repo flag."
        echo ""
        read -p "Continue with default? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_error "Installation cancelled. Set STRATA_REPO or use --repo flag."
            exit 1
        fi
    fi
    echo ""
    
    # Determine installation directory
    if [ "$INSTALL_DIR" = "." ]; then
        INSTALL_DIR="$(pwd)"
        print_info "Installing in current directory: $INSTALL_DIR"
    else
        if [ -d "$INSTALL_DIR" ]; then
            print_warning "Directory $INSTALL_DIR already exists"
            read -p "Continue anyway? (y/n): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_error "Installation cancelled"
                exit 1
            fi
        else
            mkdir -p "$INSTALL_DIR"
            print_info "Created directory: $INSTALL_DIR"
        fi
    fi
    
    # Check if directory is empty or has git
    if [ -d "$INSTALL_DIR/.git" ]; then
        print_info "Git repository detected in $INSTALL_DIR"
        cd "$INSTALL_DIR"
    elif [ "$(ls -A $INSTALL_DIR 2>/dev/null)" ]; then
        print_warning "Directory $INSTALL_DIR is not empty"
        read -p "Continue installation? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_error "Installation cancelled"
            exit 1
        fi
        cd "$INSTALL_DIR"
    else
        cd "$INSTALL_DIR"
    fi
    
    # Download or clone Strata files
    print_info "Downloading Strata Framework files..."
    
    # Create temporary directory
    TEMP_DIR=$(mktemp -d)
    trap "rm -rf $TEMP_DIR" EXIT
    
    # Try to clone the repository
    if git clone --depth 1 --branch "$STRATA_BRANCH" "$STRATA_REPO" "$TEMP_DIR/strata" 2>/dev/null; then
        print_success "Repository cloned successfully"
        
        # Copy essential files
        print_info "Copying Strata Framework files..."
        
        # Copy strata.sh
        if [ -f "$TEMP_DIR/strata/strata.sh" ]; then
            cp "$TEMP_DIR/strata/strata.sh" .
            chmod +x strata.sh
            print_success "Copied strata.sh"
        fi
        
        # Copy scripts directory
        if [ -d "$TEMP_DIR/strata/scripts" ]; then
            cp -r "$TEMP_DIR/strata/scripts" .
            find scripts -type f -name "*.sh" -exec chmod +x {} \;
            print_success "Copied scripts directory"
        fi
        
        # Copy docs directory
        if [ -d "$TEMP_DIR/strata/docs" ]; then
            cp -r "$TEMP_DIR/strata/docs" .
            print_success "Copied docs directory"
        fi
        
        # Copy .cursor directory (rules and commands only)
        if [ -d "$TEMP_DIR/strata/.cursor" ]; then
            mkdir -p .cursor
            if [ -d "$TEMP_DIR/strata/.cursor/rules" ]; then
                cp -r "$TEMP_DIR/strata/.cursor/rules" .cursor/
                print_success "Copied .cursor/rules"
            fi
            if [ -d "$TEMP_DIR/strata/.cursor/commands" ]; then
                cp -r "$TEMP_DIR/strata/.cursor/commands" .cursor/
                print_success "Copied .cursor/commands"
            fi
        fi
        
    else
        print_error "Failed to clone repository: $STRATA_REPO"
        print_info "Make sure the repository URL is correct and accessible"
        exit 1
    fi
    
    # Initialize git if not already initialized
    if [ ! -d ".git" ]; then
        print_info "Initializing git repository..."
        git init
        print_success "Git repository initialized"
    fi
    
    # Run strata.sh to set up the framework
    if [ -f "strata.sh" ]; then
        print_info "Running Strata setup script..."
        echo ""
        bash strata.sh
        print_success "Strata Framework setup completed"
    else
        print_error "strata.sh not found after installation"
        exit 1
    fi
    
    # Configure .gitignore if it exists
    if [ -f ".gitignore" ]; then
        print_info "Configuring .gitignore for Strata Framework..."
        # The strata.sh script should handle this, but we verify
        if grep -q "# Ignore all .cursor/" .gitignore 2>/dev/null; then
            print_success ".gitignore already configured"
        else
            print_warning ".gitignore exists but Strata patterns not found"
            print_info "Run 'bash strata.sh' again to configure .gitignore"
        fi
    fi
    
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    print_success "Strata Framework installed successfully!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "📋 Next steps:"
    echo ""
    echo "1. Review your stories in: docs/specs/stories.json"
    echo "2. Start the autopilot: ./scripts/sdd/autopilot.sh"
    echo "3. Or use manual mode with Cursor commands:"
    echo "   - /prime   - Load story and context"
    echo "   - /plan    - Generate plan"
    echo "   - /execute - Execute the plan"
    echo ""
    echo "📖 Read the framework documentation: docs/strata_framework.md"
    echo ""
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --repo)
            STRATA_REPO="$2"
            shift 2
            ;;
        --branch)
            STRATA_BRANCH="$2"
            shift 2
            ;;
        --dir)
            INSTALL_DIR="$2"
            shift 2
            ;;
        -h|--help)
            echo "Strata Framework Installer"
            echo ""
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --repo URL      GitHub repository URL (default: https://github.com/raalarcon9705/strata-test.git)"
            echo "  --branch BRANCH Branch to clone (default: main)"
            echo "  --dir DIR       Installation directory (default: current directory)"
            echo "  -h, --help      Show this help message"
            echo ""
            echo "Environment variables:"
            echo "  STRATA_REPO     Same as --repo"
            echo "  STRATA_BRANCH   Same as --branch"
            echo "  INSTALL_DIR     Same as --dir"
            echo ""
            echo "Examples:"
            echo "  # Install in current directory"
            echo "  bash <(curl -s https://raw.githubusercontent.com/user/repo/main/install.sh)"
            echo ""
            echo "  # Install in specific directory"
            echo "  bash <(curl -s https://raw.githubusercontent.com/user/repo/main/install.sh) --dir ./my-project"
            echo ""
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Run installation
install_strata
