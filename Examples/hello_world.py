#!/usr/bin/env python3
"""
Hello World Example for PythonPad
This is a simple starter script to test your Python environment.
"""

def main():
    print("=" * 50)
    print("Welcome to PythonPad for iPadOS!")
    print("=" * 50)
    print()
    print("🐍 Python is running successfully!")
    print()
    
    # Test basic Python features
    print("Testing basic Python features:")
    print(f"  ✓ String formatting works")
    print(f"  ✓ Math: 2 + 2 = {2 + 2}")
    print(f"  ✓ Lists: {[1, 2, 3, 4, 5]}")
    print(f"  ✓ Dictionaries: {{'name': 'PythonPad', 'version': '1.0'}}")
    print()
    
    # Test loops
    print("Counting to 5:")
    for i in range(1, 6):
        print(f"  {i}")
    print()
    
    print("Your Python environment is ready to use!")
    print("Try creating your own scripts in the editor.")

if __name__ == "__main__":
    main()
