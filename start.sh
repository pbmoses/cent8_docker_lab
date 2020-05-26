#!/bin/bash
##breakglass in case you F up the keys. 
###obviously never use this in any public/prod env. 

__create_user() {
# Create a user to SSH into as.
useradd sshuser 
SSH_USERPASS=newpass
echo -e "$SSH_USERPASS" | (passwd --stdin sshuser)
echo ssh user password: $SSH_USERPASS
}

# Call all functions
__create_user
