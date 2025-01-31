# Git Author Rewrite Script

## Overview

This script is designed to update the author name and email for all commits in a Git repository. It uses the `git filter-branch` command to rewrite commit history, ensuring that all commits reflect the specified author details.

## Purpose

The primary purpose of this script is to change the author information for all commits in a repository. This can be useful in scenarios such as:

- Correcting incorrect author information.
- Updating author details after a change in email or name.
- Ensuring consistency in commit history for a project.

## Prerequisites

Before running this script, ensure that you have:

- Git installed on your machine.
- A backup of your repository, as this script rewrites history.
- Familiarity with command-line operations.

## Script Details

### Script Content

```
#!/bin/sh

# New author details
NEW_NAME="micwonder"
NEW_EMAIL="130264564+micwonder@users.noreply.github.com"

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

# Optional: Clean up backup refs created by filter-branch
rm -rf .git/refs/original/
```

### Explanation of the Script

1. **New Author Details**: 
   - The variables `NEW_NAME` and `NEW_EMAIL` are defined at the beginning of the script. Update these values to reflect the new author information you want to use.

2. **Git Filter-Branch Command**:
   - The command `git filter-branch --env-filter` is used to rewrite commit history.
   - The `--env-filter` option allows you to change environment variables (in this case, author and committer details) for each commit.
   - Inside the filter, it checks if the current committer and author names are set, and if so, updates them with the new values.

3. **Tag Name Filter**: 
   - The `--tag-name-filter cat` option ensures that existing tags are preserved during the rewrite process.

4. **Branches and Tags**: 
   - The `-- --branches --tags` part specifies that the changes should apply to all branches and tags in the repository.

5. **Cleanup**:
   - The line `rm -rf .git/refs/original/` removes backup references created during the filtering process.

### Warnings

When running this script, you may encounter warnings about using `git filter-branch`. It is recommended to consider using `git filter-repo`, which is a more modern tool for rewriting history without some of the pitfalls associated with `filter-branch`.

### Running the Script

To run this script:

1. Save it as `gitrewrite.sh`.
2. Make it executable:
   ```
   chmod +x gitrewrite.sh
   ```
3. Execute the script from your terminal:
   ```
   ./gitrewrite.sh
   ```

### Post-Script Actions

After running the script, if you have previously pushed commits to a remote repository, you will need to force push your changes:

```
git push origin --force --all
git push origin --force --tags
```

### Conclusion

This script provides an efficient way to update author information across all commits in a Git repository. Ensure that you communicate with your team before rewriting history, especially if working in a shared repository environment.

Feel free to customize any sections or add additional information based on your specific needs or preferences! This README.md file should help users understand how to use your script effectively and encourage them to star your project.

---
For more information and updates, visit my GitHub profile and **follow** me: [micwonder](https://github.com/micwonder)