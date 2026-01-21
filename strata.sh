# 1. Directory Setup
# 1. Create Exact Directory Tree
mkdir -p .cursor/rules \
         .cursor/commands \
         logs \
         scripts/sdd \
         docs/specs \
         docs/reference \
         docs/done_specs \
         src/components

# 2. Global Constitution (.cursor/rules/global.mdc)
cat << 'EOF' > .cursor/rules/global.mdc
---
alwaysApply: true
---
YOU MUST FOLLOW THE ARCHITECTURE AND WORKFLOWS DEFINED IN `docs/strata_framework.md`.

# 🏗️ Strata Constitution

1. **Zero Hallucination:** You DO NOT invent features or APIs. Use only provided documentation.
2. **PPRE Cycle Only:** You must follow PRIME → PLAN → RESET → EXECUTE for every task.
3. **Atomic Execution:** Complete one story from `stories.json` at a time. Do not move to the next until `passes: true`.
4. **Disk-Based Brain:** If you learn a tactical lesson or fix a bug, you MUST document it in the relevant `agents.md` file immediately.
5. **No Vibe Coding:** If requirements are ambiguous, ask for clarification before writing code.
6. **Context Hygiene:** Keep chat history clean. Request a RESET (Cmd+K) after the PLAN phase.

## 📂 Source of Truth
- **Requirements:** `docs/specs/stories.json`
- **Memory:** `src/scripts/agents.md` (or relevant directory `agents.md`)
EOF

# 3. Strata Framework Reference (docs/strata_framework.md)
cat << 'EOF' > docs/strata_framework.md
# 📖 Strata Framework Reference

## 1. Philosophy: Compounding Agentic Engineering
This project shifts development from a linear "Feature Factory" model to an **Exponential System Evolution** model.

* **Spec-Driven Development**: No code is written without a rigorous, approved specification in `docs/specs/prd.md`.
* **Atomic Execution**: Work is broken down into binary units (Atoms) verifiable by scripts.
* **Compounding Context**: Every bug fixed or lesson learned must be "codified" into the system's memory via `global.mdc` or `agents.md`.

## 2. The PPRE Execution Loop
Agents must strictly follow the **PPRE Cycle** to maintain intelligence and avoid context decay.

1. **PRIME**: Load only the current story from `stories.json` and relevant reference docs.
2. **PLAN**: Generate a specific implementation plan. Human reviews and approves the plan before any code is written.
3. **RESET (The Kill Switch)**: **Critical.** Clear the context window/chat history (Cmd+K/Ctrl+K). This prevents "Context Rot".
4. **EXECUTE**: Write code based strictly on the approved Plan and Story constraints.
5. **VERIFY**: Agent checks its own code against binary `acceptance_criteria`.
6. **COMMIT**: If criteria pass, set `"passes": true` in `stories.json`, log to `progress.txt`, and perform a Git commit.

## 3. Directory Topology & Component Roles
* **`.cursor/rules/global.mdc`**: The Constitution. Universal tech stack and high-level rules.
* **`docs/specs/stories.json`**: The Execution Contract. Atomic tasks with binary pass/fail criteria.
* **`docs/reference/`**: Context Sharding Layer. Loaded on-demand.
* **`src/**/agents.md`**: Fractal Memory. Tactical knowledge and local conventions.
* **`logs/progress.txt`**: Short-Term Memory. Logs session-level continuity.

## 4. System Evolution (The Golden Rule)
> **Mandate**: If you fix a bug manually and do not update a `.md` file, you have failed the protocol. The system has not learned.

* **Logic Error?** → Update relevant `src/**/agents.md`.
* **Style/Pattern Error?** → Update `.cursor/rules/global.mdc`.
* **Process Error?** → Update `docs/reference/workflow.md`.
EOF

# 4. PRD Template (docs/specs/prd.md)
cat << 'EOF' > docs/specs/prd.md
# 📄 Product Requirements Document (PRD)
## 1. Mission
## 2. Technical Architecture
## 3. Data Dictionary
## 4. Implementation Plan
EOF

# 5. Input Contract (docs/specs/stories.json)
cat << 'EOF' > docs/specs/stories.json
{
  "epic": "System Initialization",
  "status": "active",
  "stories": [
    {
      "id": "INIT-000",
      "description": "Check that the Strata Autopilot exists and is executable",
      "files_to_touch": [
        "scripts/sdd/autopilot.sh"
      ],
      "acceptance_criteria": [
        "File 'scripts/sdd/autopilot.sh' exists",
        "The file has the correct permissions",
        "The script has a correct syntax"
      ],
      "passes": false
    },
    {
      "id": "INIT-001",
      "description": "Strata Hello World",
      "files_to_touch": [
        "src/scripts/hello_strata.ts",
        "package.json"
      ],
      "acceptance_criteria": [
        "File 'src/scripts/hello_strata.ts' exists",
        "The script prints exactly: 'Strata Agentic Engine: ONLINE'",
        "A 'package.json' script 'start:strata' runs this file",
        "Running 'npm run start:strata' succeeds without errors"
      ],
      "passes": false
    }
  ]
}
EOF

# 6. Create Context Sharding Layer (Reference Docs)
touch docs/reference/api_guidelines.md \
      docs/reference/db_schema.md \
      docs/reference/ui_patterns.md

# 7. Initial Agent Memory (src/components/agents.md)
cat << 'EOF' > src/components/agents.md
# 🧠 Agent Memory: Components Layer
## ⚠️ Critical Lessons
- [2026-01-21]: Initialized Strata Dev Framework.
EOF

# 8. Official Autopilot Engine (scripts/sdd/autopilot.sh)
cat << 'EOF' > scripts/sdd/autopilot.sh
#!/bin/bash
# --- Strata Autopilot Engine ---
# Strictly follows PPRE Cycle from docs/strata_framework.md

# --- PART 1: CONFIGURATION & SETUP ---
SPECS_FILE="docs/specs/stories.json"
PROGRESS_FILE="logs/progress.txt"
MEMORY_FILE="src/components/agents.md"
REFERENCE_DIR="docs/reference"
GLOBAL_RULES=".cursor/rules/global.mdc"
STRATA_DIR=".strata"

# Create necessary directories if they don't exist
mkdir -p "$STRATA_DIR"
mkdir -p "$(dirname "$PROGRESS_FILE")"

# Create progress.txt if it doesn't exist
touch "$PROGRESS_FILE"

if ! command -v jq &> /dev/null; then
    echo "❌ Error: 'jq' is not installed. Run 'brew install jq'."
    exit 1
fi

# --- FUNCTIONS (MUST BE DEFINED BEFORE USE) ---
# Interactive menu function - returns selected index (0-based)
interactive_menu() {
    local title="$1"
    shift
    local items=("$@")
    # Always start at first option (index 0)
    local current=0
    local i
    local key
    local key2
    
    # Ensure we start fresh - reset any potential global state
    current=0
    
    # Clear screen before starting
    clear
    
    # Hide cursor
    tput civis
    
    while true; do
        # Clear screen and show title (redirect to tty to avoid capturing in $())
        clear
        echo "$title" >/dev/tty
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >/dev/tty
        echo "" >/dev/tty
        echo "Use ↑↓ arrows to navigate, ENTER to select" >/dev/tty
        echo "" >/dev/tty
        
        # Display items (redirect to tty to avoid capturing in $())
        for i in "${!items[@]}"; do
            if [ $i -eq $current ]; then
                # Highlighted item
                echo "  ▶ ${items[$i]}" >/dev/tty
            else
                # Normal item
                echo "    ${items[$i]}" >/dev/tty
            fi
        done
        
        echo "" >/dev/tty
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" >/dev/tty
        
        # Read key - use IFS= to preserve space character
        key=""
        IFS= read -rsn1 key 2>/dev/null || key=""
        
        # Check for escape sequence (arrow keys) - must check first
        if [ "$key" = $'\x1b' ]; then
            key2=""
            read -rsn2 key2 2>/dev/null || key2=""
            case "$key2" in
                '[A')  # Up arrow
                    if [ $current -gt 0 ]; then
                        ((current--))
                    fi
                    ;;
                '[B')  # Down arrow
                    if [ $current -lt $((${#items[@]} - 1)) ]; then
                        ((current++))
                    fi
                    ;;
            esac
            continue
        fi
        
        # Check for Enter (empty string, newline, or carriage return)
        if [ -z "$key" ] || [ "$key" = $'\n' ] || [ "$key" = $'\r' ]; then
            # Enter to confirm selection
            break
        fi
    done
    
    # Show cursor
    tput cnorm
    
    # Return selected index (0-based)
    echo $current
}

# Function to map phase name to output file
get_output_file() {
    local phase_name="$1"
    case "$phase_name" in
        "PRIME"|"context")
            echo "$STRATA_DIR/context.md"
            ;;
        "PLAN"|"plan")
            echo "$STRATA_DIR/plan.md"
            ;;
        "EXECUTE"|"execute")
            echo "$STRATA_DIR/execute.md"
            ;;
        *)
            # Default: lowercase phase name
            echo "$STRATA_DIR/$(echo "$phase_name" | tr '[:upper:]' '[:lower:]').md"
            ;;
    esac
}

# Interactive checklist function - returns count of selected items via global variable
CHECKLIST_SELECTED_COUNT=0
interactive_checklist() {
    local title="$1"
    shift
    local items=("$@")
    local selected=()
    local current=0
    local i
    
    # Initialize all items as unchecked
    for i in "${!items[@]}"; do
        selected[$i]=0
    done
    
    # Hide cursor
    tput civis
    
    while true; do
        # Clear screen and show title
        clear
        echo "$title"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "Use ↑↓ arrows to navigate, SPACE to toggle, ENTER to confirm"
        echo ""
        
        # Display items
        for i in "${!items[@]}"; do
            if [ $i -eq $current ]; then
                # Highlighted item
                if [ ${selected[$i]} -eq 1 ]; then
                    echo "  ▶ [✓] ${items[$i]}"
                else
                    echo "  ▶ [ ] ${items[$i]}"
                fi
            else
                # Normal item
                if [ ${selected[$i]} -eq 1 ]; then
                    echo "    [✓] ${items[$i]}"
                else
                    echo "    [ ] ${items[$i]}"
                fi
            fi
        done
        
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        
        # Read key - use IFS= to preserve space character
        IFS= read -rsn1 key 2>/dev/null || key=""
        
        # Check for escape sequence (arrow keys) - must check first
        if [ "$key" = $'\x1b' ]; then
            read -rsn2 key 2>/dev/null
            case "$key" in
                '[A')  # Up arrow
                    if [ $current -gt 0 ]; then
                        ((current--))
                    fi
                    continue
                    ;;
                '[B')  # Down arrow
                    if [ $current -lt $((${#items[@]} - 1)) ]; then
                        ((current++))
                    fi
                    continue
                    ;;
            esac
        fi
        
        # Check for space to toggle
        if [ "$key" = " " ]; then
            # Toggle selected state
            if [ ${selected[$current]} -eq 1 ]; then
                selected[$current]=0
            else
                selected[$current]=1
            fi
            continue
        fi
        
        # Check for Enter (empty string, newline, or carriage return)
        if [ -z "$key" ] || [ "$key" = $'\n' ] || [ "$key" = $'\r' ]; then
            # Enter to confirm selection
            break
        fi
    done
    
    # Show cursor
    tput cnorm
    
    # Count selected items
    CHECKLIST_SELECTED_COUNT=0
    for i in "${!selected[@]}"; do
        if [ ${selected[$i]} -eq 1 ]; then
            ((CHECKLIST_SELECTED_COUNT++))
        fi
    done
}

# Function to run agent prompt (automatic) or display prompt (manual)
run_agent_prompt() {
    local phase_name="$1"
    local description="$2"  # Optional description (not used currently)
    local prompt_text="$3"  # The actual prompt
    local output_file=$(get_output_file "$phase_name")
    
    # Build full prompt
    local full_prompt="$prompt_text"
    
    if [ "$EXEC_MODE" == "execute" ]; then
        # Automatic mode: save prompt to file
        echo "# Prompt for $phase_name Phase" > "$output_file"
        echo "" >> "$output_file"
        echo "**Generated:** $(date)" >> "$output_file"
        echo "" >> "$output_file"
        echo "## Prompt" >> "$output_file"
        echo "" >> "$output_file"
        echo "$full_prompt" >> "$output_file"
        echo "" >> "$output_file"
        echo "---" >> "$output_file"
        echo "" >> "$output_file"
        echo "## Agent Response" >> "$output_file"
        echo "" >> "$output_file"
        # Automatic mode: save to file and execute
        echo "💾 Prompt saved to: $output_file"
        echo "🚀 Executing $AGENT_NAME..."
        
        # Execute command and capture output
        local agent_output=$($AGENT_CMD $AGENT_FLAG "$full_prompt" 2>&1)
        
        # Append agent response to file
        echo "$agent_output" >> "$output_file"
        
        echo "✅ Response saved to: $output_file"
        read -p ">> Press Enter after reviewing the response..."
    else
        # Manual mode: show simple prompt only, no file references
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "📝 PROMPT TO COPY AND PASTE INTO YOUR CHAT:"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "$full_prompt"
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        read -p ">> Press Enter after you've pasted this prompt and received the response in your chat..."
    fi
}

echo "🚀 Strata Autopilot Engine: ONLINE"
echo "==================================="
echo ""

# --- MODE SELECTION (Interactive Menu) ---
MODE_OPTIONS=(
    "Show prompts only (copy/paste into agent)"
    "Execute commands automatically"
)
MODE_SELECTED=$(interactive_menu "📋 Select Execution Mode" "${MODE_OPTIONS[@]}")

case $MODE_SELECTED in
    0) EXEC_MODE="show" ;;
    1) EXEC_MODE="execute" ;;
    *) EXEC_MODE="show" ;;
esac

# --- AGENT SELECTION (Interactive Menu) ---
AGENT_OPTIONS=(
    "Cursor Agent"
    "Claude Code"
    "Gemini"
)
AGENT_SELECTED=$(interactive_menu "🤖 Select AI Agent" "${AGENT_OPTIONS[@]}")

case $AGENT_SELECTED in
    0) 
        AGENT_NAME="Cursor Agent"
        AGENT_CMD="cursor-agent"
        AGENT_FLAG="-p"
        ;;
    1) 
        AGENT_NAME="Claude Code"
        AGENT_CMD="claude"
        AGENT_FLAG="--prompt"
        ;;
    2) 
        AGENT_NAME="Gemini"
        AGENT_CMD="gemini"
        AGENT_FLAG="ask"
        ;;
    *) 
        AGENT_NAME="Cursor Agent"
        AGENT_CMD="cursor-agent"
        AGENT_FLAG="-p"
        ;;
esac

clear
echo "✅ Selected Mode: $EXEC_MODE"
echo "✅ Selected Agent: $AGENT_NAME"
if [ "$EXEC_MODE" == "execute" ]; then
    # Verify agent command exists
    if ! command -v $AGENT_CMD &> /dev/null; then
        echo "❌ Error: '$AGENT_CMD' is not installed or not in PATH."
        echo "   Switching to 'show prompts' mode."
        EXEC_MODE="show"
    else
        echo "✅ Agent command found: $AGENT_CMD"
    fi
fi
echo ""

# --- PART 2: THE PPRE LOOP ---
while true; do
    # Find first incomplete story - get complete JSON object
    STORY_JSON=$(jq -c '.stories[] | select(.passes==false)' $SPECS_FILE | head -n 1)
    
    if [ -z "$STORY_JSON" ] || [ "$STORY_JSON" == "null" ]; then
        echo "🎉 All stories completed!"
        exit 0
    fi

    STORY_ID=$(echo "$STORY_JSON" | jq -r '.id // empty')
    STORY_DESC=$(echo "$STORY_JSON" | jq -r '.description // empty')
    STORY_FILES=$(echo "$STORY_JSON" | jq -r '.files_to_touch[]? // empty' | tr '\n' ' ')
    STORY_CRITERIA=$(echo "$STORY_JSON" | jq -r '.acceptance_criteria[]? // empty' | tr '\n' '|')

    echo "==================================="
    echo "📦 CURRENT STORY: $STORY_ID"
    echo "📝 Description: $STORY_DESC"
    echo "==================================="
    echo ""

    # --- PHASE 1: PRIME ---
    PRIME_COMPLETE=false
    while [ "$PRIME_COMPLETE" != "true" ]; do
        echo "🔵 PHASE 1: PRIME"
        echo "-----------------"
        
        PRIME_PROMPT="Read the active story in docs/specs/stories.json. Also, review the rules in .cursor/rules/global.mdc. Do NOT write any code yet. Just confirm you have the context."
        
        run_agent_prompt "PRIME" "Load story and context" "$PRIME_PROMPT"
        
        echo ""
        read -p ">> Confirm PRIME phase completed successfully? (y/n): " PRIME_CONFIRMED
        
        if [ "$PRIME_CONFIRMED" == "y" ]; then
            PRIME_COMPLETE=true
            echo "✅ PRIME phase confirmed"
        else
            echo "🔄 Repeating PRIME phase..."
            echo ""
        fi
    done

    # --- PHASE 2: PLAN ---
    PLAN_APPROVED=false
    while [ "$PLAN_APPROVED" != "true" ]; do
        echo ""
        echo "🟡 PHASE 2: PLAN"
        echo "----------------"
        
        # Include context from PRIME phase if available
        CONTEXT_FILE="$STRATA_DIR/context.md"
        CONTEXT_CONTENT=""
        if [ -f "$CONTEXT_FILE" ]; then
            # Extract the agent response from context.md
            CONTEXT_CONTENT=$(grep -A 1000 "## Agent Response" "$CONTEXT_FILE" | tail -n +3)
            if [ -n "$CONTEXT_CONTENT" ]; then
                CONTEXT_CONTENT="

CONTEXT FROM PRIME PHASE:
$CONTEXT_CONTENT
---
"
            fi
        fi
        
        if [ "$EXEC_MODE" == "execute" ]; then
            # Automatic mode: include context from PRIME
            PLAN_PROMPT="Create a step-by-step implementation plan for story $STORY_ID. Output the plan as Markdown, including: 1) Files to modify, 2) New dependencies, and 3) How you will verify each binary acceptance criterion.$CONTEXT_CONTENT

Do NOT write any code yet. Only create the plan."
        else
            # Manual mode: simple prompt, context is in chat
            PLAN_PROMPT="Create a step-by-step implementation plan for story $STORY_ID. Output the plan as Markdown, including: 1) Files to modify, 2) New dependencies, and 3) How you will verify each binary acceptance criterion.

Do NOT write any code yet. Only create the plan."
        fi
        
        run_agent_prompt "PLAN" "Generate implementation plan" "$PLAN_PROMPT"
        
        if [ "$EXEC_MODE" != "execute" ]; then
            echo ""
            echo "⚠️  IMPORTANT: Copy the plan from your chat before continuing!"
            echo "   You will need to paste it in the next phase (EXECUTE)."
            echo ""
        fi
        
        echo ""
        read -p ">> Human: Do you APPROVE the plan? (y/n): " PLAN_CONFIRMED
        
        if [ "$PLAN_CONFIRMED" == "y" ]; then
            PLAN_APPROVED=true
            echo "✅ PLAN phase approved"
        else
            echo "🔄 Repeating PLAN phase..."
            echo ""
        fi
    done

    # --- PHASE 3: RESET (The Kill Switch) ---
    echo ""
    echo "🔴 PHASE 3: RESET (CRITICAL - The Kill Switch)"
    echo "-----------------------------------------------"
    echo "⚠️  CONTEXT ROT PREVENTION"
    echo ""
    
    if [ "$EXEC_MODE" == "execute" ]; then
        # Automatic mode: inform that context will be cleared automatically
        echo "💡 Automatic mode: Context will be cleared automatically"
        echo "   The next command will be executed in a new session with clean context."
        echo "   This prevents 'Context Rot' and ensures clean execution for EXECUTE phase."
        echo ""
        read -p ">> Confirm to continue? (Press Enter)"
    else
        # Manual mode: user must open new chat
        echo "💡 INSTRUCTIONS FOR USER:"
        echo "   You MUST open a NEW chat/session NOW:"
        echo "   - Start a fresh chat window (new conversation)"
        echo "   - This prevents 'Context Rot' and ensures clean execution"
        echo "   - Make sure you have the plan copied from the previous phase"
        echo ""
        read -p ">> Have you opened a new chat? (Press Enter to continue)"
    fi

    # --- PHASE 4: EXECUTE ---
    EXECUTE_COMPLETE=false
    while [ "$EXECUTE_COMPLETE" != "true" ]; do
        echo ""
        echo "🟢 PHASE 4: EXECUTE"
        echo "-------------------"
        
        # Get acceptance criteria for the prompt
        ACCEPTANCE_CRITERIA=$(echo "$STORY_JSON" | jq -r '.acceptance_criteria[]?' | sed 's/^/- /')
        
        if [ "$EXEC_MODE" == "execute" ]; then
            # Automatic mode: reference plan file
            EXECUTE_PROMPT="Execute the following approved plan. Follow the global rules in .cursor/rules/global.mdc and the specific acceptance criteria.

ACCEPTANCE CRITERIA (all must pass):
$ACCEPTANCE_CRITERIA

REQUIREMENTS:
1. Implement the code according to the approved plan in .strata/plan.md
2. Follow all rules in .cursor/rules/global.mdc
3. After implementation, TEST and VERIFY your work against EACH acceptance criterion above
4. For each criterion, confirm whether it PASSES or FAILS
5. If any criterion fails, fix the issues and re-test
6. Only indicate completion when ALL acceptance criteria pass your own verification
7. Provide a summary of your self-verification results before indicating completion

CRITICAL RESTRICTIONS:
- Do NOT update docs/specs/stories.json - The autopilot script handles this
- Do NOT modify logs/progress.txt - The autopilot script handles this after human verification

Do NOT ask the human to verify until you have completed your own testing and confirmed all criteria pass."
        else
            # Manual mode: ask user to paste the plan
            echo ""
            echo "⚠️  IMPORTANT: Paste the plan you copied from the PLAN phase"
            echo "   (You can paste multiple lines, press Ctrl+D when finished)"
            echo ""
            read -p ">> Press Enter when ready to paste the plan..."
            echo ""
            echo ">> Paste the plan here (press Ctrl+D when done):"
            PASTED_PLAN=$(cat)
            
            EXECUTE_PROMPT="Execute the following approved plan. Follow the global rules in .cursor/rules/global.mdc and the specific acceptance criteria.

APPROVED PLAN:
$PASTED_PLAN

ACCEPTANCE CRITERIA (all must pass):
$ACCEPTANCE_CRITERIA

REQUIREMENTS:
1. Implement the code according to the approved plan above
2. Follow all rules in .cursor/rules/global.mdc
3. After implementation, TEST and VERIFY your work against EACH acceptance criterion above
4. For each criterion, confirm whether it PASSES or FAILS
5. If any criterion fails, fix the issues and re-test
6. Only indicate completion when ALL acceptance criteria pass your own verification
7. Provide a summary of your self-verification results before indicating completion

CRITICAL RESTRICTIONS:
- Do NOT update docs/specs/stories.json - The autopilot script handles this
- Do NOT modify logs/progress.txt - The autopilot script handles this after human verification

Do NOT ask the human to verify until you have completed your own testing and confirmed all criteria pass."
        fi
        
        run_agent_prompt "EXECUTE" "Write code implementation" "$EXECUTE_PROMPT"
        
        echo ""
        echo "📋 Testing Checklist - Mark the acceptance criteria that pass:"
        echo ""
        
        # Build array of acceptance criteria
        ACCEPTANCE_ARRAY=()
        while IFS= read -r criterion; do
            if [ -n "$criterion" ]; then
                ACCEPTANCE_ARRAY+=("$criterion")
            fi
        done < <(echo "$STORY_JSON" | jq -r '.acceptance_criteria[]?')
        
        # Show interactive checklist
        interactive_checklist "Acceptance Criteria Verification" "${ACCEPTANCE_ARRAY[@]}"
        
        # Get count from global variable
        SELECTED_COUNT=$CHECKLIST_SELECTED_COUNT
        TOTAL_COUNT=${#ACCEPTANCE_ARRAY[@]}
        
        clear
        echo "📋 Verification Results:"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "Passed: $SELECTED_COUNT / $TOTAL_COUNT"
        echo ""
        
        if [ "$SELECTED_COUNT" -eq "$TOTAL_COUNT" ]; then
            echo "✅ All acceptance criteria passed!"
            EXECUTE_COMPLETE=true
        else
            echo "⚠️  Some acceptance criteria did not pass."
            echo ""
            echo "🛑 EXECUTION FAILED"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo "⚠️  System Evolution Rule: You MUST codify the lesson before retrying."
            echo ""
            echo "   Update the appropriate agents.md file with the failure reason:"
            echo "   - Logic Error? → Update relevant src/**/agents.md"
            echo "   - Style/Pattern Error? → Update .cursor/rules/global.mdc"
            echo "   - Process Error? → Update docs/reference/workflow.md"
            echo ""
            echo "   Example location: $MEMORY_FILE"
            echo ""
            read -p ">> Have you updated the agents.md file with the lesson learned? (y/n): " UPDATED_AGENTS
            
            if [ "$UPDATED_AGENTS" != "y" ]; then
                echo ""
                echo "❌ You must update agents.md before retrying. This is mandatory."
                echo "   The system must learn from failures."
                echo ""
                read -p ">> Press Enter when you have updated agents.md..."
            fi
            
            echo ""
            read -p ">> Do you want to retry EXECUTE phase? (y/n): " RETRY_EXECUTE
            if [ "$RETRY_EXECUTE" == "y" ]; then
                echo "🔄 Repeating EXECUTE phase..."
                echo ""
            else
                echo "🛑 EXECUTE phase aborted by user."
                echo "   Fix the issues and run the script again."
                exit 1
            fi
        fi
    done

    # --- PHASE 5: VERIFY (Human Verification) ---
    echo ""
    echo "🟣 PHASE 5: VERIFY (Human Verification Required)"
    echo "-----------------------------------------------"
    echo "⚠️  This phase requires HUMAN verification, not agent verification."
    echo ""
    echo "📋 STORY: $STORY_ID - $STORY_DESC"
    echo ""
    echo "📝 ACCEPTANCE CRITERIA (ALL must pass):"
    echo "$STORY_JSON" | jq -r '.acceptance_criteria[]?' | while IFS= read -r criterion; do
        echo "   ✓ $criterion"
    done
    echo ""
    echo "📁 FILES TO VERIFY: $STORY_FILES"
    echo ""
    echo "🔍 VERIFICATION CHECKLIST:"
    echo "   1. Review the implemented code"
    echo "   2. Test the functionality if applicable"
    echo "   3. Verify each acceptance criterion one by one"
    echo "   4. Check for logic errors, style issues, or missing requirements"
    echo "   5. Confirm all files from the plan were created/modified correctly"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    read -p ">> HUMAN: Have you verified ALL acceptance criteria pass? (y/n): " VERIFIED

    if [ "$VERIFIED" != "y" ]; then
        echo ""
        echo "🛑 VERIFICATION FAILED"
        echo "⚠️  System Evolution Rule: You MUST codify the lesson."
        echo ""
        echo "   Update the appropriate memory file:"
        echo "   - Logic Error? → Update relevant src/**/agents.md"
        echo "   - Style/Pattern Error? → Update $GLOBAL_RULES"
        echo "   - Process Error? → Update docs/reference/workflow.md"
        echo ""
        read -p ">> Have you codified the lesson in the appropriate file? (Press Enter)"
        echo ""
        echo "🔄 Restarting PPRE cycle for $STORY_ID..."
        echo ""
        continue
    fi

    # --- PHASE 6: COMMIT ---
    echo ""
    echo "🟢 PHASE 6: COMMIT"
    echo "------------------"
    echo "✅ All acceptance criteria verified by human!"
    echo "💾 Ready to mark $STORY_ID as DONE and commit..."
    echo ""
    read -p ">> HUMAN: Confirm to proceed with COMMIT? (y/n): " CONFIRM_COMMIT
    
    if [ "$CONFIRM_COMMIT" != "y" ]; then
        echo "🛑 COMMIT cancelled by user."
        echo "🔄 Restarting PPRE cycle for $STORY_ID..."
        echo ""
        continue
    fi
    
    # Update stories.json
    tmp=$(mktemp)
    jq --arg id "$STORY_ID" '(.stories[] | select(.id == $id)).passes = true' $SPECS_FILE > "$tmp" && mv "$tmp" $SPECS_FILE
    
    # Generate progress summary using agent
    echo ""
    echo "📝 Generating progress summary..."
    echo ""
    
    PROGRESS_PROMPT="Generate a one-line progress summary in this EXACT format:

[$(date +"%Y-%m-%d %H:%M")] ✅ $STORY_ID: $STORY_DESC - File1.ext brief summary - File2.ext brief summary

Requirements:
- Use the exact timestamp shown above
- List each file that was modified/created from this list: $STORY_FILES
- For each file, provide a brief summary in 4-5 words in English describing what was done
- Separate each file entry with \" - \"
- Output ONLY the formatted line, no explanations or markdown

Example format:
[2026-01-21 15:30] ✅ AUTH-01: Login Form Component - Created LoginForm.tsx with validation - Updated agents.md with lessons learned

Story completed:
ID: $STORY_ID
Description: $STORY_DESC
Files: $STORY_FILES"

    if [ "$EXEC_MODE" == "execute" ]; then
        # Automatic mode: execute and capture
        PROGRESS_SUMMARY=$($AGENT_CMD $AGENT_FLAG "$PROGRESS_PROMPT" 2>&1 | grep -E '^\[20[0-9]{2}-' | head -n 1)
        
        # Fallback if agent doesn't return proper format
        if [ -z "$PROGRESS_SUMMARY" ]; then
            PROGRESS_SUMMARY="[$(date +"%Y-%m-%d %H:%M")] ✅ $STORY_ID: $STORY_DESC - $STORY_FILES completed"
        fi
    else
        # Manual mode: ask user to paste the summary
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "📝 PROMPT TO COPY AND PASTE INTO YOUR CHAT:"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "$PROGRESS_PROMPT"
        echo ""
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo ">> Paste the agent's response (the formatted line) here:"
        read -r PROGRESS_SUMMARY
        
        # Fallback if user doesn't provide proper format
        if [ -z "$PROGRESS_SUMMARY" ]; then
            PROGRESS_SUMMARY="[$(date +"%Y-%m-%d %H:%M")] ✅ $STORY_ID: $STORY_DESC - $STORY_FILES completed"
        fi
    fi
    
    # Log to progress.txt
    echo "$PROGRESS_SUMMARY" >> $PROGRESS_FILE
    
    # Git commit
    git add .
    git commit -m "feat($STORY_ID): completed via Strata Autopilot - $STORY_DESC"
    
    echo ""
    echo "✅ Story $STORY_ID marked as complete"
    echo "📝 Progress logged to $PROGRESS_FILE"
    echo "💾 Changes committed to git"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🎉 Story $STORY_ID completed successfully!"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    read -p ">> HUMAN: Continue with next story? (y/n): " CONTINUE_NEXT
    
    if [ "$CONTINUE_NEXT" != "y" ]; then
        echo ""
        echo "🛑 Autopilot paused by user."
        echo "   Run the script again to continue with remaining stories."
        exit 0
    fi
    
    echo ""
    echo "🔄 Loading next atomic story..."
    echo ""
done
EOF

# 9. Cursor Commands (/.cursor/commands/)
# Command: /prime
cat << 'EOF' > .cursor/commands/prime.md
Read the active story in docs/specs/stories.json. Also, review the rules in .cursor/rules/global.mdc. Do NOT write any code yet. Just confirm you have the context.
EOF

# Command: /plan
cat << 'EOF' > .cursor/commands/plan.md
Create a step-by-step implementation plan for the current story in docs/specs/stories.json. Output the plan as Markdown, including:
1) Files to modify
2) New dependencies
3) How you will verify each binary acceptance criterion

Save the plan to .strata/plan.md for later use with /execute command.

Do NOT write any code yet. Only create the plan.
EOF

# Command: /execute
cat << 'EOF' > .cursor/commands/execute.md
Read the approved plan from .strata/plan.md and execute it. Follow the global rules in .cursor/rules/global.mdc and the specific acceptance criteria from docs/specs/stories.json.

REQUIREMENTS:
1. First, read and understand the plan from .strata/plan.md
2. Implement the code according to the approved plan
3. Follow all rules in .cursor/rules/global.mdc
4. After implementation, TEST and VERIFY your work against EACH acceptance criterion
5. For each criterion, confirm whether it PASSES or FAILS
6. If any criterion fails, fix the issues and re-test
7. Only indicate completion when ALL acceptance criteria pass your own verification
8. Provide a summary of your self-verification results before indicating completion

CRITICAL RESTRICTIONS:
- Do NOT update docs/specs/stories.json - The autopilot script handles this
- Do NOT modify logs/progress.txt - The autopilot script handles this after human verification

Do NOT ask the human to verify until you have completed your own testing and confirmed all criteria pass.
EOF

# 9.5. Gitignore Configuration (if .gitignore exists)
if [ -f ".gitignore" ]; then
    echo "📝 Configuring .gitignore for Strata Framework..."
    
    # Ensure .cursor/rules/ and .cursor/commands/ are NOT ignored (explicitly include them)
    # Check if .cursor/ is ignored and update pattern to allow rules and commands
    if grep -qE "^(\.cursor/|\.cursor$)" .gitignore 2>/dev/null; then
        # Check if we already have the correct pattern
        if ! grep -qE "^\.cursor/\*$" .gitignore 2>/dev/null; then
            # Replace simple .cursor ignore with specific pattern
            # Use a temporary file approach for portability
            {
                # Read and replace .cursor line
                while IFS= read -r line; do
                    if [[ "$line" =~ ^\.cursor(/|$) ]]; then
                        # Replace with new pattern
                        echo "# Ignore all .cursor/ except rules and commands"
                        echo ".cursor/*"
                        echo "!.cursor/rules/"
                        echo "!.cursor/commands/"
                    else
                        echo "$line"
                    fi
                done < .gitignore
            } > .gitignore.tmp && mv .gitignore.tmp .gitignore
        else
            # Pattern exists, just ensure exceptions are present
            if ! grep -qE "^!\.cursor/rules/" .gitignore 2>/dev/null; then
                # Find .cursor/* line and add exceptions after it
                {
                    while IFS= read -r line; do
                        echo "$line"
                        if [[ "$line" =~ ^\.cursor/\*$ ]]; then
                            echo "!.cursor/rules/"
                            echo "!.cursor/commands/"
                        fi
                    done < .gitignore
                } > .gitignore.tmp && mv .gitignore.tmp .gitignore
            fi
        fi
    fi
    
    # Add Strata Framework entries
    # Check if Strata Framework section exists
    if ! grep -q "# Strata Framework" .gitignore 2>/dev/null; then
        echo "" >> .gitignore
        echo "# Strata Framework - Short-term memory (Optional)" >> .gitignore
        echo "logs/progress.txt" >> .gitignore
        echo "" >> .gitignore
        echo "# Strata Framework - Archive (Optional: only if you don't want history of completed tasks)" >> .gitignore
        echo "# docs/done_specs/" >> .gitignore
        echo "" >> .gitignore
        echo "# General" >> .gitignore
        # Only add .env if not already present
        if ! grep -qE "^\.env$" .gitignore 2>/dev/null && ! grep -qE "^\.env" .gitignore 2>/dev/null; then
            echo ".env" >> .gitignore
        fi
        # Only add node_modules/ if not already present
        if ! grep -qE "^node_modules/$" .gitignore 2>/dev/null && ! grep -qE "^node_modules" .gitignore 2>/dev/null; then
            echo "node_modules/" >> .gitignore
        fi
    else
        # Section exists, add missing entries at the end
        # Add logs/progress.txt if missing
        if ! grep -qE "^logs/progress.txt$" .gitignore 2>/dev/null; then
            echo "logs/progress.txt" >> .gitignore
        fi
        # Add commented docs/done_specs/ if missing
        if ! grep -qE "^# docs/done_specs/$" .gitignore 2>/dev/null; then
            echo "# docs/done_specs/" >> .gitignore
        fi
        # Add .env if missing
        if ! grep -qE "^\.env$" .gitignore 2>/dev/null && ! grep -qE "^\.env" .gitignore 2>/dev/null; then
            echo ".env" >> .gitignore
        fi
        # Add node_modules/ if missing
        if ! grep -qE "^node_modules/$" .gitignore 2>/dev/null && ! grep -qE "^node_modules" .gitignore 2>/dev/null; then
            echo "node_modules/" >> .gitignore
        fi
    fi
    
    echo "✅ .gitignore configured"
else
    echo "ℹ️  No .gitignore found - skipping gitignore configuration"
fi

# 10. Finalize
chmod +x scripts/sdd/autopilot.sh
touch logs/progress.txt
echo ""
echo "✅ Strata Scaffolding complete!"
echo ""
echo "📋 Two ways to work with Strata:"
echo ""
echo "1️⃣  AUTOPILOT MODE (Recommended):"
echo "   ./scripts/sdd/autopilot.sh"
echo ""
echo "2️⃣  MANUAL MODE with Cursor Commands:"
echo "   /prime   - Load story and context"
echo "   /plan    - Generate plan (saved to .strata/plan.md)"
echo "   /execute - Execute the plan (reads from .strata/plan.md)"
echo ""