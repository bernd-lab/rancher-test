#!/bin/bash
# PATH-Setup für alle installierten Tools
# Führe diesen Script aus oder füge den Inhalt zu ~/.bashrc oder ~/.zshrc hinzu

echo "=== PATH-Setup für DevOps Tools ==="

# ~/.local/bin (ansible-navigator, pre-commit, etc.)
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
    echo "✓ ~/.local/bin hinzugefügt"
fi

# Pulumi
if [[ ":$PATH:" != *":$HOME/.pulumi/bin:"* ]]; then
    export PATH="$HOME/.pulumi/bin:$PATH"
    echo "✓ ~/.pulumi/bin hinzugefügt"
fi

# Google Cloud SDK
if [ -d "$HOME/google-cloud-sdk/bin" ]; then
    if [[ ":$PATH:" != *":$HOME/google-cloud-sdk/bin:"* ]]; then
        export PATH="$HOME/google-cloud-sdk/bin:$PATH"
        echo "✓ ~/google-cloud-sdk/bin hinzugefügt"
    fi
fi

echo ""
echo "PATH wurde erweitert. Tool-Verfügbarkeit prüfen:"
which pulumi >/dev/null && echo "✅ pulumi verfügbar" || echo "⚠️ pulumi nicht im PATH"
which ansible-navigator >/dev/null && echo "✅ ansible-navigator verfügbar" || echo "⚠️ ansible-navigator nicht im PATH"
which gcloud >/dev/null && echo "✅ gcloud verfügbar" || echo "⚠️ gcloud nicht im PATH (benötigt Setup)"
which pre-commit >/dev/null && echo "✅ pre-commit verfügbar" || echo "⚠️ pre-commit nicht im PATH"

echo ""
echo "=== Nächste Schritte ==="
echo "1. Füge diese Zeilen zu ~/.bashrc hinzu für permanente Konfiguration:"
echo ""
echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
echo "export PATH=\"\$HOME/.pulumi/bin:\$PATH\""
if [ -d "$HOME/google-cloud-sdk/bin" ]; then
    echo "export PATH=\"\$HOME/google-cloud-sdk/bin:\$PATH\""
fi
echo ""
echo "2. Dann ausführen: source ~/.bashrc"

