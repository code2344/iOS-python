# PythonPad Architecture

Technical architecture overview of PythonPad for iPadOS.

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         PythonPad App                       │
│                                                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐    │
│  │    Editor    │  │   Console    │  │    Shell     │    │
│  │     View     │  │     View     │  │     View     │    │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘    │
│         │                  │                  │             │
│  ┌──────┴───────┐  ┌──────┴───────┐  ┌──────┴───────┐    │
│  │   Package    │  │     Git      │  │     File     │    │
│  │   Manager    │  │     View     │  │   Browser    │    │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘    │
│         │                  │                  │             │
│         └──────────────────┼──────────────────┘             │
│                            │                                │
│  ┌─────────────────────────┴─────────────────────────┐    │
│  │              Core Models (State Management)        │    │
│  │  ┌──────────────┐ ┌──────────────┐ ┌────────────┐│    │
│  │  │   Python     │ │     File     │ │    Git     ││    │
│  │  │ Environment  │ │   Manager    │ │  Manager   ││    │
│  │  └──────┬───────┘ └──────┬───────┘ └─────┬──────┘│    │
│  └─────────┼────────────────┼────────────────┼───────┘    │
│            │                │                │             │
└────────────┼────────────────┼────────────────┼─────────────┘
             │                │                │
             ▼                ▼                ▼
    ┌────────────────────────────────────────────────┐
    │          iOS System APIs & Tools               │
    │  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
    │  │ Process  │  │   File   │  │   Git    │   │
    │  │   API    │  │  System  │  │  Binary  │   │
    │  └──────────┘  └──────────┘  └──────────┘   │
    │       │              │              │         │
    │       ▼              ▼              ▼         │
    │  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
    │  │  Python  │  │Documents │  │   Git    │   │
    │  │  /pip    │  │Directory │  │  Repos   │   │
    │  └──────────┘  └──────────┘  └──────────┘   │
    └────────────────────────────────────────────────┘
```

## Component Details

### 1. View Layer (SwiftUI)

#### FileBrowserView
- **Purpose**: Display file hierarchy
- **Features**: 
  - Recursive directory listing
  - File selection
  - Context menu for operations
- **State**: Observes `FileManagerModel`

#### EditorView
- **Purpose**: Code editing interface
- **Features**:
  - Line numbers display
  - Monospaced code font
  - Save/Run toolbar
  - Syntax-aware input
- **State**: Observes `FileManagerModel`, `PythonEnvironment`

#### ConsoleView
- **Purpose**: Display script output
- **Features**:
  - Real-time output streaming
  - Auto-scroll
  - Clear functionality
  - Status indicators
- **State**: Observes `PythonEnvironment`

#### ShellView
- **Purpose**: Interactive Python REPL
- **Features**:
  - Command input
  - History management
  - Immediate execution
  - Output display
- **State**: Observes `PythonEnvironment`

#### PackageManagerView
- **Purpose**: Manage Python packages
- **Features**:
  - List installed packages
  - Search packages
  - Install interface
  - Progress tracking
- **State**: Observes `PythonEnvironment`

#### GitView
- **Purpose**: Git repository management
- **Features**:
  - List repositories
  - Clone interface
  - Pull operations
  - Status display
- **State**: Observes `GitManager`, `FileManagerModel`

### 2. Model Layer (Business Logic)

#### PythonEnvironment
**Responsibilities**:
- Execute Python scripts
- Run shell commands
- Manage pip operations
- Track execution state

**Key Methods**:
```swift
func runScript(_ script: String)
func runCommand(_ command: String)
func installPackage(_ packageName: String, completion: ...)
func loadInstalledPackages()
func interruptExecution()
func clearOutput()
```

**Published Properties**:
- `output: String` - Script/command output
- `isRunning: Bool` - Execution state
- `installedPackages: [String]` - Package list
- `showPackageManager: Bool` - UI state

#### FileManagerModel
**Responsibilities**:
- Load file hierarchy
- Create/save/delete files
- Track current file
- Manage file content

**Key Methods**:
```swift
func loadFiles()
func createNewFile()
func saveFile(_ file: PythonFile, content: String)
func deleteFile(_ file: PythonFile)
func openFile(_ file: PythonFile)
```

**Published Properties**:
- `files: [PythonFile]` - File list
- `currentFile: PythonFile?` - Active file

#### GitManager
**Responsibilities**:
- Clone repositories
- Pull updates
- Track repository state
- Execute git commands

**Key Methods**:
```swift
func cloneRepository(url: String, completion: ...)
func pullRepository(_ repository: GitRepository)
func loadRepositories()
```

**Published Properties**:
- `repositories: [GitRepository]` - Repo list
- `currentRepository: GitRepository?` - Active repo
- `operationStatus: String` - Status message
- `isOperating: Bool` - Operation state

### 3. Data Flow

#### Script Execution Flow
```
User Action (Run Button)
    ↓
EditorView calls PythonEnvironment.runScript()
    ↓
PythonEnvironment creates Process
    ↓
Process executes Python with script
    ↓
Output captured via Pipe
    ↓
PythonEnvironment updates @Published output
    ↓
ConsoleView refreshes automatically (SwiftUI)
    ↓
User sees output
```

#### File Save Flow
```
User Action (Save Button)
    ↓
EditorView calls FileManagerModel.saveFile()
    ↓
FileManagerModel writes to file system
    ↓
Updates @Published files array
    ↓
FileBrowserView refreshes automatically
```

#### Package Installation Flow
```
User enters package name
    ↓
PackageInstallView calls PythonEnvironment.installPackage()
    ↓
PythonEnvironment executes pip install
    ↓
Monitors installation progress
    ↓
Updates installedPackages on completion
    ↓
PackageManagerView shows new package
```

## Technology Stack

### iOS Frameworks
- **SwiftUI**: UI framework
- **Foundation**: Core utilities
- **Combine**: Reactive programming

### System APIs
- **Process**: Execute external commands
- **Pipe**: Capture command output
- **FileManager**: File system operations
- **Bundle**: Resource management

### External Tools (via Process)
- **Python 3**: Script execution
- **pip**: Package management
- **git**: Version control

## Design Patterns

### MVVM (Model-View-ViewModel)
- **Models**: `PythonEnvironment`, `FileManagerModel`, `GitManager`
- **Views**: All SwiftUI views
- **ViewModel**: Models serve dual purpose with `@Published` properties

### Observer Pattern
- Views observe model changes via `@ObservableObject`
- Automatic UI updates via SwiftUI binding
- Eliminates manual UI refresh code

### Dependency Injection
- Models injected via `@EnvironmentObject`
- Shared across view hierarchy
- Single source of truth

## State Management

### App-Level State
```swift
@StateObject private var pythonEnvironment = PythonEnvironment()
@StateObject private var fileManager = FileManagerModel()
@StateObject private var gitManager = GitManager()
```

### View-Level State
```swift
@State private var editedContent: String = ""
@State private var selectedTab = 0
@State private var showingSheet = false
```

### Shared State
```swift
@EnvironmentObject var pythonEnvironment: PythonEnvironment
@EnvironmentObject var fileManager: FileManagerModel
```

## File System Organization

```
App Sandbox/
├── Documents/                    # User files (accessible)
│   ├── *.py                     # Python scripts
│   ├── *.txt                    # Text files
│   ├── cloned-repo/             # Git repositories
│   └── output/                  # Generated files
├── Library/
│   └── Python/                  # Installed packages (pip --user)
└── tmp/                         # Temporary files
```

## Process Execution

### Python Script Execution
```swift
let process = Process()
process.executableURL = URL(fileURLWithPath: pythonPath)
process.arguments = ["-c", script]
process.standardOutput = pipe
process.standardError = errorPipe
try process.run()
```

### Git Operations
```swift
process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
process.arguments = ["clone", url, targetPath]
process.currentDirectoryURL = repoURL
```

### Pip Package Installation
```swift
process.executableURL = URL(fileURLWithPath: pipPath)
process.arguments = ["install", packageName, "--user"]
```

## Menu Bar Integration

### Command Structure
```swift
.commands {
    CommandGroup(replacing: .newItem) { ... }
    CommandMenu("Python") { ... }
    CommandMenu("Git") { ... }
}
```

### Keyboard Shortcuts
- Defined in `PythonPadApp.swift`
- Uses SwiftUI `.keyboardShortcut()` modifier
- Supports modifier keys (⌘, ⌥, ⌃, ⇧)

## Threading Model

### Main Thread
- All UI updates
- SwiftUI rendering
- State changes via `@Published`

### Background Threads
- Python script execution
- Package installation
- Git operations
- File I/O operations

### Thread Safety
```swift
DispatchQueue.global(qos: .userInitiated).async {
    // Long-running operation
    
    DispatchQueue.main.async {
        // Update UI
        self.output = result
    }
}
```

## Error Handling

### Process Errors
- Capture stderr separately
- Display in console with context
- Exit code shown to user

### File System Errors
- Try-catch blocks for I/O
- Error messages in console
- Graceful degradation

### Git Errors
- Clone/pull failures handled
- Status messages displayed
- User-friendly error text

## Performance Considerations

### Optimizations
- Lazy file loading
- Background process execution
- Efficient SwiftUI updates
- Minimal state changes

### Memory Management
- ARC (Automatic Reference Counting)
- Weak references in closures
- Process cleanup on termination

## Security

### Sandbox Restrictions
- App runs in iOS sandbox
- Limited file system access
- Network access requires permissions

### Safe Operations
- User directory isolation
- No arbitrary code execution outside sandbox
- File operations restricted to documents

## Testing Strategy

### Manual Testing
- UI interaction testing
- Feature verification
- Edge case handling

### Future: Automated Testing
- Unit tests for models
- UI tests for views
- Integration tests for workflows

## Extensibility

### Adding New Features

1. **New View**:
   - Create SwiftUI view
   - Add to ContentView tabs
   - Inject required models

2. **New Model Function**:
   - Add method to appropriate model
   - Use `@Published` for state
   - Update views as needed

3. **New Menu Command**:
   - Add to `.commands` in PythonPadApp
   - Define keyboard shortcut
   - Link to action

### Plugin Architecture (Future)
- Script extensions
- Custom Python modules
- Third-party integrations

## Deployment

### Build Configuration
- **Target**: iPadOS 18.0+
- **Device**: iPad only
- **Architecture**: ARM64 (Apple Silicon)

### Distribution
- TestFlight for beta
- App Store for release
- Enterprise distribution option

## Maintenance

### Code Organization
- Grouped by feature
- Clear separation of concerns
- Well-documented code

### Dependencies
- Minimal external dependencies
- Swift standard library
- iOS system frameworks

---

## Quick Reference

### File Locations
- **App Code**: `PythonPad/*.swift`
- **Views**: `PythonPad/Views/*.swift`
- **Examples**: `Examples/*.py`
- **Project**: `PythonPad.xcodeproj/`

### Key Classes
- `PythonPadApp`: App entry point
- `ContentView`: Main layout
- `PythonEnvironment`: Python execution
- `FileManagerModel`: File operations
- `GitManager`: Git operations

### State Properties
- `@StateObject`: Owned objects
- `@EnvironmentObject`: Injected objects
- `@State`: View-local state
- `@Published`: Observable properties

---

**Last Updated**: 2024
**Architecture Version**: 1.0
