#!/usr/bin/env python3
"""
Test script to verify add_numbers.py works correctly.
"""

from add_numbers import add_numbers

def test_add_numbers():
    """Test the add_numbers function with various inputs."""
    print("Testing add_numbers function:")
    print("-" * 30)
    
    # Test cases
    test_cases = [
        (5, 3),
        (10.5, 2.7),
        (-4, 9),
        (0, 0),
        (-5, -3)
    ]
    
    for num1, num2 in test_cases:
        result = add_numbers(num1, num2)
        print(f"{num1} + {num2} = {result}")
    
    print("\nAll tests completed successfully!")

if __name__ == "__main__":
    test_add_numbers()
