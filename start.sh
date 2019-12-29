#!/bin/bash

__create_user() {
# Create a user to SSH into as.
useradd pmo 
SSH_USERPASS=newpass
echo -e "$SSH_USERPASS\n$SSH_USERPASS" | (passwd --stdin pmo)
echo ssh user password: $SSH_USERPASS
}

# Call all functions
__create_user
