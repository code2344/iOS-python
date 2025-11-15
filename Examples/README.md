# PythonPad Example Scripts

This directory contains example Python scripts to help you get started with PythonPad on your iPad.

## Available Examples

### 1. hello_world.py
A simple introduction script that demonstrates:
- Basic print statements
- String formatting
- Lists and dictionaries
- For loops
- Functions

**Perfect for**: First-time users testing the Python environment

### 2. math_operations.py
Mathematical operations and calculations:
- Basic arithmetic (addition, subtraction, multiplication, division)
- Advanced math functions (sqrt, sin, cos, factorial)
- Fibonacci sequence generation
- Prime number detection
- Using the `math` module

**Perfect for**: Learning Python math capabilities

### 3. data_structures.py
Working with Python's built-in data structures:
- Lists (append, insert, remove, slicing)
- Dictionaries (CRUD operations, iteration)
- Sets (union, intersection, difference)
- Tuples (unpacking, immutability)
- List comprehensions

**Perfect for**: Understanding Python data structures

### 4. file_operations.py
File I/O operations:
- Creating and writing files
- Reading file contents
- Appending to files
- Listing files in directory
- Working with the filesystem

**Perfect for**: Learning file handling in PythonPad

### 5. oop_examples.py
Object-Oriented Programming concepts:
- Classes and objects
- Inheritance
- Method overriding
- Encapsulation (private attributes)
- Polymorphism
- Real-world examples (animals, bank account)

**Perfect for**: Understanding OOP in Python

## How to Use These Examples

### In PythonPad:

1. **Open the file**:
   - Navigate to the Examples folder in the file browser
   - Tap on any `.py` file to open it in the editor

2. **Run the script**:
   - Press the "Run" button in the editor, or
   - Use the keyboard shortcut `⌘R`

3. **View the output**:
   - Switch to the "Console" tab to see the results

4. **Experiment**:
   - Modify the code
   - Add your own functions
   - Try different values
   - Learn by doing!

### In the Python Shell:

You can also run parts of these examples in the interactive shell:

```python
# Copy and paste functions into the shell
def fibonacci(n):
    a, b = 0, 1
    for _ in range(n):
        print(a, end=' ')
        a, b = b, a + b
    print()

# Then call them
fibonacci(10)
```

## Learning Path

Recommended order for beginners:

1. **hello_world.py** - Get familiar with the environment
2. **math_operations.py** - Learn basic Python operations
3. **data_structures.py** - Understand data structures
4. **file_operations.py** - Work with files
5. **oop_examples.py** - Master object-oriented programming

## Tips for Learning

- 🔍 **Read the code carefully**: Each example has comments explaining what it does
- ✏️ **Modify and experiment**: Change values, add features, break things and fix them
- 🐛 **Debug errors**: If something doesn't work, read the error message in the console
- 💾 **Save your changes**: Use `⌘S` to save modified files
- 🔄 **Run frequently**: Test your changes often to catch errors early

## Creating Your Own Scripts

Once you're comfortable with these examples:

1. Create a new file (`⌘N`)
2. Start with a simple idea
3. Build on what you learned from these examples
4. Save your work regularly
5. Share your creations!

## Package Examples

Some examples that require additional packages (install via Package Manager):

```python
# Example with numpy (install: numpy)
import numpy as np
arr = np.array([1, 2, 3, 4, 5])
print(f"Mean: {np.mean(arr)}")

# Example with requests (install: requests)
import requests
response = requests.get('https://api.github.com')
print(f"Status: {response.status_code}")
```

To install packages:
1. Go to the "Packages" tab
2. Tap "Install" or use `⌘⇧P`
3. Enter the package name (e.g., `numpy`, `requests`)
4. Wait for installation to complete

## Advanced Topics

After mastering these examples, explore:
- **Web scraping** with BeautifulSoup
- **Data analysis** with pandas
- **API development** with Flask (if available)
- **Testing** with pytest
- **Regular expressions** with the `re` module
- **JSON processing** for data interchange
- **Database operations** with sqlite3

## Need Help?

- Check the README in the main project directory
- Experiment in the Python Shell for quick tests
- Use the Console to debug your scripts
- Refer to Python's official documentation

---

Happy coding on your iPad with PythonPad! 🐍📱
