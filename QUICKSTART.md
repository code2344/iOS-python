# PythonPad Quick Start

Get started with PythonPad in 5 minutes!

## 🚀 Installation

1. Open `PythonPad.xcodeproj` in Xcode
2. Select your iPad as target
3. Press `⌘R` to build and run
4. App launches on your iPad

## 📝 First Steps

### Create Your First Python File

1. Tap **+** in sidebar (or press `⌘N`)
2. Write Python code in editor
3. Press **Run** button (or `⌘R`)
4. See output in Console tab

### Example Code

```python
# hello.py
print("Hello from PythonPad!")

for i in range(5):
    print(f"Count: {i}")

result = 2 + 2
print(f"2 + 2 = {result}")
```

## 🎯 Essential Features

### 5 Main Tabs

| Tab | Icon | Purpose | Shortcut |
|-----|------|---------|----------|
| **Editor** | 📄 | Write code | - |
| **Console** | 🖥️ | View output | - |
| **Shell** | ⌨️ | Interactive Python | `⌘⇧T` |
| **Packages** | 📦 | Install packages | `⌘⇧P` |
| **Git** | 🔀 | Clone repos | `⌘⇧G` |

### Key Shortcuts

```
⌘N     New file
⌘S     Save file
⌘R     Run script
⌘⇧K    Clear console
⌘⇧P    Package manager
⌘⌃C    Stop execution
```

## 📦 Installing Packages

1. Go to **Packages** tab
2. Tap **Install**
3. Type package name: `requests`
4. Tap **Install** button
5. Wait for completion

Popular packages to try:
- `requests` - HTTP library
- `beautifulsoup4` - Web scraping
- `pillow` - Image processing

## 🔄 Using Git

### Clone a Repository

1. **Git** tab → **Clone**
2. Enter URL: `https://github.com/user/repo.git`
3. Tap **Clone**
4. Files appear in browser

### Update Repository

1. Select repo in **Git** tab
2. Tap **Pull** button
3. Updates download

## ⌨️ Python Shell

Interactive Python testing:

```python
>>> 2 + 2
4
>>> import math
>>> math.sqrt(16)
4.0
>>> print("Hello!")
Hello!
```

## 💡 Pro Tips

### 1. Learn from Examples

Check the `Examples/` folder:
- `hello_world.py` - Basic Python
- `math_operations.py` - Math functions
- `data_structures.py` - Lists, dicts, etc.
- `file_operations.py` - File I/O
- `oop_examples.py` - Classes and objects

### 2. Editor Features

- **Line numbers** - Automatically shown
- **Save often** - Use `⌘S` frequently
- **Run quickly** - Use `⌘R` to test

### 3. File Organization

```
Documents/
├── my_project/
│   ├── main.py
│   ├── utils.py
│   └── data/
├── examples/
└── tests/
```

### 4. Debugging

Use print statements:
```python
print(f"Debug: variable = {variable}")
print(f"Type: {type(variable)}")
```

### 5. Test in Shell

Before adding to file:
```python
# Test in Shell first
>>> def test_function(x):
...     return x * 2
>>> test_function(5)
10
```

## 🆘 Common Issues

### Problem: "No module named 'xyz'"
**Solution**: Install package via Packages tab

### Problem: Script won't stop
**Solution**: Use `⌘⌃C` to interrupt

### Problem: File not found
**Solution**: Check file path, use full paths

### Problem: Git clone fails
**Solution**: Check URL, ensure HTTPS (not SSH)

## 📚 Learning Resources

### In the App
1. `Examples/` folder - 5 example scripts
2. `USERGUIDE.md` - Full user guide
3. `README.md` - Project overview

### External
- [Python Tutorial](https://docs.python.org/3/tutorial/)
- [Learn Python](https://www.learnpython.org/)
- [Real Python](https://realpython.com/)

## 🎓 Learning Path

**Beginner** (Week 1):
1. Run `Examples/hello_world.py`
2. Modify the examples
3. Create simple scripts
4. Use the Shell for practice

**Intermediate** (Week 2-3):
1. Work with data structures
2. Write functions
3. Handle files
4. Install and use packages

**Advanced** (Week 4+):
1. Object-oriented programming
2. Clone Git repositories
3. Build real projects
4. Explore advanced packages

## ⚡ Quick Commands

### File Operations
```python
# Read file
with open('data.txt', 'r') as f:
    content = f.read()

# Write file
with open('output.txt', 'w') as f:
    f.write('Hello, World!')
```

### Package Usage
```python
# After installing with pip
import requests
response = requests.get('https://api.github.com')
print(response.status_code)
```

### List Comprehension
```python
# Create list of squares
squares = [x**2 for x in range(10)]
print(squares)
```

## 🎯 Your First Project

Try building a simple calculator:

```python
# calculator.py

def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def multiply(a, b):
    return a * b

def divide(a, b):
    if b != 0:
        return a / b
    return "Error: Division by zero"

# Test it
print("Calculator Test:")
print(f"5 + 3 = {add(5, 3)}")
print(f"5 - 3 = {subtract(5, 3)}")
print(f"5 * 3 = {multiply(5, 3)}")
print(f"5 / 3 = {divide(5, 3)}")
```

## ✅ Checklist

Your first session:
- [ ] Create a new file
- [ ] Write and run "Hello, World!"
- [ ] Try the Python Shell
- [ ] Run an example script
- [ ] Install a package
- [ ] Clone a Git repository

## 🎉 You're Ready!

You now know enough to start coding Python on your iPad!

- **Experiment** - Try new things
- **Break things** - That's how you learn
- **Have fun** - Enjoy coding on iPad!

---

**Need more help?**
- Read `USERGUIDE.md` for detailed instructions
- Check `Examples/` for code samples
- Visit the project README for full documentation

**Happy coding!** 🐍✨
