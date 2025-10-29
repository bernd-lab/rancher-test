#!/bin/bash
# GitHub Setup & Push Script für rancher-test Repository

set -e

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║         GitHub Repository Setup & Push                        ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

cd /home/bernd/rancher-test

# 1. Git User-Config prüfen
if ! git config user.name &>/dev/null || ! git config user.email &>/dev/null; then
    echo "⚠️  Git User-Config fehlt!"
    echo ""
    read -p "GitHub Username: " GITHUB_USERNAME
    read -p "GitHub Email: " GITHUB_EMAIL
    read -p "Dein Name (für Git): " GIT_NAME
    
    git config --global user.name "${GIT_NAME:-$GITHUB_USERNAME}"
    git config --global user.email "$GITHUB_EMAIL"
    echo "✅ Git-Config gesetzt"
else
    echo "✅ Git-Config bereits gesetzt:"
    echo "   Name:  $(git config user.name)"
    echo "   Email: $(git config user.email)"
fi

echo ""

# 2. GitHub CLI Authentifizierung
if ! gh auth status &>/dev/null; then
    echo "🔐 GitHub Authentifizierung..."
    echo ""
    echo "Optionen:"
    echo "1) Web-basiert (empfohlen)"
    echo "2) Mit Token"
    read -p "Wähle Option (1 oder 2): " AUTH_OPTION
    
    if [ "$AUTH_OPTION" = "1" ]; then
        echo "Öffne Browser für Authentifizierung..."
        gh auth login --web
    elif [ "$AUTH_OPTION" = "2" ]; then
        echo "Erstelle Token unter: https://github.com/settings/tokens"
        echo "Berechtigungen: repo (full control)"
        read -p "GitHub Token: " GITHUB_TOKEN
        echo "$GITHUB_TOKEN" | gh auth login --with-token
    fi
    
    echo "✅ GitHub authentifiziert"
else
    echo "✅ GitHub bereits authentifiziert"
    gh auth status
fi

echo ""

# 3. Repository Status prüfen
echo "📦 Repository Status:"
git status --short || true

echo ""

# 4. Alle Dateien hinzufügen
echo "📝 Dateien hinzufügen..."
git add -A

# 5. Commit (falls Änderungen)
if ! git diff --cached --quiet; then
    echo "💾 Committe Änderungen..."
    git commit -m "docs: add comprehensive tool documentation

- Kubernetes Tools Dokumentation
- Git Tools Dokumentation  
- IaC Tools Dokumentation
- CLI Tools Dokumentation
- QA Report
- Installation Scripts"
else
    echo "ℹ️  Keine Änderungen zum Committen"
fi

echo ""

# 6. GitHub Repository erstellen/verbinden
if ! git remote get-url origin &>/dev/null 2>&1; then
    read -p "Repository Name (leer = rancher-test): " REPO_NAME
    REPO_NAME="${REPO_NAME:-rancher-test}"
    
    read -p "Repository als privat erstellen? (j/n): " PRIVATE_REPO
    if [ "$PRIVATE_REPO" = "j" ]; then
        PRIVATE_FLAG="--private"
    else
        PRIVATE_FLAG="--public"
    fi
    
    echo "🚀 Erstelle GitHub Repository: $REPO_NAME"
    gh repo create "$REPO_NAME" $PRIVATE_FLAG --source=. --remote=origin --push || {
        echo "⚠️  Repository existiert bereits oder Fehler. Fortsetzen..."
        read -p "GitHub Repository URL (z.B. https://github.com/user/repo.git): " REPO_URL
        if [ -n "$REPO_URL" ]; then
            git remote add origin "$REPO_URL"
        fi
    }
else
    echo "✅ Remote bereits konfiguriert:"
    git remote -v
fi

echo ""

# 7. Branch auf main setzen (falls master)
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" = "master" ]; then
    echo "🔄 Benenne Branch zu main um..."
    git branch -m main
fi

# 8. Push
echo "📤 Pushe zu GitHub..."
git push -u origin $(git branch --show-current)

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║         ✅ ERFOLGREICH ZU GITHUB GEPUSHT!                   ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""
echo "🔗 Repository: $(git remote get-url origin)"
echo ""

