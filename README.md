<p align="left">
  <a href="https://github.com/vdarkobar/Home-Cloud#self-hosted-cloud">Home</a>
  <br><br>
</p> 
  
# Nginx Proxy Manager
### *As a Reverse Proxy for all of your Services!*  

<p align="center">
  <img src="https://github.com/vdarkobar/Home-Cloud/blob/main/shared/reverse-proxy.png">
</p>
  
---  
  
#### *Decide what you will use for*:
```
Time Zone nad NPM Port Number.
```
  
### *Run this command*:
```
RED='\033[0;31m'; echo -ne "${RED}Enter directory name: "; read DIR; \
mkdir -p "$DIR"; cd "$DIR" && git clone https://github.com/vdarkobar/npm.git . && \
chmod +x setup.sh && \
./setup.sh
```
  
Visit your *server local ip* + *port* designated during setup:
```
http://<LocalIP>:<PORT>
```

### Create <a href="https://dash.cloudflare.com/profile/api-tokens">CloudFlare API Token</a>. 

Used for *DNS Challenge* to create *Wildcard Certificates* for your entire Domain (*unlimited Subdomains*).
```
CloudFlare > Profile > API Tokens > Edit zone DNS - Template
Create Token (edit name: *.example.com) > 
Permissions: Zone-DNS-EDIT > Zone Resources: INCLUDE-ALL ZONES > Continue to summary > Create Token
```
Copy *Token* and paste it to:
```
Nginx Proxy Manager > SSL Certificates > Add SSL Certificate > Let's Encrypt > Domain Names (enter: *.example.com example.com) 

Enable: Use a DNS Challenge > CloudFlare > Credentials File Content * (paste Token after = sign).
```
