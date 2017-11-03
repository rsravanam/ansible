#ansible-playbook site.yml -i inventory --ask-pass --tags "upload"
ansible-playbook site.yml -i inventory --sudo --ask-pass --extra-vars "my_hosts=nodes"
