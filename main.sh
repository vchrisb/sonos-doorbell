#!/bin/bash

python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt

python3 sonos-doorbell.py "Kitchen" --port 8888
