#!/bin/bash

echo "Logging in to Azure. Please follow the prompt to authenticate"

az login

if [ $? -ne 0 ]; then
  echo "Login Failed. Please Try Again"
  exit 1
fi 

RESOURCE_GROUP="NCPL-Project-6"
RESOURCE_GROUP_TEST="NCPL-Project-6-Test"
Location="centralindia"
VM_NAME="NCPLProject6VM"
ADMIN_USERNAME="azureuser"
ADMIN_PASSWORD="P@ssw0rd123!"

echo "Creating a Resource Group: $RESOURCE_GROUP in $Location ..."

az group create --name "$RESOURCE_GROUP" --location "$Location"

if [ $? -ne 0 ]; then
  echo "Failed to create a Resource Group. Please check azure subscription"
  exit 1
fi

echo "Creating a Resource Group: $RESOURCE_GROUP_TEST in $Location ..."

az group create --name "$RESOURCE_GROUP_TEST" --location "$Location"

if [ $? -ne 0 ]; then
  echo "Failed to create a Resource Group. Please check azure subscription"
  exit 1
fi

echo "Creating a Windows Virtual machine: $VM_NAME in Resource Group $RESOURCE_GROUP"

az vm create --resource-group "$RESOURCE_GROUP" --name "$VM_NAME" --image "UbuntuLTS" --admin-username "$ADMIN_USERNAME" --admin-password "$ADMIN_PASSWORD" --size "Standard_B2s"

if [ $? -ne 0 ]; then
  echo "Failed to create a Virtual Machine. Please check provided Parameters"
  exit 1
fi

echo "Opening port 3389 on Virtual Machine $VM_NAME for RDP Access"
az vm open-port --resource-group "$RESOURCE_GROUP" --name "$VM_NAME" --port 3389

if [ $? -ne 0 ]; then
  echo "Failed to create a Virtual Machine. Please check provided Parameters"
  exit 1
fi

echo "Windows Virtual Machine $VM_NAME created successfully in Resource Group $RESOURCE_GROUP !"



