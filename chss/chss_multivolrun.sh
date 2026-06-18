#!/usr/bin/env bash
# -------------------------------------------------------------
#
#   For n = 1 … 63
#       1. cd to /path/to/volume‑n
#       2. execute the Python fixer
#       3. commit the resulting changes
#
#   All steps are run sequentially (the script will stop if any
#   step fails).  It also adds all changes before committing.
#
# Usage
#   1. Make the script executable:
#          chmod +x run_fix_bmd_and_commit.sh
#   2. Run it:
#          ./run_fix_bmd_and_commit.sh
#
# -------------------------------------------------------------

set -euo pipefail   # Abort on error, treat unset variables as error

PYTHON_SCRIPT="/path/to/run_fix_bmd.py"
BASE_DIR="/path/to/basedir"

for n in {1..63}; do
    echo "=== Processing volume-$n ==="

    # 1. Change directory
    target="${BASE_DIR}/volume-${n}"
    if [[ ! -d "${target}" ]]; then
        echo "ERROR: Directory ${target} does not exist. Aborting." >&2
        exit 1
    fi
    cd "${target}"

    # 2. Run the Python script
    echo "    Running Python fixer ..."
    python "${PYTHON_SCRIPT}"
    echo "    Python script finished."

    # 3. Commit the changes
    echo "    Adding changes to git ..."
    git add -A   # Add all modified / new / deleted files

    echo "    Committing changes ..."
    git commit -m "chore: run stray character connection on vol ${n}" || true
    # If there was nothing to commit, git commit exits with code 1.
    # To keep the script running, we catch that case and skip the error.
    if [[ $? -eq 1 ]]; then
        echo "    No changes to commit for vol ${n}."
    else
        echo "    Commit created."
    fi

    echo "=== Finished volume-$n ==="
    echo
done

echo "All volumes processed successfully."

