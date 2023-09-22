#!/bin/bash
# Define shop names and their corresponding PHP versions (add or remove shops as needed)
declare -A shops_php_versions=(
    ["shop1"]="8.1"
    ["shop2"]="8.0"
    ["shop3"]="7.4"
    ["dev.shop1"]="8.1"
    ["dev.shop2"]="8.0"
    ["dev.shop3"]="7.4"
)

# Function to create a Shopware 5 user for a shop
create_shopware_user() {
    shop_name="$1"
    full_name="$2"
    password="$3"

    # Generate username from full name (lowercase, spaces replaced with '-')
    username=$(echo "$full_name" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

    # Define email based on the last name
    lastName=$(echo "$full_name" | awk '{print $2}')
    email="$lastName@e-mail.de"

    # Determine the correct directory path based on shop name
    if
        [ "$shop_name" == "shop1" ] ||
        [ "$shop_name" == "shop1" ] || 
        [ "$shop_name" == "shop3" ] || ; ;
    then
        directory="directory where the console is"
    elif 
        [ "$shop_name" == "dev.shop1" ] ||
        [ "$shop_name" == "dev.shop2" ] ||
        [ "$shop_name" == "dev.shop3" ] || ;
    then
        directory="directory for the dev stages"
    else
        echo "Houston, we've got a problem! Invalid shop name."
    fi

    # Get the PHP version for the shop from the associative array
    php_version="${shops_php_versions[$shop_name]}"

    # Check if a valid PHP version was found
    if [ -z "$php_version" ]; then
        echo "Invalid PHP version for shop: $shop_name"
        return 1
    fi

    # SSH into the server and run the command with the specified PHP version and password
    ssh -T "$shop_name" <<EOF
        # Change to the Shopware directory
        cd "$directory"

        # Create the Shopware user with the specified PHP version, email, username, and password
        php$php_version bin/console sw:admin:create --email="$email" --username="$username" --name="$full_name" --password="$password" --no-interaction
EOF
}

# Check if the full name and password are provided as arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <full_name> <password>"
    exit 1
fi

full_name="$1"
password="$2"

# Iterate through the list of shop names and create Shopware users for each shop
for shop in "${!shops_php_versions[@]}"; do
    create_shopware_user "$shop" "$full_name" "$password"
done
