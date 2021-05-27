read -p "Wat is uw naam " _klantnaam
read -p "Kies uw optie: 1:Maak productieomgeving 2:Maak testomgeving 3:Verwijder omgeving 4:Verwijder testomgeving 5:Pas RAM geheugen aan in productieomgeving 6:Pas RAM geheugen aan in testomgeving " _optie

case $_optie in
  "1") mkdir ~/vm2/klanten/$_klantnaam
       cp ~/vm2/templates/ansible.cfg ~/vm2/klanten/$_klantnaam/ansible.cfg
       cp ~/vm2/templates/inventory ~/vm2/klanten/$_klantnaam/inventory
       cp ~/vm2/templates/Vagrantfile ~/vm2/klanten/$_klantnaam/Vagrantfile
       cd ~/vm2/klanten/$_klantnaam
       read -p "Welk netwerk wilt u gebruiken? " _netadd
       sed -i "s/testklant1/$_klantnaam/g" "Vagrantfile"
       sed -i  "s/netip/$_netadd/g" "Vagrantfile"
       sed -i "s/testklant1/$_klantnaam/g" "inventory"
       sed -i  "s/netip/$_netadd/g" "inventory"
       vagrant up
       ssh-keyscan 192.168.$_netadd.11 $_klantnaam-webserver1 >> ~/.ssh/known_hosts
       ssh-keyscan 192.168.$_netadd.12 $_klantnaam-webserver2 >> ~/.ssh/known_hosts
       ssh-keyscan 192.168.$_netadd.13 $_klantnaam-loadbalancer >> ~/.ssh/known_hosts
       ssh-keyscan 192.168.$_netadd.14 $_klantnaam-databaseserver >> ~/.ssh/known_hosts
       cp ~/vm2/templates/html.j2 ~/vm2/playbooks/webserver/templates/html.j2
       cd ~/vm2/playbooks/webserver/templates
       sed -i  "s/netip/$_netadd/g" "html.j2"
       cd ~/vm2/playbooks
       ansible-playbook -i ~/vm2/klanten/$_klantnaam/inventory vm2.yml
       cd ~/vm2/playbooks/webserver/templates
       rm html.j2
  ;;
  "2") mkdir ~/vm2/test/$_klantnaam
       cp ~/vm2/templates/ansible.cfg ~/vm2/test/$_klantnaam/ansible.cfg
       cp ~/vm2/templates/inventory ~/vm2/test/$_klantnaam/inventory
       cp ~/vm2/templates/Vagrantfile ~/vm2/test/$_klantnaam/Vagrantfile
       cd ~/vm2/test/$_klantnaam
       read -p "Welk netwerk wilt u gebruiken? " _netadd
       sed -i "s/testklant1/$_klantnaam/g" "Vagrantfile"
       sed -i  "s/netip/$_netadd/g" "Vagrantfile"
       sed -i "s/testklant1/$_klantnaam/g" "inventory"
       sed -i  "s/netip/$_netadd/g" "inventory"
       vagrant up
       ssh-keyscan 192.168.$_netadd.11 $_klantnaam-webserver1 >> ~/.ssh/known_hosts
       ssh-keyscan 192.168.$_netadd.12 $_klantnaam-webserver2 >> ~/.ssh/known_hosts
       ssh-keyscan 192.168.$_netadd.13 $_klantnaam-loadbalancer >> ~/.ssh/known_hosts
       ssh-keyscan 192.168.$_netadd.14 $_klantnaam-databaseserver >> ~/.ssh/known_hosts
       cp ~/vm2/templates/html.j2 ~/vm2/playbooks/webserver/templates/html.j2
       cd ~/vm2/playbooks/webserver/templates
       sed -i  "s/netip/$_netadd/g" "html.j2"
       cd ~/vm2/playbooks
       ansible-playbook -i ~/vm2/test/$_klantnaam/inventory vm2.yml
       cd ~/vm2/playbooks/webserver/templates
       rm html.j2
  ;;
  "3") cd ~/vm2/klanten/$_klantnaam
       vagrant destroy -f
       cd ..
       rm -r $_klantnaam
  ;;
  "4") cd ~/vm2/test/$_klantnaam
       vagrant destroy -f
       cd ..
       rm -r $_klantnaam
  ;;
  "5") read -p "Hoeveel RAM geheugen moeten de vm's hebben in mb? " _mem
       cd ~/vm2/klanten/$_klantnaam
       sed -i "s/512/$_mem/g" "Vagrantfile"
       vagrant reload
  ;;
  "6") read -p "Hoeveel RAM geheugen moeten de vm's hebben in mb? " _mem
       cd ~/vm2/test/$_klantnaam
       sed -i "s/512/$_mem/g" "Vagrantfile"
       vagrant reload
  ;;
  *) echo "Deze optie is niet geldig"
esac
