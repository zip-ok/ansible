ansible-playbook tests/test.yml -i tests/inventory --vault-password-file=tests/vault_pass.txt

Role Name
=========

###   Build and Deploy freeswitch, unimrcp + mod_unimrcp

Requirements
------------

###   Ubuntu 22

Role Variables
--------------

###   check and change the vars as you need
###   defaults/main.yml
###   tests/test.yml (ansible_host, remote_user)

Dependencies
------------

Example Playbook
----------------

License
-------

BSD

Author Information
------------------

Docs
----

###   Look at these documents
###   https://github.com/freeswitch/mod_unimrcp
###   https://www.opensourcelisting.com/how-to-install-freeswitch-on-ubuntu-22-04/#Setup_systemd_FreeSWITCH_service