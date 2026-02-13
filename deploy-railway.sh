#!/bin/bash
# Quick Railway Deployment Setup Script

echo "🚀 Student Notes Manager - Railway Deployment Setup"
echo "=================================================="
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "❌ Git not initialized. Run: git init"
    exit 1
fi

# Check if requirements.txt exists
if [ ! -f requirements.txt ]; then
    echo "❌ requirements.txt not found!"
    exit 1
fi

echo "✅ Git initialized"
echo "✅ requirements.txt found"
echo ""

# Stage all changes
echo "📦 Staging files for commit..."
git add .

# Commit
echo "📝 Committing changes..."
git commit -m "Prepare for Railway deployment" || true

# Show git status
echo ""
echo "📊 Git Status:"
git status

echo ""
echo "=================================================="
echo "✅ Ready for Railway Deployment!"
echo ""
echo "Next steps:"
echo "1. Go to https://railway.app"
echo "2. Sign up with GitHub"
echo "3. Click 'Deploy from GitHub repo'"
echo "4. Select 'StudentNotesManager'"
echo "5. Add environment variables (see RAILWAY_DEPLOYMENT.md)"
echo ""
echo "For detailed guide, see: RAILWAY_DEPLOYMENT.md"
echo "=================================================="
