# PythonPad for iPadOS

A Python development environment UI demonstration for iPadOS with code editor, shell interface, package manager, and Git management features.

## ⚠️ Important Notice

**This is a UI demonstration app that showcases what a Python IDE for iPadOS could look like.**

Due to iOS/iPadOS sandbox restrictions:
- **Process API is not available** - Cannot execute external binaries like `python3`, `pip`, or `git`
- **Python execution is simulated** - Basic interpreter simulation for demonstration
- **Package management is simulated** - Shows the UI workflow but doesn't install real packages
- **Git operations are simulated** - Creates demo folders but doesn't perform actual Git operations

### To Make This Fully Functional

To create a working Python environment on iOS/iPadOS, you would need to:

1. **Embed Python Framework**: Bundle Python.framework with your app (requires significant setup)
2. **Use PythonKit**: Integrate PythonKit with an embedded Python interpreter
3. **WebAssembly Python**: Use Pyodide or similar WASM-based Python
4. **Git Integration**: Use libgit2 via SwiftGit2 or Objective-Git (not Process API)
5. **Network-based Execution**: Connect to a remote Python server

This app demonstrates the UI/UX and architecture for such an implementation.

## Features

### ✍️ Code Editor
- Professional code editor with line numbers
- Monospaced font optimized for coding
- Save and manage Python files
- File browser with directory support
- Quick run functionality with keyboard shortcuts

### 🖥️ Python Shell Interface
- Interactive shell UI for command input
- Command history support
- Output display area
- Simulates basic Python commands

### 📦 Package Manager UI
- Package installation interface
- View simulated installed packages
- Search and management UI
- Demonstrates pip workflow

### 🔄 Git Management UI
- Repository cloning interface
- Pull updates UI
- Repository browser
- Demonstrates Git workflow

### ⌨️ iPadOS Menu Bar Integration
- Menu bar commands for all major functions
- Keyboard shortcuts for power users:
  - `⌘N` - New Python file
  - `⌘R` - Run current script
  - `⌘S` - Save file
  - `⌘⇧K` - Clear console
  - `⌘⇧P` - Package manager
  - `⌘⇧T` - Open shell
  - `⌘⇧G` - Clone repository
  - `⌘⌥P` - Git pull

### 📱 iPad Optimized
- Split view support for multitasking
- Optimized for iPad Pro and all iPad models
- Full orientation support
- Native iPadOS experience

## Requirements

- iPadOS 17.0 or later
- iPad (any model)
- Xcode 15.0 or later (for building)

## Installation

### Building from Source

1. Clone this repository:
```bash
git clone https://github.com/code2344/iOS-python.git
cd iOS-python
```

2. Open the Xcode project:
```bash
open PythonPad.xcodeproj
```

3. Select your iPad as the target device

4. Build and run (`⌘R`)

## Project Structure

```
PythonPad/
├── PythonPadApp.swift          # Main app entry point with menu commands
├── ContentView.swift            # Main UI layout with tabs
├── PythonEnvironment.swift     # Python execution and package management
├── FileManagerModel.swift      # File operations and management
├── GitManager.swift            # Git operations (clone, pull)
└── Views/
    ├── FileBrowserView.swift   # File browser sidebar
    ├── EditorView.swift        # Code editor with line numbers
    ├── ConsoleView.swift       # Output console
    ├── ShellView.swift         # Interactive Python shell
    ├── PackageManagerView.swift # Package manager UI
    └── GitView.swift           # Git repository management
```

## Usage

### Creating and Editing Python Files

1. Tap the "+" button in the file browser or use `⌘N`
2. Write your Python code in the editor
3. Press the "Run" button or use `⌘R` to execute (simulated)
4. View output in the Console tab

**Note**: The app demonstrates the workflow. To see real Python execution, integrate Python.framework or PythonKit.

### Package Manager

1. Navigate to the Packages tab
2. Tap "Install" or use `⌘⇧P`
3. Enter the package name (e.g., `numpy`, `pandas`, `requests`)
4. Tap "Install" to simulate package installation

**Note**: Demonstrates the UI workflow. Real package installation requires pip integration with embedded Python.

### Python Shell

1. Switch to the Shell tab
2. Type Python commands in the input field
3. Press Enter or tap the arrow button to execute
4. View simulated results in the output area

**Note**: Basic command simulation provided. Full REPL requires embedded Python interpreter.

### Git Management

1. Navigate to the Git tab
2. Tap "Clone" to simulate repository cloning
3. Enter the Git URL (e.g., `https://github.com/user/repo.git`)
4. Tap "Clone" to create a demo folder structure

**Note**: Creates sample folders. Real Git operations require libgit2 integration (SwiftGit2/Objective-Git).

## Architecture

### Current Implementation
The app provides a fully functional UI demonstrating:
- File management with real file operations
- Code editor with syntax-aware input
- Tab-based navigation
- Menu bar integration with keyboard shortcuts
- Responsive iPad layout

### What's Simulated
- **Python Execution**: Basic simulation of common commands
- **Package Management**: UI demonstration of pip workflow
- **Git Operations**: Folder structure creation without actual Git operations

### How to Make It Real

**For Python Execution:**
```swift
// Replace simulated interpreter with:
// 1. Bundle Python.framework in app
// 2. Use PythonKit with embedded interpreter
// 3. Or integrate WASM Python (Pyodide)
```

**For Git Operations:**
```swift
// Replace Process API calls with:
// 1. SwiftGit2 (libgit2 wrapper)
// 2. Objective-Git
// 3. GitHub/GitLab REST API
```

### File Management
Files are stored in the app's documents directory, making them accessible through iOS Files app. The file browser recursively scans directories and displays Python files with proper hierarchy. **File operations are fully functional.**

### Python Execution (Simulated)
The app simulates basic Python commands for demonstration. To enable real Python execution, you would need to bundle Python.framework or integrate PythonKit with the app.

### Package Management (Simulated)
The UI demonstrates the pip workflow. Real package management requires integration with an embedded Python installation.

### Git Operations (Simulated)
Git operations create demo folder structures. For real Git functionality, integrate libgit2 via SwiftGit2 or use the GitHub API.

## Technical Details

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Minimum iOS Version**: 18.0 (iPadOS 17.0)
- **Architecture**: MVVM (Model-View-ViewModel)
- **Supported Platforms**: iPad only
- **Status**: UI demonstration with simulated Python/Git operations

## What Works

✅ **Fully Functional:**
- File management (create, save, delete, browse)
- Code editor with line numbers
- Menu bar and keyboard shortcuts
- Tab-based navigation
- All UI components

⚠️ **Simulated (requires integration):**
- Python script execution
- Package installation via pip
- Git clone and pull operations

## Features in Detail

### Menu Bar Commands
The app fully utilizes iPadOS menu bar capabilities with custom menus:
- **File Menu**: New file, save, run (simulated)
- **Python Menu**: Package manager, shell, interrupt execution
- **Git Menu**: Clone repository, pull updates (simulated)

### Code Editor Features
- Monospaced font optimized for code
- Line number display
- Save/load functionality (fully working)
- Syntax-aware text editing
- No autocorrection or autocapitalization

### Console Output
- Output display area
- Auto-scroll to latest output
- Separate stdout and stderr display
- Execution status indicators
- Clear console functionality

## Current Limitations

**This is a UI demonstration app. The following limitations apply:**

1. **No Process API on iOS**: Cannot execute external binaries (`python3`, `pip`, `git`)
2. **Simulated Python**: Basic command simulation only - not a real interpreter
3. **Simulated Package Management**: Shows UI workflow but doesn't install real packages
4. **Simulated Git**: Creates demo folders but doesn't perform actual Git operations
5. **No External Execution**: iOS sandbox prevents running external processes

## How to Make It Production-Ready

To convert this into a fully functional Python IDE:

1. **Python Runtime**:
   - Embed Python.framework in the app bundle
   - Use PythonKit with embedded interpreter
   - Or integrate WebAssembly Python (Pyodide)

2. **Package Management**:
   - Bundle pip with embedded Python
   - Implement package installation through embedded Python

3. **Git Integration**:
   - Use SwiftGit2 or Objective-Git (libgit2 wrappers)
   - Or use GitHub/GitLab REST APIs
   - Cannot use Process API on iOS

4. **Resources**:
   - [PythonKit](https://github.com/pvieito/PythonKit)
   - [SwiftGit2](https://github.com/SwiftGit2/SwiftGit2)
   - [Pyodide](https://pyodide.org/)

## Future Enhancements

With proper Python integration:
- [ ] Real Python script execution
- [ ] Actual package installation via pip
- [ ] Real Git operations
- [ ] Syntax highlighting in the editor
- [ ] Code completion and IntelliSense
- [ ] Debugger integration
- [ ] Virtual environment management
- [ ] Dark mode optimization
- [ ] iCloud sync for files
- [ ] Multiple file tabs

## Contributing

Contributions are welcome! This project would particularly benefit from:
- Integration of Python.framework
- libgit2 integration for real Git operations
- Syntax highlighting implementation
- Code completion features

Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

This project is open source and available under the MIT License.

## Author

Created for the iOS-python project as a UI demonstration

## Acknowledgments

- Built with SwiftUI for modern iOS development
- Inspired by various Python IDEs and code editors
- Demonstrates iOS-compatible architecture for Python IDE

---

**Note**: This app is designed specifically for iPadOS and takes full advantage of iPad-specific features like the menu bar, split view, and large screen real estate.