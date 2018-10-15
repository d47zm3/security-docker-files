#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
no_color='\033[0m'

function decho
{
  string=${1}
  echo -e "[*] [$( date +'%H:%M:%S' )] ${string}"
}

function decho_red
{
  string=${1}
  echo -e  "[*] ${red}[$( date +'%H:%M:%S' )] ${string}${no_color}"
}

function decho_green
{
  string=${1}
  echo -e "[*] ${green}[$( date +'%H:%M:%S' )] ${string}${no_color}"
}

