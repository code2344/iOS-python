# PythonPad User Guide

Complete guide to using PythonPad for iPadOS - your full-featured Python IDE on iPad.

## Table of Contents

1. [Getting Started](#getting-started)
2. [User Interface Overview](#user-interface-overview)
3. [File Management](#file-management)
4. [Code Editor](#code-editor)
5. [Running Python Code](#running-python-code)
6. [Python Shell](#python-shell)
7. [Package Management](#package-management)
8. [Git Integration](#git-integration)
9. [Keyboard Shortcuts](#keyboard-shortcuts)
10. [Tips & Tricks](#tips--tricks)
11. [Troubleshooting](#troubleshooting)

## Getting Started

### First Launch

When you first launch PythonPad, you'll see:
- **Sidebar**: File browser (initially empty)
- **Main Area**: Tabbed interface with Editor, Console, Shell, Packages, and Git tabs
- **Menu Bar**: Access to all commands (tap the menu button or use keyboard shortcuts)

### Creating Your First Python File

1. Tap the **+** button in the file browser sidebar, or press `⌘N`
2. A new file named `untitled_[timestamp].py` will be created
3. The editor will open with a sample Python script
4. Start coding!

## User Interface Overview

### Layout

PythonPad uses a split-view layout optimized for iPad:

```
┌─────────────┬──────────────────────────────────┐
│             │                                  │
│   File      │         Main Content Area        │
│   Browser   │    (Tabs: Editor, Console,       │
│  (Sidebar)  │     Shell, Packages, Git)        │
│             │                                  │
└─────────────┴──────────────────────────────────┘
```

### Tab Bar

Five main tabs give you access to all functionality:

1. **📄 Editor** - Write and edit Python code
2. **🖥️ Console** - View script output
3. **⌨️ Shell** - Interactive Python REPL
4. **📦 Packages** - Manage Python packages
5. **🔀 Git** - Clone and manage repositories

## File Management

### File Browser Features

- **📁 Folders**: Displayed with folder icon
- **📄 Files**: Python (.py), text (.txt), and markdown (.md) files
- **Hierarchical View**: Indented display shows file structure
- **Current File**: Highlighted in blue with checkmark

### File Operations

#### Creating Files
- Tap **+** button in sidebar
- Or use `⌘N` keyboard shortcut
- Files are created with `.py` extension

#### Opening Files
- Tap any file in the sidebar
- File content loads in the editor
- Current file is highlighted

#### Deleting Files
- Long-press on a file
- Select **Delete** from context menu
- Confirm deletion

#### Refreshing
- Tap the refresh button (circular arrow)
- Reloads file list from disk

### File Storage

All files are stored in the app's documents directory:
- Accessible via iPad's Files app
- Enable "File Sharing" to access files via iTunes
- Files persist between app launches

## Code Editor

### Features

- **Line Numbers**: Automatically displayed on the left
- **Monospaced Font**: Optimized for code readability
- **Auto-indent**: Basic indentation support
- **No Autocorrect**: Disabled for coding
- **Live Editing**: Changes are reflected immediately

### Editor Toolbar

Located at the top of the editor:

- **File Name**: Shows current file name
- **Save Button**: Save changes (`⌘S`)
- **Run Button**: Execute the script (`⌘R`)

### Editing Tips

1. **Indentation**: Use spaces (4 spaces recommended for Python)
2. **Line Length**: Keep lines under 80 characters when possible
3. **Comments**: Use `#` for single-line comments
4. **Docstrings**: Use `"""triple quotes"""` for multi-line comments

### Best Practices

```python
# Good: Clear variable names and comments
def calculate_average(numbers):
    """Calculate the average of a list of numbers."""
    total = sum(numbers)
    count = len(numbers)
    return total / count

# Bad: Unclear names, no comments
def calc(n):
    return sum(n) / len(n)
```

## Running Python Code

### Running Scripts

Three ways to run your code:

1. **Run Button**: Tap the play button in the editor
2. **Keyboard Shortcut**: Press `⌘R`
3. **Menu Bar**: Python → Run Script

### Viewing Output

1. Switch to the **Console** tab
2. Output appears in real-time
3. Both stdout and stderr are displayed
4. Exit code shown when script completes

### Interrupting Execution

If a script runs too long:
- Use `⌘⌃C` keyboard shortcut
- Or: Python menu → Interrupt Execution

### Console Features

- **Auto-scroll**: Automatically scrolls to show latest output
- **Clear**: Remove all output (`⌘⇧K`)
- **Status**: Shows "Running..." indicator during execution
- **Error Display**: Errors shown in context with output

## Python Shell

### Interactive REPL

The Shell tab provides an interactive Python environment:

```
>>> print("Hello, World!")
Hello, World!
>>> 2 + 2
4
>>> import math
>>> math.pi
3.141592653589793
```

### Using the Shell

1. Switch to the **Shell** tab
2. Type Python commands in the input field
3. Press **Enter** or tap the arrow button
4. View results immediately

### Shell Features

- **Command History**: Previous commands are saved
- **Multi-line Support**: For functions and loops
- **Import Modules**: Access installed packages
- **Quick Testing**: Test code snippets before adding to scripts

### Shell Tips

- Test small code snippets before adding to files
- Import modules to check if they're installed
- Use for quick calculations
- Explore package features interactively

## Package Management

### Installing Packages

1. Navigate to the **Packages** tab
2. Tap **Install** button (or `⌘⇧P`)
3. Enter package name (e.g., `numpy`)
4. Tap **Install**
5. Wait for installation to complete

### Popular Packages

Try installing these popular packages:

```
numpy          # Scientific computing
pandas         # Data analysis
requests       # HTTP library
matplotlib     # Plotting (may have limitations on iOS)
pillow         # Image processing
beautifulsoup4 # Web scraping
```

### Viewing Installed Packages

- All installed packages listed in the Packages tab
- Search box to filter packages
- Tap refresh to reload package list

### Package Installation Notes

- Some packages with C extensions may not work on iOS
- Pure Python packages work best
- Installation may take a few moments for large packages
- Check console for installation details

## Git Integration

### Cloning Repositories

1. Go to the **Git** tab
2. Tap **Clone** button (or `⌘⇧G`)
3. Enter repository URL:
   ```
   https://github.com/username/repository.git
   ```
4. Tap **Clone**
5. Repository downloads to documents directory

### Pulling Updates

For cloned repositories:
1. Find repository in Git tab
2. Tap **Pull** button
3. Updates download automatically
4. Check status message for results

### Working with Cloned Repos

- Files appear in file browser
- Edit Python files normally
- Run scripts from the repository
- Pull to get latest changes

### Git Limitations

Current version supports:
- ✅ Clone repositories
- ✅ Pull updates
- ❌ Commit changes (not yet supported)
- ❌ Push to remote (not yet supported)

## Keyboard Shortcuts

### File Operations
- `⌘N` - New Python file
- `⌘S` - Save current file

### Execution
- `⌘R` - Run script
- `⌘⌃C` - Interrupt execution
- `⌘⇧K` - Clear console

### Navigation
- `⌘⇧P` - Open package manager
- `⌘⇧T` - Open Python shell
- `⌘⇧G` - Clone Git repository
- `⌘⌥P` - Git pull

### iPadOS Standard
- `⌘Tab` - Switch between apps
- `⌘Space` - Spotlight search
- `⌘H` - Home screen

## Tips & Tricks

### Productivity Tips

1. **Use Keyboard Shortcuts**: Much faster than tapping
2. **Split View**: Run PythonPad alongside Safari for documentation
3. **File Organization**: Create folders for different projects
4. **Regular Saves**: Save frequently with `⌘S`
5. **Test Incrementally**: Run code often to catch errors early

### Code Organization

```python
# Organize with clear structure
# 1. Imports
import math
import sys

# 2. Constants
PI = 3.14159
MAX_SIZE = 100

# 3. Functions
def helper_function():
    pass

# 4. Main code
def main():
    pass

# 5. Entry point
if __name__ == "__main__":
    main()
```

### Debugging Strategies

1. **Print Debugging**: Add print statements
   ```python
   print(f"Debug: variable = {variable}")
   ```

2. **Try-Except**: Catch errors gracefully
   ```python
   try:
       result = risky_operation()
   except Exception as e:
       print(f"Error: {e}")
   ```

3. **Test Small Parts**: Use shell to test functions

### Performance Tips

- Avoid infinite loops
- Use list comprehensions for better performance
- Close files properly with `with` statements
- Don't load huge datasets on iPad

## Troubleshooting

### Common Issues

#### "File not found" Error
**Solution**: Make sure file path is correct, use full paths or relative to documents directory

#### Package Won't Install
**Solutions**:
- Check internet connection
- Package name might be incorrect
- Some packages don't work on iOS
- Try pure Python packages

#### Script Runs Forever
**Solutions**:
- Check for infinite loops
- Use `⌘⌃C` to interrupt
- Add timeout logic to your code

#### Git Clone Fails
**Solutions**:
- Verify URL is correct
- Check internet connection
- Use HTTPS URLs (not SSH)
- Repository might be private (auth not supported yet)

### Error Messages

Common Python errors and solutions:

```python
# SyntaxError: Invalid syntax
# → Check for missing colons, parentheses, quotes

# IndentationError: Unexpected indent
# → Python requires consistent indentation (use 4 spaces)

# NameError: name 'x' is not defined
# → Variable used before assignment

# ImportError: No module named 'xyz'
# → Package not installed, use package manager

# FileNotFoundError
# → File doesn't exist or wrong path
```

### Getting Help

1. **Read Error Messages**: They usually tell you what's wrong
2. **Check Examples**: Review example files for guidance
3. **Test in Shell**: Isolate problems with interactive testing
4. **Python Documentation**: Use Safari to access official docs
5. **Stack Overflow**: Search for error messages

### Performance Issues

If app becomes slow:
- Restart the app
- Clear console output
- Reduce file size
- Avoid printing large amounts of data

## Advanced Usage

### Working with External Files

```python
# Read from Files app
with open('/path/to/file.txt', 'r') as f:
    content = f.read()

# Write to share with other apps
with open('output.txt', 'w') as f:
    f.write('Data to share')
```

### Long-Running Scripts

For scripts that run a while:
- Add progress indicators with print
- Split into smaller functions
- Test with small datasets first
- Consider optimization

### Using Virtual Environments

While traditional venvs aren't supported:
- All packages install to user directory
- Packages available across all scripts
- Consider Package versions carefully

---

## Quick Reference Card

| Action | Shortcut | Alternative |
|--------|----------|-------------|
| New File | `⌘N` | + button |
| Save File | `⌘S` | Save button |
| Run Script | `⌘R` | Run button |
| Clear Console | `⌘⇧K` | Clear button |
| Package Manager | `⌘⇧P` | Packages tab |
| Shell | `⌘⇧T` | Shell tab |
| Clone Repo | `⌘⇧G` | Git tab → Clone |
| Pull Updates | `⌘⌥P` | Git tab → Pull |
| Interrupt | `⌘⌃C` | Menu → Interrupt |

---

**Happy Coding on your iPad!** 🎉

For more information, see the main README.md file.
