# nvim-for-go-debugging (with Rust & Python)

A fast, keyboard-centric Neovim setup focused on productive Go development, with first-class Rust and Python support. Includes modern LSP, Treesitter, DAP (debugging), and a curated set of quality-of-life plugins.

- **LSP:** gopls, rust-analyzer (via rust-tools), pyright
- **Debugging:** Delve (Go) + CodeLLDB (Rust) through nvim-dap & dap-ui
- **Formatting/Linting:** gopls (Go), rustfmt/clippy (Rust), black/isort (Python), prettier/eslint_d (JS/TS), stylua (Lua)
- **Finder/Explorer/Terminal:** Telescope, Neo-tree, ToggleTerm
- **Productivity:** Harpoon, which-key, comments, autopairs, tmux navigator
- **UI:** Lualine + Moonfly theme
- **AI helper:** Claude Code (optional)

---

## Contents

- [Requirements](#requirements)
- [Install / Bootstrap](#install--bootstrap)
- [File Layout](#file-layout)
- [Plugins (By Role)](#plugins-by-role)
- [Language Support](#language-support)
  - [LSP & Formatting](#lsp--formatting)
  - [Syntax (Treesitter)](#syntax-treesitter)
  - [Debugging (DAP)](#debugging-dap)
- [Keymaps](#keymaps)
  - [LSP](#lsp-keymaps)
  - [Debugging](#debugging-keymaps)
  - [Misc / Workflow](#misc--workflow)
- [Rust Extras](#rust-extras)
- [Common Tasks](#common-tasks)
- [Troubleshooting](#troubleshooting)
- [FAQ](#faq)

---

## Requirements

- **Neovim** 0.9+ (0.10 recommended)
- **Git** and **curl**
- **Build tools** (macOS: Xcode CLT; Linux: build-essentials)
- **Language toolchains**
  - **Go:** `brew install go` (or use your preferred installer), **Delve:** `brew install delve`
  - **Rust:** `curl https://sh.rustup.rs -sSf | sh` (installs `rustup`/`cargo`)
  - **Python:** `python3 -m venv .venv` (project-local venvs supported)
- **Nerd Font** (for lualine/devicons): e.g., [FiraCode Nerd Font]

---

## Install / Bootstrap

1. Clone or symlink this repo to your config:

   ```bash
   git clone https://github.com/AdonaIsium/nvim-for-go-debugging ~/.config/nvim
   # or symlink if you keep the repo elsewhere
   ```

2. Start Neovim. The plugin manager (lazy.nvim) will bootstrap and install plugins.

3. Install language servers & debuggers via Mason:

   ```vim
   :Mason
   :MasonInstall gopls pyright rust-analyzer codelldb
   ```

4. Ensure Treesitter parsers are installed/updated:

   ```vim
   :TSUpdate
   ```

5. (Python) Activate your project venv **before** opening nvim, or let `pyright` auto-detect if `.venv/bin/python` exists at repo root.

---

## File Layout

```text
~/.config/nvim
├── init.lua
├── lua
│   ├── keymaps.lua
│   ├── vim-options.lua
│   └── plugins
│       ├── lsp-config.lua          # gopls, pyright + shared on_attach
│       ├── rust-tools.lua          # rust-analyzer via rust-tools (no dup)
│       ├── none-ls.lua             # null-ls (stylua/prettier/black/isort/eslint_d)
│       ├── debugging.lua           # core DAP + UI + Go adapter
│       ├── debugging-rust.lua      # Rust DAP (codelldb)
│       ├── treesitter.lua          # TS parsers & features
│       ├── telescope.lua           # Fuzzy finding
│       ├── neo-tree.lua            # File explorer
│       ├── toggleterm.lua          # Terminal integration
│       ├── harpoon.lua             # Quick file marks/jumps
│       ├── whichkey.lua            # Discoverable keymaps
│       ├── lualine.lua             # Statusline
│       ├── moonfly.lua             # Theme
│       ├── comments.lua            # gcc / gc motions
│       ├── autopairs.lua           # Auto-close brackets/quotes
│       ├── completions.lua         # nvim-cmp + luasnip setup
│       ├── crates.lua              # Cargo.toml helper
│       ├── tmux-navigator.lua      # Seamless tmux <> nvim movement
│       ├── floating-help-windows.lua
│       └── claude-code.lua         # Optional AI helper
```

> **Note:** If you still have `rust-vim.lua`, it’s optional and redundant with Treesitter + rust-tools. You can remove it safely.

---

## Plugins (By Role)

- **Core:** `lazy.nvim` (implicit), `which-key.nvim`
- **LSP:** `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig.nvim`, `cmp-nvim-lsp`
- **Completion:** `nvim-cmp`, `luasnip`, friends (configured in `completions.lua`)
- **Formatting/Linting:** `nvimtools/none-ls.nvim` (null-ls)
- **Syntax:** `nvim-treesitter/nvim-treesitter`
- **Debugging:** `mfussenegger/nvim-dap`, `rcarriga/nvim-dap-ui`, `nvim-neotest/nvim-nio`, `leoluz/nvim-dap-go`
- **Rust extras:** `simrat39/rust-tools.nvim`, `Saecki/crates.nvim`
- **Navigation/UX:** `nvim-telescope/telescope.nvim`, `nvim-neo-tree/neo-tree.nvim`, `akinsho/toggleterm.nvim`, `ThePrimeagen/harpoon`, `christoomey/vim-tmux-navigator`
- **UI:** `nvim-lualine/lualine.nvim`, `bluz71/vim-moonfly-colors`
- **Editing QoL:** `numToStr/Comment.nvim`, `windwp/nvim-autopairs`

---

## Language Support

### LSP & Formatting

Configured in `lua/plugins/lsp-config.lua` + `lua/plugins/none-ls.lua`.

- **Go**

  - **LSP:** `gopls`
  - **On Save:** Organize imports + format via `gopls`
  - **Linting:** via `gopls` (analyses + staticcheck)

- **Rust**

  - **LSP:** `rust-analyzer` via `rust-tools.nvim` (configured in `rust-tools.lua`)
  - **On Save:** Format with `rustfmt`; lint via `clippy` (checkOnSave)
  - **Extras:** Hover actions, inline hints, cargo helpers

- **Python**

  - **LSP:** `pyright` (auto-detects project venv at `./.venv/bin/python` if present)
  - **Formatting:** `black` + `isort` through null-ls

- **Web (JS/TS/HTML/CSS)**

  - **Formatting:** `prettier` (null-ls)
  - **Diagnostics:** `eslint_d` (null-ls), if project has ESLint

- **Lua**
  - **Formatting:** `stylua` (null-ls)

> Null-ls only formats when **it** is the active client for that filetype; Go/Rust formatting is handled by their LSPs, avoiding conflicts.

---

### Syntax (Treesitter)

Configured in `lua/plugins/treesitter.lua`.

Installed parsers:

```
lua, go, rust, python,
bash, json, yaml, toml,
markdown, markdown_inline
```

Features: syntax highlight, indent, incremental selection, (optional) autotag support.

---

### Debugging (DAP)

**Core engine:** `nvim-dap`  
**UI:** `nvim-dap-ui` (left sidebar for scopes/breakpoints/stacks, bottom REPL)  
**Layouts:**

- **Left:** width 40 → watches / scopes / breakpoints / stacks
- **Bottom:** height ~11 → REPL

Adapters are kept separate to avoid conflicts:

- `lua/plugins/debugging.lua` → Core DAP + UI + **Go** adapter (via `nvim-dap-go`)
- `lua/plugins/debugging-rust.lua` → **Rust** adapter (**codelldb** server)

#### Go Debugging

- **Adapter:** Delve (wrapped by `nvim-dap-go`)
- **Goodies:** debug single test (`<leader>dgt`) and last test (`<leader>dgl`)

#### Rust Debugging

- **Adapter:** `codelldb` (installed via Mason)
- **Launch:** Prompts for binary; defaults to `./target/debug/`
- **Attach:** Pick a running process to attach

**Install debuggers via Mason:**

```vim
:MasonInstall codelldb
```

**Rust usage:**

```bash
cargo build
# then in Neovim:
<leader>dC         # select the built binary under ./target/debug/
```

---

## Keymaps

### LSP Keymaps

| Mapping      | Action                            |
| ------------ | --------------------------------- |
| `K`          | Hover (docs)                      |
| `<leader>sh` | Signature help                    |
| `gd`         | Go to definition                  |
| `gD`         | Go to declaration                 |
| `gi`         | Go to implementation              |
| `gr`         | References                        |
| `<leader>rn` | Rename                            |
| `<leader>ca` | Code action                       |
| `<leader>D`  | Type definition                   |
| `[d` / `]d`  | Prev / next diagnostic            |
| `<leader>e`  | Line diagnostics (float)          |
| `<leader>q`  | Diagnostics list (loclist)        |
| `<C-s>`      | **Format & Save** (normal/insert) |
| `<C-f>`      | Format buffer (async)             |

> In Rust buffers, `K` is replaced by **rust-tools hover actions** (richer than plain LSP hover).

### Debugging Keymaps

| Mapping       | Action                          |
| ------------- | ------------------------------- |
| `<leader>dt`  | Toggle breakpoint               |
| `<leader>dT`  | Conditional breakpoint (prompt) |
| `<leader>dC`  | Continue / Launch               |
| `<leader>do`  | Step over                       |
| `<leader>di`  | Step into                       |
| `<leader>dO`  | Step out                        |
| `<leader>lp`  | Log point                       |
| `<leader>dr`  | Run last                        |
| `<leader>dq`  | Terminate + close UI            |
| `<leader>du`  | Toggle full UI (scopes/REPL)    |
| `<leader>dc`  | Toggle minimal UI (REPL only)   |
| `<leader>ds`  | Toggle scopes sidebar           |
| `<leader>de`  | Evaluate expression             |
| `<leader>dgt` | **Go:** debug current test      |
| `<leader>dgl` | **Go:** debug last test         |

### Misc / Workflow

Common plugin bindings (may vary by your plugin configs):

- **Neo-tree:** file explorer toggle (see `neo-tree.lua`)
- **Telescope:** project file/search pickers (see `telescope.lua`)
- **ToggleTerm:** integrated terminal (see `toggleterm.lua`)
- **Harpoon:** mark/jump hotfiles (see `harpoon.lua`)
- **which-key:** discoverable `<leader>` menus

---

## Rust Extras

- **rust-tools.nvim**
  - Inline inlay hints
  - Hover actions (with cargo commands)
  - `clippy` on save
  - All features enabled (`cargo.allFeatures = true`)
- **crates.nvim**
  - Enriched `Cargo.toml` (versions, features, updates)
  - Helpful keymaps (see `crates.lua`):
    - `<leader>cv` show versions
    - `<leader>cf` show features
    - `<leader>cu` update crate(s)

> We intentionally **do not** configure `rust-analyzer` directly in `lsp-config.lua` to avoid duplicate clients. Rust LSP is **only** initialized via `rust-tools.lua`.

---

## Common Tasks

- **Update plugins:**
  ```vim
  :Lazy sync
  ```
- **Install/Update LSPs & DAPs:**
  ```vim
  :Mason
  :MasonInstall gopls pyright rust-analyzer codelldb
  ```
- **Update Treesitter parsers:**
  ```vim
  :TSUpdate
  ```

---

## Troubleshooting

- **Two `rust-analyzer` clients / duplicate hovers**

  - Ensure `lsp-config.lua` does **not** call `lspconfig.rust_analyzer.setup`. Rust is handled by `rust-tools.lua` only.

- **Go or Rust double-formatting**

  - `none-ls.lua` should **not** register `goimports`/`gofmt` or `rustfmt`. Go uses `gopls`; Rust uses `rustfmt` via rust-tools.

- **DAP can’t find Rust binary**

  - Run `cargo build` first. When prompted, select your binary in `./target/debug/`.

- **Python uses system interpreter**

  - Create a venv at repo root: `python3 -m venv .venv`
  - Reopen Neovim; `pyright` will pick `./.venv/bin/python`.

- **Icons look wrong**
  - Install and enable a Nerd Font in your terminal.

---

## FAQ

**Q: Do I need `rust.vim`?**  
A: No. Treesitter + rust-tools cover syntax and LSP better. If present, it’s harmless but redundant—feel free to remove the plugin.

**Q: Can I add Python debugging?**  
A: Yes. Add `mfussenegger/nvim-dap-python` and its adapter; it will live alongside Go and Rust without conflicts.

**Q: Where are the DAP layouts defined?**  
A: `debugging.lua` sets up `dap-ui` with a left sidebar (width 40) and a bottom REPL (height ~11).

---

Happy hacking! 🛠️
