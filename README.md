#Disposable Cent8 Docker with SSH to test Ansible playbooks. 2019 - pmo
#originally based off Adam Miller's Cent7 image https://github.com/CentOS/CentOS-Dockerfiles/blob/master/ssh/centos7/Dockerfile
#I was tired of slow VMs and other heavyweight tech to test Ansible playbooks and the like that just required SSH, ansible and python. I don't have a large home lab, I work mostly from a laptop and heavy VMs drain the battery. 
#the assumption is you are using your local machine as the Ansible controller with user ansible
#Ansible er should have a key generated and copied to the dir or script modified to distribute that key
#I.E.-- ssh-keygen -t rsa 
#in no way or form is this meant for production. This is a not so lightweight ephemeral SSH/Ansible container
#naturally, there's a bunch this wouldn't handle. It's not be-all-end-all. It's just a simple scrappy tool for testing. 
###there's dozen differnt ways to achieve the end need. Do what suits you best. ###
 

# Building 

Copy the sources to your docker host and build the container:

        # docker build --rm -t <username>/ssh:centos8 .
        

To run:
(run as many as you would like, within reason for your hardware)
        # docker run -d -p 22 <username>/ssh:centos8

        #docker ps (look for your port, you need that to login)
        ssh pmo@localhost -p <port from above> -- use the password from the start script for pass
To Generate an inventory.ini file:
        
        #docker ps --format "{{.ID}} {{.Ports}}" | awk -F' |:|-' 'BEGIN{ print "[all]"};{ print $1" ansible_connection=local" " ansible_ssh_port="$3 }'>inventory.ini


To test, use the port that was just located:

        # ssh -p <port> ansible@localhost 

To test Ansible:
        
        #ansible all -i inventory.ini -m ping 

Sample output:
       fb59a66ed022 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
