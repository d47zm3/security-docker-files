# security docker files

To improve DevSecOps, Penetration Testing etc. Some tools have already automated, public Docker repositories so I'm reusing them.


## nmap

download latest package from nmap site, install it, staged build for minimal size.


## nikto

clone latest version from repository.


## htrace

use modified dockerfile from original repository [here](https://github.com/trimstray/htrace.sh) to include image name


## arachni

long, deep scan, work in progress


## owasp zap

owasp scanner for most common web application issues

## gitrob

scanning github repositories for sensitive data


## spiderfoot

advanced osint platform that has plugins for ton of third party platform, allows for saving settings like api keys by volume mounting database of spiderfoot


## maltego

osint platform with gui, credits to guy [here](https://github.com/danielguerra69/kali-maltego) 


## domained

tool to enumerate subdomains, using many already available tools, [source](https://github.com/cakinney/domained)
