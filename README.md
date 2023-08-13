# Sophos Teams Alerts #

This project runs a python script provided by sophos that uses config.ini which is where you specifiy the client secret, client id, and tennant id.

### What is this repository for? ###

This repository contains all the files for the sophos provided siem.py script and the custom SiemPy.ps1 script.

### Getting Started ###

* Clone this repo to the production environment.
* Replace the <CLIENT_SECRET> <CLIENT_ID> <TENNANT_ID> in Config.ini.
* Set an environment variable in the test environment to store the teams webhook.
* Set a task to run the script every minute of every day.

### Warning: This is the production repository all tests should be implemented into the test repository ###

### Author ###

Derek

### References ###
 * [Teams Json Format](https://learn.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/connectors-using?tabs=cURL)
 * [Sophos Github](https://github.com/sophos/Sophos-Central-SIEM-Integration)
