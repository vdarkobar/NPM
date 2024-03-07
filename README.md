<p align="left">
  <a href="https://github.com/vdarkobar/Home-Cloud#self-hosted-cloud">Home</a>
  <br><br>
</p> 
  
# Nginx Proxy Manager
### *as a Reverse Proxy for all of your Services!*  

<p align="center">
  <img src="https://github.com/vdarkobar/Home-Cloud/blob/main/shared/reverse-proxy.png">
</p>
  
---  

<p align="center">
Enable Port forwarding (80, 443) from your Router/Firewall to your NPM instance (VM).
</p>  

---  
  
#### Decide what you will use for:
  
> *Directory name, Time Zone* and *NPM Port Number*.
  
### *Run this command*:
```
RED='\033[0;31m'; NC='\033[0m'; echo -ne "${RED}Enter directory name: ${NC}"; read DIR; mkdir -p "$DIR"; \
cd "$DIR" && git clone https://github.com/vdarkobar/npm.git . && \
chmod +x setup.sh && \
./setup.sh
```
  
Visit your *server local ip* + *port number* designated during setup:  
```Bash
http://LocalIP:PortNumber  
```
  
Default Administrator User name:  `admin@example.com`, password: `changeme`.
```
  
### Create <a href="https://dash.cloudflare.com/profile/api-tokens">CloudFlare API Token</a>. 

Used for *DNS Challenge* to create *Wildcard Certificates* for your entire Domain (*unlimited Subdomains*).
  
> CloudFlare: Profile > API Tokens > Create Token > Edit zone DNS - Use Template  
  
> Create Token: change the name (use Domain name with the star in front: *.example.com)  
  
> Permissions: Zone > DNS > Edit
  
> Zone Resources: Include > Specific Zone > example.com
  
> Client IP Address Filtering: *skip or set up if you have fixed ip address
  
> TTL: skip or define how long this token will stay active
  
> Continue to summary > Create Token
  
### Copy *Token* and paste it to:
  
> Nginx Proxy Manager > SSL Certificates > Add SSL Certificate > Let's Encrypt > Domain Names (enter: *.example.com example.com) 

> Enable: Use a DNS Challenge > CloudFlare > Credentials File Content * (paste Token after = sign) > Save  
  
     
<a href="https://github.com/vdarkobar/NPM/blob/main/README.md#nginx-proxy-manager">top of the page</a>  
