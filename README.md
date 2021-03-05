# NAP Local Demo
The previous README file got removed. 

To run the demo: 
- Start the Docker environment that consists of: 
    - 1x NGINX Plus instance with App Protect
    - 2x NGINX OSS instances with a simple website
    - 1x ELK Stack that will be listening for logs coming from the App Protect instance

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
- check that the NGINX Plus instance is processing traffic by inspecting the dashboard at: http://localhost:8080
- you can now run a script to generate good and bad traffic using the load_logs.sh script:
```bash
sh ./load_logs.sh
```
This script sends repeated requests using curl to the NGINX App Protect instance.  Some of the requests will be detected as malicious and blocked by the WAF.  You can see the requests by accessing the ELK Stack at http://localhost:5601.  You will need to look at the Dashboard>>Overview page to see graphs.  For more information about the ELK Stack, please refer to: [devCentral Github](https://github.com/f5devcentral/f5-waf-elk-dashboards)

**Warning** there is limited space in the ELK container for logs - do not run the script above for more than a minute or so.  If you run into issues, clear the log index (Management>>Elasticserach--Index Management>>Manage Index..Delete Index)