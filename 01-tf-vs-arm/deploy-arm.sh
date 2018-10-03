#!/bin/bash

az group create -n "terraform-training-01-arm" --location "Canada East"
az group deployment create -g "terraform-training-01-arm" --template-file azuredeploy.json