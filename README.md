# Banking Management System (Java Swing + MySQL + JDBC)

**Academic Project for Second Year BSc IT Students**  
A desktop-based banking simulation application built using **Java 17**, **Java Swing**, **JDBC (PreparedStatement)**, **MySQL**, and **Maven**.

---

## 📌 Project Overview
The **Banking Management System** simulates core banking services through a user-friendly graphical desktop interface. It is designed specifically for academic demonstration, college viva, and lab practicals.

### Core Features & Modules:
1. **User Authentication (Login Frame)**:
   - Username and password verification using MySQL `users` table.
   - Show/hide password toggle.
   - One-click "Test DB Connection" tool.
   - Default credentials: `admin` / `admin123`.

2. **Main Dashboard**:
   - Live summary statistics (Total Registered Customers, Total System Transactions, Total Bank Reserves).
   - Clean navigation to all banking operations.
   - Safe session logout with confirmation.

3. **Customer Management**:
   - Register new bank customers (Name, 10-digit Phone, Address, Account Number, Initial Deposit).
   - "Auto-Generate Account Number" button (`ACCxxxx`).
   - Real-time customer search by Account Number or Name.
   - Read-only customer records table (`JTable`).

4. **Deposit Module**:
   - Instant account verification before deposit.
   - Rejects zero or negative amounts.
   - Updates customer balance and creates a `DEPOSIT` transaction record atomically.

5. **Withdrawal Module**:
   - Live account balance validation.
   - Prevents overdrafts (strictly prevents withdrawals exceeding available balance).
   - Rejects zero or negative amounts.
   - Deducts balance and creates a `WITHDRAW` transaction record atomically.

6. **Balance Inquiry Module**:
   - Enter account number to view Customer Name, Phone, Address, and Available Balance.
   - Displays the last 5 transactions for the verified account.

7. **Transaction History Module**:
   - Tabular view of all system transactions (`JTable`).
   - Filter by Account Number and Transaction Type (`All`, `DEPOSIT`, `WITHDRAW`).
   - Summary bar displaying total transaction count, total deposit volume, and total withdrawal volume.

---

## 🛠️ Technologies & Tools
- **Language**: Java (JDK 17+)
- **GUI Framework**: Java Swing & AWT
- **Database**: MySQL Server (8.0+)
- **Connectivity**: JDBC via `mysql-connector-j` (8.3.0)
- **Build Tool**: Apache Maven
- **Target IDE**: Eclipse IDE for Java Developers

---

## 📂 Project Structure
```text
BankingManagementSystem/
│
├── pom.xml                         # Maven dependencies & Java 17 configuration
├── database.sql                    # Database schema and sample records
├── README.md                       # Comprehensive guide and documentation
│
└── src/main/java/
    ├── Main.java                   # Application entry point (starts LoginFrame on EDT)
    ├── DBConnection.java           # JDBC connection helper with MySQL settings
    ├── LoginFrame.java             # User login and authentication window
    ├── Dashboard.java              # Main dashboard with live statistics & navigation
    ├── Customer.java               # Customer registration and database table
    ├── BankingOperations.java      # Deposit, Withdraw, and Balance Inquiry tabs
    └── TransactionHistory.java     # Audit table of past deposits and withdrawals
```

---

## 🗄️ Database Setup Instructions

### 1. Start MySQL Server
Ensure MySQL service is running on your machine (via MySQL Command Line Client, MySQL Workbench, or XAMPP / WampServer).

### 2. Import the Database Script
Open **MySQL Command Line Client** or **MySQL Workbench**, and execute the commands from `database.sql`:

#### Option A: Using MySQL Command Line Client
```bash
mysql -u root -p < database.sql
```
*(Enter your MySQL root password when prompted)*

#### Option B: Using MySQL Workbench
1. Open MySQL Workbench and connect to your local MySQL instance.
2. Go to **File** → **Open SQL Script...**
3. Select `BankingManagementSystem/database.sql`.
4. Click the **Execute (Lightning Icon)** button to run the script.
5. In the Schemas panel on the left, right-click and choose **Refresh All**. You will see `banking_db`.

---

## ⚙️ Database Configuration in Code

Open `src/main/java/DBConnection.java` and check lines 13–15:

```java
private static final String URL = "jdbc:mysql://localhost:3306/banking_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
private static final String USER = "root";
private static final String PASSWORD = "password"; // <-- Replace with your MySQL root password
```

- If your MySQL password is `root`, change `"password"` to `"root"`.
- If your MySQL has no password (common in XAMPP), set `private static final String PASSWORD = "";`.

---

## 💻 How to Import and Run in Eclipse IDE

### Step 1: Import Project into Eclipse
1. Launch **Eclipse IDE**.
2. Click **File** → **Import...**
3. In the Import dialog, expand the **Maven** folder and select **Existing Maven Projects**.
4. Click **Next >**.
5. Click **Browse...** next to *Root Directory* and choose the `BankingManagementSystem` folder.
6. Check that `/pom.xml` is selected with a checkmark.
7. Click **Finish**.
8. Wait a few moments for Eclipse and Maven to automatically download the MySQL driver.

### Step 2: Run the Application
1. In the Eclipse **Package Explorer** on the left, expand:
   `BankingManagementSystem` → `src/main/java`
2. Right-click on **`Main.java`**.
3. Select **Run As** → **Java Application**.

---

## 🔑 Demonstration Accounts

| Role | Username | Password | Notes |
| :--- | :--- | :--- | :--- |
| **Admin Login** | `admin` | `admin123` | Default account inserted by `database.sql` |

### Sample Bank Accounts Already in Database:
- **`ACC1001`**: Rahul Sharma (Initial Balance: ₹ 5,000.00)
- **`ACC1002`**: Priya Patel (Initial Balance: ₹ 12,000.00)
- **`ACC1003`**: Amit Kumar (Initial Balance: ₹ 3,500.00)

---

## 🧪 Testing Scenarios for Viva & Lab

1. **Verify Database Connection**:
   - On the Login screen, click **Test DB Connection**. A green information popup should confirm connection to `banking_db`.
2. **Login Verification**:
   - Try logging in with blank credentials or `wrong/wrong` → Observe error popup.
   - Enter `admin` / `admin123` → Observe success popup and Dashboard opening.
3. **Add a Customer**:
   - Click **Customer Management**. Click **Generate** for Account Number.
   - Fill in details and click **Save Customer** → The table on the right immediately updates.
4. **Deposit Money**:
   - Click **Deposit Money**. Enter `ACC1001`, click **Verify Account**, enter `1000`, click **Confirm Deposit**.
   - Check that the balance increases from `5000.00` to `6000.00`.
5. **Withdrawal Overdraft Protection**:
   - Click **Withdraw Money**. Enter `ACC1001`, click **Verify Account**.
   - Try withdrawing `50000` (exceeding balance) → System rejects with **Insufficient Funds** dialog.
   - Withdraw `1000` → System approves and deducts balance.
6. **Transaction History**:
   - Open **Transaction History** → Notice the new `DEPOSIT` and `WITHDRAW` entries with timestamps and amounts.

---

## ❓ Troubleshooting Common Errors

- **Error: `Communications link failure`**:
  - *Cause*: MySQL Server is not running or running on a non-default port.
  - *Fix*: Open Windows Services (`services.msc`), find **MySQL** or **MySQL80**, and click **Start**.

- **Error: `Access denied for user 'root'@'localhost'`**:
  - *Cause*: Incorrect password in `DBConnection.java`.
  - *Fix*: Update `PASSWORD` in `DBConnection.java` to match your local MySQL password.

- **Error: `Table 'banking_db.users' doesn't exist`**:
  - *Cause*: `database.sql` has not been imported yet.
  - *Fix*: Run the `database.sql` script in MySQL Workbench or Command Line.

- **Maven Dependency Error in Eclipse**:
  - *Fix*: Right-click the project in Eclipse → **Maven** → **Update Project...** → Check **Force Update of Snapshots/Releases** → Click **OK**.
