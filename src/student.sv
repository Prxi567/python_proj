from datetime import datetime

class CustomerAccount:
    def __init__(self, number, owner, start_amt=0):
        self.number = number
        self.owner = owner
        self.balance_amt = start_amt
        self.logs = []

    def __str__(self):
        return f"Account ID: {self.number} | User: {self.owner} | Amount: {self.balance_amt}"

    def deposit_cash(self, cash):
        if cash <= 0:
            print("Invalid deposit value")
            return
        self.balance_amt += cash
        self.logs.append(("DEPOSITED", cash, datetime.now()))
        print("Deposit successful")

    def withdraw_cash(self, cash):
        if cash <= 0:
            print("Invalid withdrawal value")
            return
        if cash > self.balance_amt:
            print("Low balance")
            return
        self.balance_amt -= cash
        self.logs.append(("WITHDRAWN", cash, datetime.now()))
        print("Withdrawal successful")

    def show_balance(self):
        return self.balance_amt

    def transfer_cash(self, cash, receiver):
        if cash <= 0:
            print("Invalid transfer value")
            return
        if cash > self.balance_amt:
            print("Transfer failed due to insufficient balance")
            return
        self.balance_amt -= cash
        self.logs.append(("SENT", cash, datetime.now()))
        receiver.balance_amt += cash
        receiver.logs.append(("RECEIVED", cash, datetime.now()))
        print("Amount transferred successfully")


# account creation
cust1 = CustomerAccount(9001, "Arjun", 18000)
cust2 = CustomerAccount(9002, "Kavya", 10000)

print(cust1)
print(cust2)

cust1.deposit_cash(4500)
print(cust1)

cust1.withdraw_cash(3200)
print(cust1)

cust1.transfer_cash(5000, cust2)
print(cust2)

print("\nCustomer 1 Transaction Log:")
for record in cust1.logs:
    print(record)

print("\nCustomer 2 Transaction Log:")
for record in cust2.logs:
    print(record)
