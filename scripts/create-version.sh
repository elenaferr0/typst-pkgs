
# Check if both parameters are provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 library_name"
    exit 1
fi

username="elenaferr0"
library="$1"

# Get the latest version from the directory
prev_version=$(ls "$username/$library/" | sort | tail -n 1)

# Extract the version number (assuming version format like "1.2.3")
IFS='.' read -r major minor patch <<< "$prev_version"

# Increment the patch version by 1
new_version="$major.$minor.$((patch + 1))"

# Prompt the user if they want to increase the patch version, without moving to a new line
echo -n "Previous version: $prev_version. Increase by 1 patch ($new_version)? [Y/n] "

# Read user input
read -r response

# If user does not agree, ask for the new version
if [[ ! "$response" =~ ^[Yy]$ && -n "$response" ]]; then
    echo -n "Please enter the new version (e.g., 1.2.4): "
    read -r new_version
fi

echo "Creating folder for version $new_version..."
cp -r "$username/$library/$prev_version" "$username/$library/$new_version"

echo "Updating typst.toml version to $new_version..."
sed "s/$prev_version/$new_version/" "$username/$library/$prev_version/typst.toml" > "$username/$library/$new_version/typst.toml"

echo "Done."
