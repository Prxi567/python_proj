from datetime import datetime

class Account:
    def __init__(self, acc_no, holder, opening_balance=0):
        self.acc_no = acc_no
        self.holder = holder
        self.amount = opening_balance
        self.history = []

    def __str__(self):
        return f"Acc No: {self.acc_no} | Name: {self.holder} | Balance: {self.amount}"

    def add_money(self, value):
        if value <= 0:
            print("Enter a valid deposit amount")
            return
        self.amount += value
        self.history.append(("CREDIT", value, datetime.now()))
        print("Money added successfully")

    def remove_money(self, value):
        if value <= 0:
            print("Enter a valid withdrawal amount")
            return
        if value > self.amount:
            print("Not enough balance")
            return
        self.amount -= value
        self.history.append(("DEBIT", value, datetime.now()))
        print("Money withdrawn successfully")

    def check_balance(self):
        return self.amount

    def send_money(self, value, other_acc):
        if value <= 0:
            print("Invalid transfer amount")
            return
        if value > self.amount:
            print("Insufficient funds for transfer")
            return
        self.amount -= value
        self.history.append(("TRANSFER_OUT", value, datetime.now()))
        other_acc.amount += value
        other_acc.history.append(("TRANSFER_IN", value, datetime.now()))
        print("Transfer completed successfully")


# creating accounts
a1 = Account(1111, "Ravi", 15000)
a2 = Account(2222, "Neha", 12000)

print(a1)
print(a2)

a1.add_money(3000)
print(a1)

a1.remove_money(2500)
print(a1)

a1.send_money(4000, a2)
print(a2)

print("\nAccount 1 Transaction History:")
for item in a1.history:
    print(item)

print("\nAccount 2 Transaction History:")
for item in a2.history:
    print(item)

output-
Acc No: 1111 | Name: Ravi | Balance: 15000
Acc No: 2222 | Name: Neha | Balance: 12000
Money added successfully
Acc No: 1111 | Name: Ravi | Balance: 18000
Money withdrawn successfully
Acc No: 1111 | Name: Ravi | Balance: 15500
Transfer completed successfully
Acc No: 2222 | Name: Neha | Balance: 16000

Account 1 Transaction History:
('CREDIT', 3000, datetime.datetime(2026, 2, 16, 8, 17, 32, 304301))
('DEBIT', 2500, datetime.datetime(2026, 2, 16, 8, 17, 32, 304321))
('TRANSFER_OUT', 4000, datetime.datetime(2026, 2, 16, 8, 17, 32, 304331))

Account 2 Transaction History:
('TRANSFER_IN', 4000, datetime.datetime(2026, 2, 16, 8, 17, 32, 304332))
