# dokcer4andoridBuild
 
 docker & script to run a Azure pipeline android docker image
 
 ## build an image

`sudo docker build -t dockeragent:latest .`

## run a instance 


```
sudo docker run 
 --privileged 
 -v /dev/bus/usb:/dev/bus/usb 
 -e AZP_URL=https://dev.azure.com/coretex-dev-ops 
 -e AZP_TOKEN=xxxx 
 -e AZP_AGENT_NAME=engdocker4 
 -e AZP_POOL=corehub dockeragent:latest
 ```
