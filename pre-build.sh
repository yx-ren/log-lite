#!/bin/sh

usage()
{
    echo "usage: $0 [package]"
    exit 1
}

smart_install()
{
    if [ $# -ne 1 ]; then
        usage
    fi

    PACKAGE_NAME="$1"
    DUMMY=$(dpkg -l | grep -E "^.* $PACKAGE_NAME .*$")
    RESULT=$(echo $?)

    if [ $RESULT -ne 0 ]; then
        while true
        do
            read -p "preparing to install package: $PACKAGE_NAME, [yes/no]: " prompt
            case $prompt in
            y|yes)
                sudo apt-get -y install "$PACKAGE_NAME"
                break;;
            n|no)
                break;;
            *)
            echo "error choice: " $prompt;;
            esac
        done
    else
        echo "$PACKAGE_NAME has already installed."
    fi
}

smart_install sqlite3
smart_install libsqlite3-dev
smart_install uuid-dev
smart_install libicu-dev