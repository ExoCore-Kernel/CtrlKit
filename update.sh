#!/bin/sh
# Update script for CtrlKit repository
# Usage: ./update.sh [remote]
# Default remote is 'origin'.

REMOTE="${1:-origin}"

# Verify git is available
if ! command -v git >/dev/null 2>&1; then
    echo "git command not found. Please install git." >&2
    exit 1
fi

# Move to the script's directory (repo root)
cd "$(dirname "$0")" || exit 1

# Check that the remote exists
if ! git remote get-url "$REMOTE" >/dev/null 2>&1; then
    echo "Remote '$REMOTE' not found. Add it with:\n  git remote add $REMOTE <url>" >&2
    exit 1
fi

# Fetch latest commits from the remote
if ! git fetch "$REMOTE"; then
    echo "Failed to fetch from $REMOTE" >&2
    exit 1
fi

BRANCH=$(git rev-parse --abbrev-ref HEAD)
REMOTE_REF="$REMOTE/$BRANCH"
LOCAL_HASH=$(git rev-parse HEAD)
REMOTE_HASH=$(git rev-parse "$REMOTE_REF")

if [ "$LOCAL_HASH" = "$REMOTE_HASH" ]; then
    echo "Already up to date with $REMOTE_REF."
    exit 0
fi

echo "Updating $BRANCH from $REMOTE_REF..."
if git merge --ff-only "$REMOTE_REF"; then
    echo "Update complete."
else
    echo "Merge failed. Resolve conflicts manually and run 'git merge --continue'." >&2
    exit 1
fi
