# Deployment Guide: Student Notes Manager to Render

This guide will walk you through deploying your Django application to Render (a free cloud hosting platform).

---

## **Step 1: Prepare Your Local Repository**

### 1.1 Ensure all files are committed to Git
```bash
cd c:\Users\KAKEN\StudentNotesManager
git status
git add .
git commit -m "Prepare for Render deployment"
```

### 1.2 Push to GitHub (if not already done)
```bash
git push -u origin main
```

✅ **Verify**: Your repo should be visible on GitHub (https://github.com/yourusername/StudentNotesManager)

---

## **Step 2: Create Account on Render**

1. Go to **https://render.com**
2. Click **"Sign Up"** (or use GitHub to sign up directly)
3. Complete email verification
4. You're ready to deploy!

---

## **Step 3: Connect GitHub to Render**

1. Once logged into Render, go to **Dashboard**
2. Click **"New +"** → **"Web Service"**
3. Click **"Connect Repository"**
4. Authorize Render to access your GitHub account
5. Select your **StudentNotesManager** repository
6. Click **"Connect"**

---

## **Step 4: Configure Render Service**

### **General Settings:**
- **Name**: `student-notes-manager` (or any name you like)
- **Environment**: `Python 3.11`
- **Region**: `Ohio` (or closest to you)
- **Branch**: `main`

### **Build & Deploy Settings:**

**Build Command** (copy exactly):
```
pip install -r requirements.txt && python manage.py collectstatic --noinput
```

**Start Command** (copy exactly):
```
gunicorn StudentNotesManager.wsgi
```

### **Instance Type:**
- Select **Free** (for testing) or **Starter** ($7/month) for production

---

## **Step 5: Set Environment Variables**

1. Scroll to **"Environment"** section in Render
2. Click **"Add Environment Variable"** for each:

| Key | Value |
|-----|-------|
| `DEBUG` | `False` |
| `SECRET_KEY` | _(Render will generate one)_ |
| `ALLOWED_HOSTS` | `your-app-name.onrender.com` |

**To generate SECRET_KEY:**
```bash
python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'
```

Then paste the output as your SECRET_KEY value.

---

## **Step 6: Deploy the Application**

1. Click **"Create Web Service"** at the bottom of the page
2. Render will now:
   - Pull your code from GitHub
   - Install dependencies from `requirements.txt`
   - Collect static files
   - Start the application with Gunicorn

⏳ **Wait 2-5 minutes** for deployment to complete

---

## **Step 7: Verify Deployment**

1. Go to Render Dashboard
2. Click on your **student-notes-manager** service
3. Look for the **URL**: `https://student-notes-manager.onrender.com` (or your custom name)
4. Click the link to open your app in the browser

### **Expected behavior:**
- ✅ Homepage loads
- ✅ Signup page works
- ✅ Login page works
- ✅ Can create account and add notes
- ✅ Bootstrap styling appears

---

## **Step 8: Run Migrations on Render**

Your database will initialize automatically, but verify:

1. In Render Dashboard, click your service
2. Go to **"Logs"** tab
3. Look for: `"System check identified no issues"`
4. You should see: `"Running migrations..."`

If migrations don't run automatically, you can manually trigger them:

1. Go to **"Console"** tab in your Render service
2. Run: `python manage.py migrate`

---

## **Step 9: Create Superuser (Admin)**

1. In Render Dashboard, go to **"Console"** tab
2. Run:
```bash
python manage.py createsuperuser
```

3. Follow the prompts (username, email, password)
4. Visit `https://your-app-name.onrender.com/admin/`
5. Log in with your superuser credentials

---

## **Step 10: Enable Auto-Deploy from GitHub**

Your app should already have **auto-deploy** enabled. To verify:

1. Go to Render Dashboard → Your Service
2. Click **"Settings"**
3. Look for **"Auto-Deploy"** → should be **ON**

Now, every time you `git push` to GitHub, Render automatically redeploys!

---

## **Troubleshooting**

### **❌ "ModuleNotFoundError: No module named 'django'"**
- ✅ Check `requirements.txt` exists and has `django>=6.0`
- ✅ Run build command manually in Console

### **❌ "Page loads but no styling (no Bootstrap)"**
- ✅ Run: `python manage.py collectstatic --noinput`
- ✅ Set `DEBUG=False` in environment

### **❌ "application failed to start"**
- ✅ Check Logs in Render Dashboard
- ✅ Verify `ALLOWED_HOSTS` includes your Render URL
- ✅ Ensure `SECRET_KEY` is set

### **❌ "502 Bad Gateway"**
- ✅ Wait 1-2 minutes (app might still be starting)
- ✅ Check Logs for errors
- ✅ Restart the service (click "Restart" in Render)

### **❌ Database errors**
- ✅ Run migrations: `python manage.py migrate`
- ✅ Create superuser if needed

---

## **Useful Commands (from Render Console)**

```bash
# Check app status
python manage.py check

# Run migrations
python manage.py migrate

# Collect static files
python manage.py collectstatic --noinput

# Create superuser
python manage.py createsuperuser

# Access Django shell
python manage.py shell
```

---

## **Making Changes After Deployment**

1. **Make edits** in your local code
2. **Commit and push** to GitHub:
   ```bash
   git add .
   git commit -m "Your change description"
   git push origin main
   ```
3. **Render automatically redeploys** (check Logs tab)
4. Your live site updates within 1-2 minutes ✨

---

## **Production Checklist**

Before going live with a paid plan:

- [ ] Set `DEBUG=False`
- [ ] Generate unique `SECRET_KEY`
- [ ] Update `ALLOWED_HOSTS` with your domain
- [ ] Set `SECURE_SSL_REDIRECT=True`
- [ ] Create admin superuser
- [ ] Test signup/login/note CRUD
- [ ] Test on mobile devices
- [ ] Backup database regularly

---

## **Performance Tips**

- **Free Tier**: Spins down after 15 mins of inactivity (takes 30 secs to wake up)
- **Starter ($7/month)**: Always running, better for frequent use
- **Monitor Logs**: Check for slow queries or errors

---

## **Next Steps**

### Add a Custom Domain (Optional)
1. Buy a domain (GoDaddy, Namecheap, etc.)
2. In Render, go to Service **Settings**
3. Add Custom Domain
4. Follow DNS instructions from your registrar

### Enable PostgreSQL (Optional)
By default, SQLite is used. For production with multiple users:
1. In Render Dashboard, create a **PostgreSQL Database**
2. Add connection string to environment variables
3. Update `DATABASES` in `settings.py`

### Add Email (Optional)
1. Use SendGrid or MailerSend for sending emails
2. Add API key to environment variables
3. Update Django email settings

---

## **Support**

- **Render Docs**: https://render.com/docs
- **Django Docs**: https://docs.djangoproject.com
- **This Project**: Check README.md for local setup

---

## **Deployed! 🚀**

Your Student Notes Manager is now live on Render and accessible to anyone on the internet!

Share your URL: `https://your-app-name.onrender.com`

Happy coding! 🎉
