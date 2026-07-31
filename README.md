<div align="center">

# 🚌 blueBus

### Online Bus Ticket Booking System

A full-featured bus ticket booking platform built with Django, offering real-time seat selection and QR-based ticket confirmation.

![Django](https://img.shields.io/badge/-Django-092E20?style=for-the-badge&logo=django&logoColor=white)
![Python](https://img.shields.io/badge/-Python%203.10-3776AB?style=for-the-badge&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

</div>

---

## 📖 About

**blueBus** simulates a real-world online bus ticket booking workflow — from browsing routes to selecting seats to confirming a booking. It's built on Django with a MySQL backend, and generates **QR codes** for booking confirmation, along with real-time seat allocation to keep data consistent across users.

---

## ✨ Features

- 🪑 **Real-Time Seat Selection** — Interactive seat allocation with conflict-free booking
- 🎫 **QR Code Ticketing** — Auto-generated QR codes for each confirmed booking
- 🔐 **User Authentication** — Secure login and booking history per user
- 🗺️ **Route Management** — Structured handling of routes, schedules, and bookings
- 🗄️ **Consistent Data Modeling** — Relational schema ensures no double-booking or data conflicts

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **Backend** | Python 3.10, Django 3.2 |
| **Database** | MySQL (via PyMySQL / mysqlclient) |
| **Ticketing** | qrcode, Pillow |
| **Frontend** | HTML, CSS, Django Templates |

---

## 📁 Project Structure

```
blueBus/
├── blueBus/          # Django project settings & configuration
├── bus/               # Core app — models, views, booking logic
├── static/            # CSS, JS, and static assets
├── templates/          # HTML templates
├── zall-documents/     # Project documentation/reference files
├── manage.py
└── db.sqlite3
```

---

## 🚀 Getting Started

### Prerequisites
- **Python 3.10.0** (recommended to use this exact version)
- MySQL Server

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/bansil20/blueBus.git
   cd blueBus
   ```

2. **Create a virtual environment (Python 3.10.0)**
   ```bash
   python -m venv env
   env\Scripts\activate   # Windows
   source env/bin/activate  # macOS/Linux
   ```

3. **Install dependencies**
   ```bash
   pip install django==3.2 pymysql qrcode Pillow mysqlclient
   ```

4. **Configure the database**
   - Set up your MySQL database and update credentials in `blueBus/settings.py`
   - Run migrations:
     ```bash
     python manage.py migrate
     ```

5. **Run the development server**
   ```bash
   python manage.py runserver
   ```

6. Visit `http://127.0.0.1:8000/` in your browser.

---

## 👤 Author

**Bansil Pabari**
[GitHub](https://github.com/bansil20) • [LinkedIn](https://www.linkedin.com/in/bansil-pabari-204948296/) • bansilpabari02@gmail.com

---

<div align="center">

⭐ If you found this project interesting, consider giving it a star!

</div>
