sudo systemctl restart firewalld.service

ss_ports=$(ss -tulpan | grep LISTEN | awk '{print $5}' | awk -F':' '{print $2}')
for port in $ss_ports; do
    protocol="tcp"
    if [[ $port == *"udp"* ]]; then
        protocol="udp"
    fi
    firewall-cmd --zone=public --add-port=$port/$protocol --permanent
done

firewall-cmd --reload
