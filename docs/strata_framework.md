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
