#!/bin/bash

while true; do
    clear
    echo "OpenSSH Configuration Script"
    echo "-----------------------------"
    echo "1. Check existing SSH key pairs"
    echo "2. Generate new SSH key pair"
    echo "3. Start SSH service"
    echo "4. Stop SSH service"
    echo "5. Open new SSH connection"
    echo "6. Open key pair file location"
    echo "7. Add new SSH key pair to SSH agent"
    echo "8. Delete SSH key pair"
    echo "9. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            echo "Checking existing SSH key pairs..."
            ls -al ~/.ssh/*.pub
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        2)
            echo "Generating new SSH key pair..."
            ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
            echo "New SSH key pair generated."
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        3)
            echo "Starting SSH service..."
            sudo systemctl start ssh
            echo "SSH service started."
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        4)
            echo "Stopping SSH service..."
            sudo systemctl stop ssh
            echo "SSH service stopped."
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        5)
            read -p "Enter SSH server address: " server_address
            read -p "Enter SSH username: " username
            echo "Opening new SSH connection to $server_address as $username..."
            gnome-terminal -- ssh $username@$server_address
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        6)
            echo "Opening key pair file location..."
            xdg-open ~/.ssh/
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        7)
            echo "Adding new SSH key pair to SSH agent..."
            ssh-add ~/.ssh/id_rsa
            echo "SSH key pair added to SSH agent."
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        8)
            echo "Deleting SSH key pair..."
            files=(~/.ssh/*.pub)
            if [ ${#files[@]} -eq 0 ]; then
                echo "No SSH key pairs found."
            else
                echo "Select the SSH key pair to delete:"
                select file in "${files[@]}"; do
                    if [ -n "$file" ]; then
                        rm -i "$file" ~/.ssh/"$(basename "$file" .pub)"
                        echo "SSH key pair deleted."
                        break
                    else
                        echo "Invalid selection. Please try again."
                    fi
                done
            fi
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
        9)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please choose again."
            read -n 1 -s -r -p "Press any key to continue..."
            ;;
    esac
done
