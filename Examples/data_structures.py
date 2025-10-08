#!/usr/bin/env python3
"""
Data Structures Example
Demonstrates various Python data structures and their operations.
"""

def lists_example():
    """Working with lists"""
    print("Lists Example:")
    print("-" * 40)
    
    # Create a list
    fruits = ["apple", "banana", "cherry", "date"]
    print(f"Original list: {fruits}")
    
    # Add items
    fruits.append("elderberry")
    print(f"After append: {fruits}")
    
    # Insert at position
    fruits.insert(1, "apricot")
    print(f"After insert: {fruits}")
    
    # Remove item
    fruits.remove("banana")
    print(f"After remove: {fruits}")
    
    # Slice
    print(f"First 3 items: {fruits[:3]}")
    
    # List comprehension
    upper_fruits = [f.upper() for f in fruits]
    print(f"Uppercase: {upper_fruits}")
    print()

def dictionaries_example():
    """Working with dictionaries"""
    print("Dictionaries Example:")
    print("-" * 40)
    
    # Create a dictionary
    person = {
        "name": "Alice",
        "age": 30,
        "city": "New York",
        "skills": ["Python", "Swift", "JavaScript"]
    }
    print(f"Person: {person}")
    
    # Access values
    print(f"Name: {person['name']}")
    print(f"Skills: {person['skills']}")
    
    # Add new key
    person["email"] = "alice@example.com"
    print(f"After adding email: {person}")
    
    # Iterate over dictionary
    print("Dictionary items:")
    for key, value in person.items():
        print(f"  {key}: {value}")
    print()

def sets_example():
    """Working with sets"""
    print("Sets Example:")
    print("-" * 40)
    
    # Create sets
    set_a = {1, 2, 3, 4, 5}
    set_b = {4, 5, 6, 7, 8}
    
    print(f"Set A: {set_a}")
    print(f"Set B: {set_b}")
    
    # Set operations
    print(f"Union: {set_a | set_b}")
    print(f"Intersection: {set_a & set_b}")
    print(f"Difference (A - B): {set_a - set_b}")
    print(f"Symmetric Difference: {set_a ^ set_b}")
    print()

def tuples_example():
    """Working with tuples"""
    print("Tuples Example:")
    print("-" * 40)
    
    # Create a tuple
    coordinates = (10.5, 20.3, 30.7)
    print(f"Coordinates: {coordinates}")
    
    # Unpack tuple
    x, y, z = coordinates
    print(f"x={x}, y={y}, z={z}")
    
    # Named tuple-like behavior
    rgb = (255, 128, 0)  # Orange color
    red, green, blue = rgb
    print(f"RGB Color: R={red}, G={green}, B={blue}")
    print()

def main():
    print("=" * 60)
    print("Python Data Structures Examples")
    print("=" * 60)
    print()
    
    lists_example()
    dictionaries_example()
    sets_example()
    tuples_example()
    
    print("Data structures examples completed!")

if __name__ == "__main__":
    main()
