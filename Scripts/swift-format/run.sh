#!/bin/bash

##################################################################
# Runs swift-format and replaces current files.
#
# It formats any modified swift file
##################################################################

# Get the root directory of the git repository
ROOT_DIR=$(git rev-parse --show-toplevel)

# Get modified Swift files
MODIFIED_SWIFT_FILES=()
GIT_DIFF_OUTPUT=$(git diff --name-only)

# Debugging: List all files detected by git diff
echo "Root directory: $ROOT_DIR"
echo "Detected files from git diff:"
echo "$GIT_DIFF_OUTPUT"

# Iterate through each file detected by git diff
while IFS= read -r line; do
  if [[ $line == *".swift"* ]]; then
    # Build absolute path using git diff output and root directory
    ABSOLUTE_PATH="${ROOT_DIR}/${line}"

    # Debugging: Print the absolute path of each file
    echo "Absolute path of detected file: $ABSOLUTE_PATH"

    # Add the file to the list of modified files
    MODIFIED_SWIFT_FILES+=("$ABSOLUTE_PATH")
  fi
done <<< "$GIT_DIFF_OUTPUT"

# Check if we have any Swift files to format
if [ ${#MODIFIED_SWIFT_FILES[@]} -eq 0 ]; then
  echo "There are no Swift files to format!"
  exit 1
fi

# Output the version of swift-format
echo "Swift-format version: $(swift-format --version)"

# Format the detected Swift files
echo "Formatting Swift files..."
for file in "${MODIFIED_SWIFT_FILES[@]}"; do
  # Check if the file exists
  if [ -f "$file" ]; then
    echo "Formatting: $file"
    swift-format format \
      --configuration "${ROOT_DIR}/Scripts/swift-format/.swift-format.json" \
      --in-place \
      --ignore-unparsable-files \
      "$file"
  else
    echo "❌ File does not exist or is not readable: $file"
    # Debugging: Check the absolute path
    echo "Checking if the file exists manually:"
    ls "$file"
  fi
done

