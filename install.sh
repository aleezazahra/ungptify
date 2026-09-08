#!/bin/bash
# Install all skills from this repo into Codex

CODEX_SKILLS_DIR="${CODEX_HOME:-$HOME/.codex}/skills"
mkdir -p "$CODEX_SKILLS_DIR"

# Copy the secure-code skill
if [ -d "skills/secure-code" ]; then
    cp -r skills/secure-code "$CODEX_SKILLS_DIR/"
    echo "Installed secure-code"
fi

# Copy the Ui skill
if [ -d "Ui" ]; then
    cp -r Ui "$CODEX_SKILLS_DIR/"
    echo "Installed Ui"
fi

echo " All skills installed! Restart Codex to use them."