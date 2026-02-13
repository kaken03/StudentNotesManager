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


## Usage Guide

### Sign Up
- Navigate to **/accounts/signup/**
- Fill in username, email, password
- Click "Sign Up"
- Auto-login and redirect to dashboard

### Login
- Navigate to **/accounts/login/**
- Enter credentials
- Dashboard appears with your notes

### Create Notes
- Click **"New Note"** on dashboard
- Enter title and content
- Click **"Create Note"**

### Edit Notes
- Click **"Edit"** on any note card
- Modify title/content
- Click **"Update Note"**

### Delete Notes
- Click **"Delete"** on any note card
- Confirm deletion
- Note is removed immediately

### Logout
- Click **"Logout"** in top navbar
- You'll be redirected to login page
- Session is securely terminated
