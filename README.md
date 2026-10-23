# Lua Mini Projects

15 complete, functional, tested Lua projects demonstrating core language features, game development, and system programming.

Repository: https://github.com/0xyz-exe/lua-mini-projects

## Screenshots

### Snake 2D Game (LÖVE Engine)
![Snake 2D Game](docs/screenshots/01_snake_game.png)

### 2D Platformer Game (LÖVE Engine)
![2D Platformer](docs/screenshots/02_platformer.png)

### Terminal Games & Interactive CLI
![Terminal CLI](docs/screenshots/03_terminal_cli.png)

### Test Runner & Suite Execution
![Test Runner](docs/screenshots/04_test_suite.png)

## 🎯 Projects Overview

| # | Project | Type | Key Features |
|---|---------|------|--------------|
| 01 | CLI Calculator | CLI Tool | Arithmetic ops, interactive mode, tests |
| 02 | Number Guessing Game | Terminal Game | Difficulty levels, scoring, high scores |
| 03 | Task Manager | CLI App | CRUD, filtering, JSON persistence |
| 04 | Expense Tracker | CLI App | Income/expense tracking, CSV export |
| 05 | File Organizer | Automation | Extension-based sorting, dry-run |
| 06 | Text & Log Analyzer | Analysis | Word frequency, search, stats |
| 07 | Tic-Tac-Toe | Terminal Game | 2-player, win detection, tests |
| 08 | Snake (LÖVE) | 2D Game | Collision, scoring, graphics |
| 09 | Platformer (LÖVE) | 2D Game | Physics, collectibles, camera |
| 10 | Inventory & Crafting | Game System | Stackable items, recipes, tests |
| 11 | JSON Toolkit | Data | Encode/decode, validation, files |
| 12 | HTTP Client | Networking | Mock client, JSON parsing |
| 13 | Coroutine Scheduler | Concurrency | Cooperative multitasking, tasks |
| 14 | Event Bus | Architecture | Pub/sub, plugins, error handling |
| 15 | Local Search Engine | Search | Indexing, ranking, tokenization |

## 📋 Requirements

- **Lua 5.4.6** (tested version)
- **LÖVE 11.x** (for projects 08-09, optional)
- Windows/Linux/macOS compatible

### Installation (Windows)

```powershell
# Install Lua
winget install --id DEVCOM.Lua

# Install LÖVE (optional, for graphical games)
winget install --id love.love
# Or download: https://love2d.org/

# Verify
lua -v
```

## 🚀 Quick Start

**Terminal projects:**
```bash
cd projects/01-cli-calculator/src
lua main.lua 10 + 5
```

**Interactive projects:**
```bash
cd projects/02-number-guessing/src
lua main.lua
```

**LÖVE games (if installed):**
```bash
love projects/08-snake-love2d/src
love projects/09-platformer-love2d/src
```

## 🧪 Testing

**Run all tests:**
```bash
# PowerShell
cd lua-mini-projects
.\scripts\test-all.ps1

# Bash
./scripts/test-all.sh
```

**Run single project test:**
```bash
cd projects/01-cli-calculator/tests
lua test_calculator.lua
```

## 📁 Repository Structure

```
lua-mini-projects/
├── projects/
│   ├── 01-cli-calculator/     # Basic arithmetic CLI
│   ├── 02-number-guessing/    # Random number game
│   ├── 03-task-manager/       # Task CRUD with JSON
│   ├── 04-expense-tracker/    # Finance tracker
│   ├── 05-file-organizer/     # File automation
│   ├── 06-text-log-analyzer/  # Text analysis
│   ├── 07-tic-tac-toe/        # Classic game
│   ├── 08-snake-love2d/       # Snake with LÖVE
│   ├── 09-platformer-love2d/  # Platform game
│   ├── 10-inventory-crafting/ # Game inventory
│   ├── 11-json-toolkit/       # JSON utilities
│   ├── 12-http-client/        # HTTP (mock)
│   ├── 13-coroutine-scheduler/# Task scheduler
│   ├── 14-event-bus/          # Event system
│   └── 15-local-search-engine/# Text search
├── shared/
│   ├── utils/                 # JSON module
│   └── test_helpers/          # Test framework
├── scripts/                   # Test runners
├── LICENSE
├── .gitignore
└── README.md
```

## 🎮 LÖVE Projects

Projects 08 and 09 require LÖVE (Love2D) framework.

**Snake (Project 08):**
- Arrow keys or WASD to move
- P to pause
- R to restart
- ESC to quit

**Platformer (Project 09):**
- A/D or arrows to move
- Space to jump
- Collect yellow coins
- P to pause, R to restart

**Note:** LÖVE not required for other 13 projects.

## 🔧 Technical Details

**Language:** Lua 5.4 (compatible with 5.3+)

**Dependencies:**
- Core projects: None (pure Lua)
- LÖVE projects: LÖVE 11.x
- HTTP project: Mock only (real HTTP needs luasocket)

**Testing:** Custom lightweight test framework (`shared/test_helpers/simple_test.lua`)

**Architecture:**
- Modular design with separation of concerns
- Local-first, no external API dependencies
- File-based persistence (JSON, CSV, TXT)
- Error handling with `pcall` where appropriate

## 🛡️ Security & Limitations

- **File operations:** Limited to project directories
- **JSON parsing:** Simple implementation, not hardened for untrusted data
- **HTTP client:** Mock only; real networking requires luasocket
- **Randomness:** Uses `math.random()` (not cryptographically secure)
- **Input validation:** Basic validation on user input

## 📝 Project-Specific Notes

**Project 03 (Task Manager):** Uses custom JSON module in `shared/utils/`

**Project 05 (File Organizer):** Always preview with dry-run before executing

**Project 08-09 (LÖVE games):** Game logic separated from rendering for testability

**Project 12 (HTTP Client):** Provides interface only; install luasocket for real HTTP

**Project 15 (Search Engine):** Basic TF ranking, no stemming or advanced NLP

## 🔨 Adding New Projects

1. Create directory: `projects/XX-project-name/{src,tests,data}`
2. Implement module in `src/`
3. Write tests in `tests/`
4. Add README with usage
5. Update main README

## 📚 Learning Path

**Beginners:** Start with 01, 02, 07
**Intermediate:** Try 03, 04, 06, 10
**Advanced:** Explore 13, 14, 15
**Game Dev:** Start with 07, then 08, 09

## 🐛 Known Issues

- Windows path handling uses forward slashes for compatibility
- JSON decode uses `load()` - not safe for untrusted input
- LÖVE projects require manual installation
- No CI/CD pipeline (GitHub Actions template available on request)

## 📄 License

MIT License - see LICENSE file

## 🤝 Contributing

1. Follow existing project structure
2. Include tests for new features
3. Update documentation
4. Ensure Lua 5.3+ compatibility

---

**Total Projects:** 15 ✓  
**Total Tests:** 100+ passing  
**Lines of Code:** ~5,000  
**Last Updated:** 2026-10-18
