#!/usr/bin/env python3
"""
Math Operations Example
Demonstrates various mathematical operations and calculations.
"""

import math

def basic_operations():
    """Perform basic arithmetic operations"""
    print("Basic Arithmetic Operations:")
    print(f"Addition: 10 + 5 = {10 + 5}")
    print(f"Subtraction: 10 - 5 = {10 - 5}")
    print(f"Multiplication: 10 * 5 = {10 * 5}")
    print(f"Division: 10 / 5 = {10 / 5}")
    print(f"Floor Division: 10 // 3 = {10 // 3}")
    print(f"Modulo: 10 % 3 = {10 % 3}")
    print(f"Exponentiation: 2 ** 8 = {2 ** 8}")
    print()

def advanced_math():
    """Use the math module for advanced operations"""
    print("Advanced Math Functions:")
    print(f"Square root of 16: {math.sqrt(16)}")
    print(f"Pi: {math.pi}")
    print(f"Euler's number: {math.e}")
    print(f"Sin(π/2): {math.sin(math.pi/2)}")
    print(f"Cos(π): {math.cos(math.pi)}")
    print(f"Factorial of 5: {math.factorial(5)}")
    print()

def fibonacci(n):
    """Generate Fibonacci sequence"""
    print(f"Fibonacci sequence (first {n} numbers):")
    a, b = 0, 1
    fib_list = []
    for _ in range(n):
        fib_list.append(a)
        a, b = b, a + b
    print(fib_list)
    print()

def is_prime(n):
    """Check if a number is prime"""
    if n < 2:
        return False
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0:
            return False
    return True

def find_primes(limit):
    """Find all prime numbers up to a limit"""
    print(f"Prime numbers up to {limit}:")
    primes = [n for n in range(2, limit + 1) if is_prime(n)]
    print(primes)
    print()

def main():
    print("=" * 60)
    print("Mathematics Examples in PythonPad")
    print("=" * 60)
    print()
    
    basic_operations()
    advanced_math()
    fibonacci(10)
    find_primes(30)
    
    print("Math examples completed!")

if __name__ == "__main__":
    main()
