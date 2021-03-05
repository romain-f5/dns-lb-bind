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

