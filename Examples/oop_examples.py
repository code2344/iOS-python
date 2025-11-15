#!/usr/bin/env python3
"""
Object-Oriented Programming Example
Demonstrates classes, inheritance, and OOP concepts in Python.
"""

class Animal:
    """Base class for all animals"""
    
    def __init__(self, name, species):
        self.name = name
        self.species = species
        self.energy = 100
    
    def eat(self, food):
        """Animal eats food and gains energy"""
        self.energy += 10
        print(f"{self.name} eats {food} and gains energy! Energy: {self.energy}")
    
    def sleep(self):
        """Animal sleeps and restores energy"""
        self.energy = 100
        print(f"{self.name} is sleeping... Energy restored to {self.energy}")
    
    def make_sound(self):
        """Override this method in subclasses"""
        print(f"{self.name} makes a sound")
    
    def __str__(self):
        return f"{self.name} the {self.species} (Energy: {self.energy})"


class Dog(Animal):
    """Dog class inherits from Animal"""
    
    def __init__(self, name, breed):
        super().__init__(name, "Dog")
        self.breed = breed
        self.tricks = []
    
    def make_sound(self):
        print(f"{self.name} says: Woof! Woof!")
    
    def learn_trick(self, trick):
        """Dog learns a new trick"""
        self.tricks.append(trick)
        print(f"{self.name} learned a new trick: {trick}")
    
    def perform_tricks(self):
        """Dog performs all learned tricks"""
        if self.tricks:
            print(f"{self.name} performs tricks:")
            for trick in self.tricks:
                print(f"  - {trick}")
        else:
            print(f"{self.name} hasn't learned any tricks yet")


class Cat(Animal):
    """Cat class inherits from Animal"""
    
    def __init__(self, name, color):
        super().__init__(name, "Cat")
        self.color = color
        self.lives = 9
    
    def make_sound(self):
        print(f"{self.name} says: Meow!")
    
    def use_life(self):
        """Cat uses one of its nine lives"""
        if self.lives > 0:
            self.lives -= 1
            print(f"{self.name} used a life! Lives remaining: {self.lives}")
        else:
            print(f"{self.name} has no lives left!")


class BankAccount:
    """Example of encapsulation with private attributes"""
    
    def __init__(self, owner, balance=0):
        self.owner = owner
        self.__balance = balance  # Private attribute
        self.transactions = []
    
    def deposit(self, amount):
        """Deposit money into account"""
        if amount > 0:
            self.__balance += amount
            self.transactions.append(f"Deposit: +${amount}")
            print(f"Deposited ${amount}. New balance: ${self.__balance}")
        else:
            print("Deposit amount must be positive")
    
    def withdraw(self, amount):
        """Withdraw money from account"""
        if amount > 0:
            if amount <= self.__balance:
                self.__balance -= amount
                self.transactions.append(f"Withdrawal: -${amount}")
                print(f"Withdrew ${amount}. New balance: ${self.__balance}")
            else:
                print(f"Insufficient funds! Balance: ${self.__balance}")
        else:
            print("Withdrawal amount must be positive")
    
    def get_balance(self):
        """Get current balance (controlled access to private attribute)"""
        return self.__balance
    
    def show_transactions(self):
        """Display transaction history"""
        print(f"\nTransaction history for {self.owner}:")
        for transaction in self.transactions:
            print(f"  {transaction}")


def demonstrate_animals():
    """Demonstrate animal classes"""
    print("Animal Examples:")
    print("=" * 60)
    
    # Create a dog
    buddy = Dog("Buddy", "Golden Retriever")
    print(buddy)
    buddy.make_sound()
    buddy.eat("bone")
    buddy.learn_trick("sit")
    buddy.learn_trick("roll over")
    buddy.learn_trick("fetch")
    buddy.perform_tricks()
    print()
    
    # Create a cat
    whiskers = Cat("Whiskers", "orange")
    print(whiskers)
    whiskers.make_sound()
    whiskers.eat("fish")
    whiskers.use_life()
    whiskers.use_life()
    print()


def demonstrate_bank_account():
    """Demonstrate encapsulation with bank account"""
    print("Bank Account Example:")
    print("=" * 60)
    
    # Create account
    account = BankAccount("Alice", 1000)
    
    # Perform transactions
    print(f"Initial balance: ${account.get_balance()}")
    account.deposit(500)
    account.withdraw(200)
    account.withdraw(2000)  # Will fail
    account.deposit(100)
    
    # Show transaction history
    account.show_transactions()
    print(f"\nFinal balance: ${account.get_balance()}")
    print()


def main():
    print("\n" + "=" * 60)
    print("Object-Oriented Programming Examples")
    print("=" * 60)
    print()
    
    demonstrate_animals()
    demonstrate_bank_account()
    
    print("OOP examples completed!")
    print("\nKey OOP Concepts Demonstrated:")
    print("  ✓ Classes and Objects")
    print("  ✓ Inheritance")
    print("  ✓ Method Overriding")
    print("  ✓ Encapsulation (private attributes)")
    print("  ✓ Polymorphism")


if __name__ == "__main__":
    main()
