# DNS-LB-BIND
Demo for DNS LB - with health check

The infrastructure is based on a simple load-balancing of 2 Web Server (not really needed for the purposes of the demo as of 03/12/2021 but this is to be expanded)

To run the demo: 
- Start the Docker environment that consists of: 
    - 1x NGINX Plus instance with App Protect
    - 2x NGINX OSS instances with a simple website
    - 1x ISC BIND 9.16 container

If this is the first time you are running the docker environment that includes the 4 containers above, make sure to build/download them accordingly.    
You will need a key and cert to access the NGINX Plus code and place them in the nginx-app-protect/etc/ssl/nginx directory.  Once you have that in place, all you will need to do is run: 
```bash 
docker-compose build --no-cache
```

This will download all the appropriate code and necessary pre-built containers. 

Note: before you start the containers, make sure you have the right amount of resources associated with the Docker environment to run the rather resource heavy ELK and NGINX App Protect Containers. 

To start the containers: 
```bash
docker-compose up
```

Once the containers are running:
- verify that the site is available by pointing a browser (curl or chrome) to: https://localhost
- verify that the DNS proxy is currently working - from the cli: dig www.example.com @localhost -p 1053
- check that the NGINX Plus instance is processing traffic by inspecting the dashboard at: http://localhost:8080
- you can now run a script to generate good and bad traffic using the load_logs.sh script:
```bash
sh ./load_logs.sh
```

The purpose of this lab is to work on getting DNS LB working with health checking - 
Liam has a great blog post on how to do this: [configuring dns load balancing](https://www.nginx.com/blog/load-balancing-dns-traffic-nginx-plus/)


The best way to get this running is to leverage a traffic capture using tcpdump and/or wireshark. Start off by capturing the traffic to the working DNS server and get a request/response that is representative of what you are looking to check against. (in the example below, I have a BIND server authoritative for example.com – and I just query it for www.example.com and capture the exchange w/ Wireshark)
 
The stream configuration block for NGINX Plus would look like: 
```bash
stream {
    match dns_lookup {
        send \x44\x1c\x01\x20\x00\x01\x00\x00\x00\x00\x00\x01\x03\x77\x77\x77\x07\x65\x78\x61\x6d\x70\x6c\x65\x03\x63\x6f\x6d\x00\x00\x01\x00\x01\x00\x00\x29\x10\x00\x00\x00\x00\x00\x00\x00;
        expect ~* \x03\x6e\x73\x32\xc0;
    }
 
    upstream dns_servers {
        zone dns_zone 64k;
        server bind-01:53;
    }
    server {
        listen 53;
        listen 53 udp;
        proxy_pass dns_servers;
        health_check match=dns_lookup interval=20 fails=2 passes=2 udp;
        error_log /var/log/nginx/dns.log info;
    }
}
```

Where the “\x44\x1c\x01\...” string comes from Wireshark.  
The nice thing is that you can grab the contents directly from Wireshark by exporting as *'escaped string'*.  
For the \x03\x6e\x73\x32\xc0 portion of the “expect mantra” – same principle as above – just took a portion of the DNS response to matched against. 
