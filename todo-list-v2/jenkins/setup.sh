#!/bin/bash

# install apt dependencies
sudo apt update
sudo apt install python3-venv python3-pip python3 -y

# create virtual environment
python3 -m venv venv

# activate virtual environment
source venv/bin/activate

# install our pip requirements (from requirements.txt)
pip3 install -r requirements.txt
