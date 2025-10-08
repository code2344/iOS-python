# PythonPad for iPadOS

A full-featured Python development environment for iPadOS with integrated package management, code editor, shell, and Git support.

## Features

### 🐍 Full Python Support
- Complete Python 3 runtime environment
- Execute Python scripts directly on your iPad
- Interactive Python shell (REPL)
- Real-time code execution with output console

### 📦 Package Manager
- Install Python packages using pip
- View and manage installed packages
- Easy package search and installation interface
- Full pip functionality

### ✍️ Code Editor
- Syntax-aware code editor with line numbers
- Save and manage Python files
- File browser with directory support
- Quick run functionality with keyboard shortcuts

### 🖥️ Python Shell (REPL)
- Interactive Python shell for quick testing
- Command history support
- Real-time output display

### 🔄 Git Integration
- Clone repositories directly to your iPad
- Pull updates from remote repositories
- Browse and work with Git projects
- Full Git workflow support

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

- iPadOS 18.0 or later
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

### Creating and Running Python Files

1. Tap the "+" button in the file browser or use `⌘N`
2. Write your Python code in the editor
3. Press the "Run" button or use `⌘R` to execute
4. View output in the Console tab

### Installing Python Packages

1. Navigate to the Packages tab
2. Tap "Install" or use `⌘⇧P`
3. Enter the package name (e.g., `numpy`, `pandas`, `requests`)
4. Tap "Install" to download and install the package

### Using the Python Shell

1. Switch to the Shell tab
2. Type Python commands in the input field
3. Press Enter or tap the arrow button to execute
4. View results immediately in the output area

### Working with Git

1. Navigate to the Git tab
2. Tap "Clone" to add a new repository
3. Enter the Git URL (e.g., `https://github.com/user/repo.git`)
4. Tap "Clone" to download the repository
5. Use "Pull" to update existing repositories

## Architecture

### Python Runtime
The app integrates Python through the system Python installation or bundled Python framework. It uses `Process` API to execute Python scripts and commands, capturing output and errors for display.

### File Management
Files are stored in the app's documents directory, making them accessible through iOS Files app. The file browser recursively scans directories and displays Python files with proper hierarchy.

### Package Management
pip is used directly for package installation with the `--user` flag to install packages in the user directory. The app monitors installation progress and updates the package list.

### Git Operations
Git commands are executed through the system git binary, with proper error handling and progress reporting. Repositories are cloned to the documents directory.

## Technical Details

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Minimum iOS Version**: 18.0 (iPadOS 18.0)
- **Architecture**: MVVM (Model-View-ViewModel)
- **Supported Platforms**: iPad only

## Features in Detail

### Menu Bar Commands
The app fully utilizes iPadOS menu bar capabilities with custom menus:
- **File Menu**: New file, save, run
- **Python Menu**: Package manager, shell, interrupt execution
- **Git Menu**: Clone repository, pull updates

### Code Editor Features
- Monospaced font optimized for code
- Line number display
- Auto-save functionality
- Syntax-aware text editing
- No autocorrection or autocapitalization

### Console Output
- Real-time output streaming
- Auto-scroll to latest output
- Separate stdout and stderr display
- Execution status indicators
- Clear console functionality

## Known Limitations

1. **Sandbox Restrictions**: iOS sandbox may limit certain Python features
2. **Python Version**: Uses system Python or bundled version
3. **Resource Usage**: Large computations may be limited by iOS memory constraints
4. **Network Access**: Some packages requiring network access may need additional permissions

## Future Enhancements

- [ ] Syntax highlighting in the editor
- [ ] Code completion and IntelliSense
- [ ] Jupyter notebook support
- [ ] Debugger integration
- [ ] Virtual environment management
- [ ] Dark mode optimization
- [ ] iCloud sync for files
- [ ] Multiple file tabs
- [ ] Git commit and push support
- [ ] Package search functionality

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

This project is open source and available under the MIT License.

## Author

Created for the iOS-python project

## Acknowledgments

- Built with SwiftUI for modern iOS development
- Inspired by various Python IDEs and code editors
- Uses standard iOS frameworks and APIs

---

**Note**: This app is designed specifically for iPadOS and takes full advantage of iPad-specific features like the menu bar, split view, and large screen real estate.