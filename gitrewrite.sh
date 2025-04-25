#!/bin/sh

# New author details
NEW_NAME="micwonder"
NEW_EMAIL="130264564+micwonder@users.noreply.github.com"
SIGNOFF="Signed-off-by: $NEW_NAME <$NEW_EMAIL>"

# Use git filter-branch to update all commits
git filter-branch --env-filter "
if [ -n \"\$GIT_COMMITTER_NAME\" ]; then
    export GIT_COMMITTER_NAME=\"$NEW_NAME\"
    export GIT_COMMITTER_EMAIL=\"$NEW_EMAIL\"
fi
if [ -n \"\$GIT_AUTHOR_NAME\" ]; then
    export GIT_AUTHOR_NAME=\"$NEW_NAME\"
    export GIT_AUTHOR_EMAIL=\"$NEW_EMAIL\"
fi
" --tag-name-filter cat -- --branches --tags

# Rewrite commit messages to add Signed-off-by line
git filter-branch --msg-filter "
  # Add Signed-off-by line if not present
  if ! grep -q '^Signed-off-by:'; then
    echo \"$SIGNOFF\" >> \$(cat)\n
  fi
  cat
" -- --branches --tags

# Optional: Clean up backup refs created by filter-branch
rm -rf .git/refs/original/
