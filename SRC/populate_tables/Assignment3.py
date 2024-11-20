from faker import Faker
import mysql.connector

import random;
fake = Faker()

# Connect to your MySQL database
connection = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Turnberry123',
    database='restaurant_schema'
)


cursor = connection.cursor()

# Generate and insert data into Menu (2000 rows)
def populate_menu():
    for i in range(2000):
        name = f"Dish {i+1}"
        price = round(random.uniform(5, 30), 2)  # Random price between $5 and $30
        cursor.execute("INSERT INTO Menu (name, price) VALUES (%s, %s)", (name, price))
    connection.commit()

# Generate and insert data into Customer (3000 rows)
def populate_customer():
    for _ in range(3000):
        name = fake.name()
        email = fake.email()
        first_date_of_visit = fake.date_this_decade()
        cursor.execute(
            "INSERT INTO Customer (name, email, firstDateOfVisit) VALUES (%s, %s, %s)",
            (name, email, first_date_of_visit)
        )
    connection.commit()

# Generate and insert data into Staff (500 rows)
def populate_staff():
    job_titles = ["Manager", "Server", "Chef", "Cleaner"]
    for _ in range(500):
        job_title = random.choice(job_titles)
        name = fake.name()
        wage = round(random.uniform(10, 25), 2)  # Random wage between $10 and $25
        hire_date = fake.date_between(start_date="-10y", end_date="today")
        cursor.execute(
            "INSERT INTO Staff (jobTitle, name, wage, hireDate) VALUES (%s, %s, %s, %s)",
            (job_title, name, wage, hire_date)
        )
    connection.commit()

# Generate and insert data into Reservation (linked to Customer)
def populate_reservation():
    # Generate 350 unique customer IDs for reservations
    reserved_customers = random.sample(range(1, 3001), 350)  # 350 unique IDs from 1 to 3000
    for customer_id in reserved_customers:
        head_count = random.randint(1, 10)  # Random headcount between 1 and 10
        date = fake.date_this_year()  # Random reservation date this year
        cursor.execute(
            "INSERT INTO Reservation (customerID, headCount, date) VALUES (%s, %s, %s)",
            (customer_id, head_count, date)
        )
    connection.commit()


# Call the functions to populate data
populate_menu()
populate_customer()
populate_staff()
populate_reservation()

# Close the connection
cursor.close()
connection.close()