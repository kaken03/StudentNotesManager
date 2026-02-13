# Student Notes Manager

A comprehensive Django-based application for students to securely manage and organize their study notes with user authentication and a private dashboard.

## Features

✅ **Secure User Authentication**
- Sign-up with username, email, and password
- Login/Logout functionality
- Form validation and error handling
- Prevents already logged-in users from accessing signup

✅ **Private Dashboard**
- View all notes belonging only to the logged-in student
- Clean, responsive Bootstrap UI
- Quick access to edit and delete notes

✅ **Complete CRUD Operations**
- **Create**: Add new notes with title and content
- **Read**: View all notes on the dashboard
- **Update**: Edit existing notes with full content control
- **Delete**: Permanently remove notes with confirmation

✅ **Access Control & Security**
- `@login_required` decorator on all note views
- User ownership verification on edit/delete operations
- Prevents students from accessing or modifying other students' notes
- CSRF protection on all forms

✅ **Modern Frontend**
- Bootstrap 5 responsive design
- Clean, intuitive UI
- Mobile-friendly layouts
- Form error messages and validation feedback

---

## Project Structure

```
StudentNotesManager/
├── accounts/
│   ├── models.py          (Django built-in User model)
│   ├── forms.py           (StudentSignupForm with validation)
│   ├── views.py           (signup_view with authentication)
│   ├── urls.py            (signup, login, logout routes)
│   └── migrations/
├── notes/
│   ├── models.py          (Note model with FK to User)
│   ├── forms.py           (NoteForm with Bootstrap styling)
│   ├── views.py           (CRUD views with access control)
│   ├── urls.py            (dashboard, add, edit, delete routes)
│   └── migrations/
├── StudentNotesManager/
│   ├── settings.py        (Django configuration)
│   ├── urls.py            (project URL routing)
│   └── wsgi.py
├── templates/
│   ├── base.html          (Base template with navbar)
│   ├── accounts/
│   │   ├── signup.html
│   │   └── login.html
│   └── notes/
│       ├── dashboard.html
│       ├── note_form.html
│       └── confirm_delete.html
├── manage.py
├── db.sqlite3
└── README.md
```

---

## Installation & Setup

### 1. **Create Virtual Environment** (if not already created)
```bash
python -m venv .venv
```

### 2. **Activate Virtual Environment**

**Windows (PowerShell):**
```powershell
.\.venv\Scripts\Activate.ps1
```

**Windows (CMD):**
```cmd
.venv\Scripts\activate.bat
```

**macOS/Linux:**
```bash
source .venv/bin/activate
```

### 3. **Install Dependencies**
```bash
pip install django>=6.0 django-crispy-forms crispy-bootstrap5
```

### 4. **Run Migrations**
```bash
python manage.py migrate
```

### 5. **Create Superuser (Optional - for Admin Panel)**
```bash
python manage.py createsuperuser
```

### 6. **Start Development Server**
```bash
python manage.py runserver
```

The application will be available at: **http://127.0.0.1:8000**

---

## Usage Guide

### **1. Sign Up**
- Navigate to **http://127.0.0.1:8000/accounts/signup/**
- Fill in username, email, password, and confirm password
- Click **"Sign Up"** to create your account
- You'll be automatically logged in and redirected to the dashboard

### **2. Log In**
- Navigate to **http://127.0.0.1:8000/accounts/login/**
- Enter your username and password
- Click **"Login"** to access your dashboard

### **3. Dashboard**
- After login, you see all your notes
- Each note card displays:
  - Note title
  - First 25 words of content (truncated)
  - Creation date
  - Edit and Delete buttons

### **4. Create a Note**
- Click **"New Note"** button on the dashboard
- Enter note **title** and **content**
- Click **"Create Note"** to save
- You'll be redirected to the dashboard

### **5. Edit a Note**
- Click the **"Edit"** button on any note card
- Modify the title and/or content
- Click **"Update Note"** to save changes
- Returns to dashboard automatically

### **6. Delete a Note**
- Click the **"Delete"** button on any note card
- Review the note content to confirm deletion
- Click **"Delete Permanently"** to confirm
- Note is removed from your dashboard

### **7. Log Out**
- Click the **"Logout"** button in the top-right navbar
- You'll be redirected to the login page
- Your session is securely terminated

---

## Technical Details

### **Authentication System**
- Uses Django's built-in `User` model
- Password hashing with Django's default PBKDF2 algorithm
- Session-based authentication
- `@login_required` decorator protects all note views
- Auto-redirect unauthenticated users to login page

### **Database Schema**

**User Model** (Django built-in)
```python
- username (CharField, unique)
- email (EmailField)
- password (hashed)
- is_active, is_staff, is_superuser, etc.
```

**Note Model**
```python
- id (AutoField, primary key)
- user (ForeignKey → User, CASCADE delete)
- title (CharField, max 200 chars)
- content (TextField, unlimited)
- created_at (DateTimeField, auto-populated)
```

### **Security Features**
✅ CSRF protection on all forms
✅ User ownership checks on edit/delete (`get_object_or_404` with user filter)
✅ Password validation requirements
✅ SQL injection prevention (Django ORM)
✅ XSS protection (template auto-escaping)
✅ Secure password hashing

### **URL Routing**
| Route | View | Purpose |
|-------|------|---------|
| `/accounts/signup/` | `signup_view` | Create account |
| `/accounts/login/` | `LoginView` | Authenticate user |
| `/accounts/logout/` | `LogoutView` | Terminate session |
| `/` | `dashboard` | View all notes |
| `/add/` | `add_note` | Create note |
| `/edit/<id>/` | `edit_note` | Modify note |
| `/delete/<id>/` | `delete_note` | Delete note |

---

## Configuration (settings.py)

Key settings configured for this project:
```python
# Authentication
LOGIN_REDIRECT_URL = 'dashboard'
LOGIN_URL = 'login'
LOGOUT_REDIRECT_URL = 'login'

# Templates
TEMPLATES = [{
    'DIRS': [BASE_DIR / 'templates'],
    'APP_DIRS': True,
}]

# Installed Apps
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'notes',
    'accounts',
]
```

---

## Admin Panel Access

To manage users and notes through Django admin:

1. Create a superuser:
   ```bash
   python manage.py createsuperuser
   ```

2. Start the server and visit: **http://127.0.0.1:8000/admin/**

3. Log in with superuser credentials

4. Manage:
   - Users
   - Notes
   - Groups & Permissions

---

## Troubleshooting

### **"ModuleNotFoundError: No module named 'django'"**
- Ensure virtual environment is activated
- Install Django: `pip install django>=6.0`

### **"No such table: notes_note"**
- Run migrations: `python manage.py migrate`

### **Login page shows but won't authenticate**
- Ensure user account exists (sign up first if new)
- Check database has notes_note table: `python manage.py migrate`

### **Can't see Bootstrap styling**
- Bootstrap CSS is loaded from CDN; requires internet connection
- Check browser console for any 404 errors

### **Forgot password?**
- Currently no password reset feature
- Use Django admin to reset: `python manage.py changepassword username`

---

## Future Enhancements

- [ ] Password reset/forgot password functionality
- [ ] Note categories and tags
- [ ] Search functionality
- [ ] Note sharing with other students
- [ ] Export notes to PDF
- [ ] Dark mode theme
- [ ] Note versioning/history
- [ ] Collaborative notes
- [ ] Email notifications

---

## Development Commands

```bash
# Run development server
python manage.py runserver

# Check for issues
python manage.py check

# Create migrations after model changes
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Access Django shell
python manage.py shell

# Reset database (careful!)
rm db.sqlite3
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Change user password
python manage.py changepassword username
```

---

## Browser Support

- Chrome/Edge 90+
- Firefox 88+
- Safari 14+
- Mobile browsers (iOS Safari, Chrome Mobile)

---

## License

This project is open source and available under the MIT License.

---

## Support

For issues or questions:
1. Check the troubleshooting section
2. Review Django documentation: https://docs.djangoproject.com
3. Check Bootstrap documentation: https://getbootstrap.com/docs

---

**Happy Note Taking! 📝**
