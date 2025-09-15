# Neovim for Go & Rust Debugging

This is my personal **Neovim configuration** tailored for **Go** and **Rust** development.  
It includes a modern setup for **LSP, formatting, debugging, testing, and UI enhancements**.

---

## 🚀 Features

- **LSP Support**
  - Go → `gopls`
  - Rust → `rust-analyzer` via [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)
  - Python → `pyright`
  - JSON, YAML, Lua, Bash, Markdown, etc.
- **Formatting**
  - `null-ls` integrates `stylua`, `prettier`, `black`, `isort`, and eslint_d
  - Go uses `gopls` organize imports + format on save
  - Rust uses `rust-analyzer` (with Clippy warnings on save)
- **Debugging**
  - Go debugging with [nvim-dap-go](https://github.com/leoluz/nvim-dap-go)
  - Rust debugging with [codelldb](https://github.com/vadimcn/vscode-lldb) via `nvim-dap`
  - UI with [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- **Testing**
  - Go + Rust tests via [neotest](https://github.com/nvim-neotest/neotest)
  - Visual feedback: ✅ passed, ❌ failed, ⏱ running
  - Test output window + summary sidebar
  - Integrated with DAP for debugging failing tests
- **UI & QoL**
  - File explorer → Neo-tree
  - Statusline → Lualine with test results
  - Telescope fuzzy finder
  - Treesitter syntax highlighting & selection
  - Autopairs, comments, snippets, harpoon, etc.
  - Seamless tmux navigation
  - Floating help windows
  - ClaudeCode integration for AI-assisted coding

---

## 📂 Plugin Files

Each plugin or group of plugins is configured in its own file under `lua/plugins/`.

```
/lua/plugins
├── autopairs.lua
├── claude-code.lua
├── comments.lua
├── completions.lua
├── crates.lua
├── debugging.lua         # nvim-dap, dap-ui, dap-go
├── floating-help-windows.lua
├── harpoon.lua
├── lsp-config.lua        # LSP servers (gopls, pyright, rustaceanvim hooks)
├── lualine.lua           # Statusline with test results
├── moonfly.lua           # Theme
├── neo-tree.lua
├── none-ls.lua           # null-ls sources
├── rustaceanvim.lua      # Rust LSP integration
├── telescope.lua
├── testing.lua           # neotest-go + neotest-rust
├── tmux-navigator.lua
├── toggleterm.lua
├── treesitter.lua
└── whichkey.lua
```

---

## 🧑‍💻 LSP Features

- Hover docs → `K`
- Signature help → `<leader>sh`
- Go to definition → `gd`
- Go to declaration → `gD`
- Go to implementation → `gi`
- Go to references → `gr`
- Rename → `<leader>rn`
- Code action → `<leader>ca`
- Type definition → `<leader>D`
- Diagnostics → `[d` / `]d`, `<leader>e`, `<leader>q`

### Go-specific

- On save: organize imports + format with `gopls`

### Rust-specific

- Inlay hints (toggle with `<leader>th`)
- Hover actions (smart hover with docs + quickfixes) → `K`
- Rust code actions → `<leader>ca`
- Expand macro → `<leader>rm`
- Parent module → `<leader>rp`
- Cargo runnables → `<leader>rr`
- Debuggables → `<leader>rd`
- Reload workspace → `<leader>rw`

---

## 🎨 Formatting

- `<C-s>` → format + save
- `<C-f>` → format current file

Formatters:

- Lua → stylua
- Rust → rust-analyzer
- Go → gopls
- Python → black + isort
- JS/TS/HTML/CSS → prettier + eslint_d

---

## 🐞 Debugging

### Keymaps

- Toggle breakpoint → `<leader>dt`
- Conditional breakpoint → `<leader>dT`
- Continue → `<leader>dC`
- Step over → `<leader>do`
- Step into → `<leader>di`
- Step out → `<leader>dO`
- Run last → `<leader>dr`
- Terminate session → `<leader>dq`
- Toggle UI → `<leader>du`
- Minimal REPL only → `<leader>dc`
- Toggle scopes sidebar → `<leader>ds`
- Eval expression → `<leader>de`

### Go

- Debug test under cursor → `<leader>dgt`
- Debug last test → `<leader>dgl`

### Rust

- Debuggables menu → `<leader>rd` (via rustaceanvim)
- Run cargo runnables → `<leader>rr`

---

## 🧪 Testing (Go + Rust via Neotest)

- Run nearest test → `<leader>gt`
- Run file tests → `<leader>gT`
- Run project tests → `<leader>gp`
- Debug nearest test → `<leader>gd`
- Open output window → `<leader>go`
- Toggle summary sidebar → `<leader>gs`
- Jump to failed tests → `[t` / `]t`

**Visual Feedback**

- ✅ Passed tests
- ❌ Failed tests
- ⏱ Running tests
- ⚠️ Skipped

**Lualine Integration**

- Test results appear in the statusline:  
  Example → `✅ 12 ❌ 2 ⏱ 1`

---

## 🛠️ Treesitter

Installed parsers: Lua, Go, Rust, Python, Bash, JSON, YAML, TOML, Markdown.  
Features: syntax highlighting, indent, incremental selection, autotag.

---

## 📦 Installation

1. Clone this repo into your Neovim config directory:
   ```bash
   git clone https://github.com/AdonaIsium/nvim-for-go-debugging ~/.config/nvim
   ```
2. Open Neovim — Lazy.nvim will sync plugins automatically:
   ```bash
   nvim
   :Lazy sync
   ```

---

## 🔮 Future Ideas

- Integrate test coverage (go + rust)
- More AI-assisted workflows
- Perf tuning for larger codebases
