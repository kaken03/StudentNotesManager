from django.shortcuts import render, redirect
from .forms import StudentSignupForm
from django.contrib.auth import login

def signup_view(request):
    # Redirect already authenticated users to dashboard
    if request.user.is_authenticated:
        return redirect('dashboard')
    
    if request.method == 'POST':
        form = StudentSignupForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('dashboard')
    else:
        form = StudentSignupForm()

    return render(request, 'accounts/signup.html', {'form': form})