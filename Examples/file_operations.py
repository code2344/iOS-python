#!/usr/bin/env python3
"""
File Operations Example
Demonstrates reading and writing files in Python.
Note: Files are stored in the app's documents directory.
"""

import os

def write_example_file():
    """Create and write to a file"""
    print("Writing to file...")
    
    content = """This is an example text file created by PythonPad.

PythonPad supports full file I/O operations:
- Reading files
- Writing files
- Appending to files
- Creating directories

You can work with any text-based files including:
- Python scripts (.py)
- Text files (.txt)
- Markdown files (.md)
- Configuration files (.json, .yaml, .ini)
- And more!

Happy coding on your iPad!
"""
    
    with open("example_output.txt", "w") as f:
        f.write(content)
    
    print("✓ File 'example_output.txt' created successfully!")
    print()

def read_example_file():
    """Read from a file"""
    print("Reading from file...")
    
    try:
        with open("example_output.txt", "r") as f:
            content = f.read()
        
        print("File contents:")
        print("-" * 60)
        print(content)
        print("-" * 60)
        print()
    except FileNotFoundError:
        print("Error: File not found. Run write operation first.")
        print()

def append_to_file():
    """Append content to a file"""
    print("Appending to file...")
    
    with open("example_output.txt", "a") as f:
        f.write(f"\n\nThis line was appended at runtime!\n")
    
    print("✓ Content appended successfully!")
    print()

def list_files():
    """List all Python files in the current directory"""
    print("Listing Python files in current directory:")
    print("-" * 60)
    
    files = [f for f in os.listdir(".") if f.endswith((".py", ".txt", ".md"))]
    
    if files:
        for i, filename in enumerate(sorted(files), 1):
            size = os.path.getsize(filename)
            print(f"{i}. {filename} ({size} bytes)")
    else:
        print("No Python files found in current directory")
    
    print()

def main():
    print("=" * 60)
    print("File Operations Example")
    print("=" * 60)
    print()
    
    # Write a file
    write_example_file()
    
    # Read the file
    read_example_file()
    
    # Append to the file
    append_to_file()
    
    # Read again to see changes
    read_example_file()
    
    # List all files
    list_files()
    
    print("File operations examples completed!")
    print("Check your file browser to see 'example_output.txt'")

if __name__ == "__main__":
    main()
