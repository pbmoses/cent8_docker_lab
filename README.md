#Disposable Cent8 Docker with SSH to test Ansible playbooks. 2019 - pmo

#I was tired of slow VMs and other heavyweight tech to test Ansible playbooks and the like that just required SSH, ansible and python. I don't have a large home lab, I work mostly from a laptop and heavy VMs drain the battery. 

#the assumption is you are using your local machine as the Ansible controller with user sshuser 




#in no way or form is this meant for production. This is a not so lightweight ephemeral SSH/Ansible container. ephemeral means when you stop the container it's gone as well as any/all changes you made to it... what better way to test your disaster recovery :)


#naturally, there's a bunch this wouldn't handle. It's not be-all-end-all. It's just a simple scrappy tool for testing. 


###there's dozen differnt ways to achieve the end need. Do what suits you best. ###
 

# Building 

Copy the sources to your docker host and build the container:

        # docker build --rm -t localhost/cent8_ansible:v1 .
        

To run:

##CHANGE YOUR KEY PERMISSIONS! (chmod 600 demo_ansible_docker)


##NEVER RE-USE THESE KEYS OUTSIDE OF YOUR TEST ENVIRONMENT


##you'll probably want to either accept the keys in known_hosts or skip verification
(run as many as you would like, within reason for your hardware)


        #docker run -d -p 22 localhost/cent8_ansible:lv1
        (you can spin up as many containers as you need for your testing)
        
        #docker ps (look for your port, you need that to login)
       

       
To Generate an inventory.ini file:
        
        #docker ps --format "{{.ID}} {{.Ports}}" | awk -F' |:|-' 'BEGIN{ print "[all]"};{ print $1" ansible_connection=local" " ansible_ssh_port="$3 }'>inventory.ini


To test, use the port that was just located:

       #ssh -i ./demo_ansible_docker sshuser@0.0.0.0 -p 32776

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

Build your playbooks, your roles and experiment. Edit your inventory file to your preference. 
