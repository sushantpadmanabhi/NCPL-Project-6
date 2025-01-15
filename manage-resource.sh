#!/bin/bash

echo "Logging in to Azure. Please follow the prompt to authenticate."

az login

if [ $? -ne 0 ]; then
  echo "Login Failed. Please Try Again"
  exit 1
fi

RESOURCE_GROUP="NCPL-Project-6"
LOCATION="centralindia"
STORAGE_ACCOUNT_NAME="ncplstorageaccount"

echo "Creating a Storage Account $STORAGE_ACCOUNT_NAME in Resource Group $RESOURCE_GROUP ..."

az storage account create --name "$STORAGE_ACCOUNT_NAME" --resource-group "$RESOURCE_GROUP" --location "$LOCATION" --sku Standard_LRS

if [ $? -ne 0 ]; then
  echo "Failed to create a storage account. Please check azure subscription and permissions"
  exit 1
fi

echo "Storage Account $STORAGE_ACCOUNT_NAME created successfully!"

echo "Listing all resource groups in Azure Subscription"

az group list --output table

if [ $? -ne 0 ]; then
  echo "Failed to list resource groups. Please try again"
  exit 1
fi

echo "Deleting a Resource Group"

echo 

read -p "Enter the name of the resource group to delete: " RESOURCE_GROUP_TO_DELETE
read -p "Are you sure you want to delete the resource group $RESOURCE_GROUP_TO_DELETE ? (yes/no)" CONFIRM

if [ "$CONFIRM" == yes ]; then
    echo "Deleting the resource group $RESOURCE_GROUP_TO_DELETE ..."

    az group delete --name "$RESOURCE_GROUP_TO_DELETE" --yes --no-wait

    if [ $? -eq 0 ]; then
        echo "Resource group $RESOURCE_GROUP_TO_DELETE deletion initiated successfully"
    else
        echo "Failed to delete resource group $RESOURCE_GROUP_TO_DELETE"
    fi 
else
    echo "Deletion of Resource Group $RESOURCE_GROUP_TO_DELETE Cancelled"




