# Contributing to PythonPad

Thank you for your interest in contributing to PythonPad! This document provides guidelines and information for developers who want to contribute to the project.

## Development Setup

### Prerequisites

- macOS with Xcode 15.0 or later
- iOS 18.0 SDK or later
- An iPad running iPadOS 18.0 or later (for testing)
- Basic knowledge of Swift and SwiftUI
- Familiarity with Python

### Getting Started

1. **Fork the repository**
   ```bash
   # Fork on GitHub, then clone your fork
   git clone https://github.com/YOUR_USERNAME/iOS-python.git
   cd iOS-python
   ```

2. **Open in Xcode**
   ```bash
   open PythonPad.xcodeproj
   ```

3. **Select your target device**
   - Choose an iPad simulator or connected iPad
   - Build scheme should be set to "PythonPad"

4. **Build and run**
   - Press `⌘R` or click the Run button
   - App should launch on your selected device

## Project Structure

```
iOS-python/
├── PythonPad/                      # Main app source
│   ├── PythonPadApp.swift         # App entry point & menu commands
│   ├── ContentView.swift          # Main UI layout
│   ├── PythonEnvironment.swift    # Python execution engine
│   ├── FileManagerModel.swift     # File operations
│   ├── GitManager.swift           # Git integration
│   ├── Views/                     # UI Components
│   │   ├── FileBrowserView.swift
│   │   ├── EditorView.swift
│   │   ├── ConsoleView.swift
│   │   ├── ShellView.swift
│   │   ├── PackageManagerView.swift
│   │   └── GitView.swift
│   ├── Assets.xcassets/           # App icons & assets
│   └── Info.plist                 # App configuration
├── Examples/                       # Example Python scripts
├── PythonPad.xcodeproj/           # Xcode project files
├── Package.swift                   # Swift package dependencies
├── README.md                       # Main documentation
├── USERGUIDE.md                   # User documentation
└── CONTRIBUTING.md                # This file
```

## Architecture Overview

### MVVM Pattern

PythonPad uses the Model-View-ViewModel (MVVM) architecture:

- **Models**: `PythonEnvironment`, `FileManagerModel`, `GitManager`
- **Views**: All files in `Views/` directory
- **ViewModels**: Models also serve as ViewModels (using `@Published` properties)

### Key Components

#### 1. PythonEnvironment
Manages Python execution:
- Runs scripts using `Process` API
- Executes shell commands
- Manages package installation via pip
- Tracks execution state and output

#### 2. FileManagerModel
Handles file operations:
- Loads and saves Python files
- Manages file hierarchy
- Provides file browser data
- Creates and deletes files

#### 3. GitManager
Manages Git operations:
- Clones repositories
- Pulls updates
- Tracks repository state
- Executes git commands

## Development Guidelines

### Code Style

- **Swift**: Follow Swift API Design Guidelines
- **Indentation**: 4 spaces (no tabs)
- **Line Length**: Prefer 80-100 characters
- **Comments**: Document public APIs and complex logic
- **Naming**: Use descriptive names

Example:
```swift
// Good
func runScript(_ script: String) {
    // Clear implementation
}

// Bad
func rs(_ s: String) {
    // Unclear
}
```

### SwiftUI Best Practices

1. **State Management**
   ```swift
   @StateObject var environment = PythonEnvironment()  // For owned objects
   @EnvironmentObject var environment: PythonEnvironment  // For injected
   @State private var isShowing = false  // For view-local state
   ```

2. **View Composition**
   - Keep views small and focused
   - Extract complex views into separate files
   - Use view modifiers for reusable styling

3. **Performance**
   - Avoid expensive operations in view body
   - Use `@Published` selectively
   - Consider `LazyVStack` for long lists

### Testing

Currently, the project focuses on manual testing:

1. **Run on Device**: Test on real iPad hardware
2. **Test All Features**: Verify each tab works correctly
3. **Test Edge Cases**: Empty files, long output, errors
4. **Performance**: Check with large files and outputs

Future: Add unit tests and UI tests

## Making Changes

### Branch Strategy

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Write clean, documented code
   - Test thoroughly
   - Follow style guidelines

3. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add feature: description"
   ```

4. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create a Pull Request**
   - Go to GitHub
   - Create PR from your branch to main
   - Describe your changes clearly

### Commit Messages

Use clear, descriptive commit messages:

```
# Good
Add syntax highlighting to code editor
Fix crash when deleting last file
Improve Git clone error handling

# Bad
Update
Fixed bug
Changes
```

Format:
- First line: Brief summary (50 chars or less)
- Blank line
- Detailed description if needed

## Feature Development

### Adding a New View

1. Create new Swift file in `Views/` directory
2. Import SwiftUI
3. Define your view struct
4. Add preview provider for Xcode canvas
5. Integrate into `ContentView.swift`

Example:
```swift
import SwiftUI

struct MyNewView: View {
    @EnvironmentObject var environment: PythonEnvironment
    
    var body: some View {
        VStack {
            Text("My New Feature")
        }
        .navigationTitle("Feature")
    }
}

struct MyNewView_Previews: PreviewProvider {
    static var previews: some View {
        MyNewView()
            .environmentObject(PythonEnvironment())
    }
}
```

### Adding a Menu Command

In `PythonPadApp.swift`:

```swift
.commands {
    CommandMenu("My Menu") {
        Button("My Action") {
            // Action code
        }
        .keyboardShortcut("x", modifiers: .command)
    }
}
```

### Extending Python Capabilities

To add Python features:

1. Add method to `PythonEnvironment.swift`
2. Use `Process` API for execution
3. Capture output and errors
4. Update UI state with `@Published` properties

## Common Tasks

### Adding a Keyboard Shortcut

```swift
.keyboardShortcut("r", modifiers: .command)  // ⌘R
.keyboardShortcut("s", modifiers: [.command, .shift])  // ⌘⇧S
```

### Running Shell Commands

```swift
let process = Process()
process.executableURL = URL(fileURLWithPath: "/usr/bin/command")
process.arguments = ["arg1", "arg2"]

let pipe = Pipe()
process.standardOutput = pipe

try process.run()
let data = pipe.fileHandleForReading.readDataToEndOfFile()
process.waitUntilExit()
```

### Adding Settings

1. Create settings model
2. Use `@AppStorage` for persistence
3. Add settings view
4. Wire up to main app

## Bug Fixes

### Reporting Bugs

Before fixing, check if bug is already reported:
1. Search GitHub issues
2. If not found, create new issue
3. Include:
   - Device and iOS version
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable

### Fixing Bugs

1. Create issue (if not exists)
2. Create branch: `fix/issue-number-description`
3. Write fix with tests
4. Reference issue in commit: "Fix #123: Description"
5. Submit PR

## Feature Requests

### Proposing Features

1. Check existing issues/discussions
2. Create detailed feature request
3. Explain use case and benefits
4. Discuss with maintainers
5. Get approval before implementing large features

### Current Roadmap Ideas

High priority:
- [ ] Syntax highlighting in editor
- [ ] Code completion
- [ ] Better error handling
- [ ] Dark mode support

Medium priority:
- [ ] Debugger integration
- [ ] Multiple file tabs
- [ ] Find/replace in editor
- [ ] Git commit/push support

Low priority:
- [ ] Jupyter notebook support
- [ ] Virtual environment management
- [ ] Cloud sync
- [ ] Themes

## Documentation

### Updating Documentation

When adding features:
1. Update README.md (if needed)
2. Update USERGUIDE.md (for user-facing features)
3. Add code comments
4. Update example files (if relevant)

### Writing Examples

Example Python scripts should:
- Be self-contained
- Include comments
- Demonstrate one clear concept
- Work on iOS/iPadOS
- Be beginner-friendly

## Release Process

(For maintainers)

1. Update version in Info.plist
2. Update CHANGELOG.md
3. Test thoroughly on device
4. Create git tag: `v1.0.0`
5. Push tag: `git push origin v1.0.0`
6. Create GitHub release
7. Build and archive for App Store (future)

## Code Review

### For Contributors

- Be open to feedback
- Respond to review comments
- Make requested changes promptly
- Ask questions if unclear

### For Reviewers

- Be constructive and respectful
- Explain reasoning for requested changes
- Approve when ready
- Test changes locally

## Getting Help

### Resources

- Swift documentation: https://swift.org/documentation/
- SwiftUI tutorials: https://developer.apple.com/tutorials/swiftui
- Python documentation: https://docs.python.org/3/
- Stack Overflow: Tag with `swift`, `swiftui`, `ios`

### Communication

- GitHub Issues: Bug reports and features
- GitHub Discussions: Questions and ideas
- Pull Requests: Code contributions

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (MIT License).

## Recognition

Contributors will be acknowledged in:
- README.md contributors section
- Release notes
- Special recognition for significant contributions

## Questions?

If you have questions about contributing:
1. Check this guide
2. Search existing issues
3. Create a new discussion
4. Ask in your PR

---

Thank you for contributing to PythonPad! Your efforts help make Python development on iPad better for everyone. 🎉
