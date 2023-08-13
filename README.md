# 👾 Sophos Teams Alerts 👾

Securely integrate Sophos Central with Microsoft Teams to streamline your cybersecurity alerts!

## 📜 Description

This project uses the siem.py script provided by Sophos to pull alert data from the security alerts endpoint. The output of the api request is sent to result.txt. My custom powershell script SiemPy.ps1 inputs the json data from result.txt, reformats the json data to send to a Teams webhook url, and finally sends the alert to the Teams channel. 

## 🚀 Getting Started

1. 📥 Clone this repository to your production environment.
2. 🛠 Modify the `Config.ini` file, replacing `<CLIENT_SECRET>`, `<CLIENT_ID>`, and `<TENANT_ID>` with your credentials.
3. 🧩 Configure an environment variable in your test environment to store the Teams webhook.
4. 🕰 Schedule a recurring task to run the script every minute, ensuring continuous monitoring.

## 🎓 Author

👤 **Derek Johnson**

## 📚 References

[Teams JSON Format](https://learn.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/connectors-using?tabs=cURL)
[Sophos GitHub](https://github.com/sophos/Sophos-Central-SIEM-Integration)
