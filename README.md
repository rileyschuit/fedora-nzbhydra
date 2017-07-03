[![Build Status](https://travis-ci.org/rileyschuit/rpi-docker-nzbhydra.svg?branch=master)](https://travis-ci.org/rileyschuit/rpi-docker-nzbhydra)
  
# Docker nzbhydra to run on a Raspberry Pi  
Docker container for [NZBHydra](https://github.com/theotherp/nzbhydra) using Ubuntu ARM  
### Build from docker file:  
```
git clone https://github.com/rileyschuit/rpi-docker-nzbhydra
cd rpi-docker-nzbhydra
docker build -t rpi-docker-nzbhydra .
```
  
Pull from docker hub:  
  
```
docker run -d /path/to/config/dir:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -p 5075:5075 --name=nzbhydra rileyschuit/rpi-docker-nzbhydra 
```  
  
Create with a custom uid/gid for the nzbhydra daemon:

```bash
docker create -v /path/to/config/dir:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e LUID=1234 -e LGID=1234 \
    -p 5075:5075 --name=nzbhydra mattsch/fedora-nzbhydra
```
