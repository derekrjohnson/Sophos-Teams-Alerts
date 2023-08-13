# 👾 Sophos Teams Alerts 👾

Securely integrate Sophos Central with Microsoft Teams to streamline your cybersecurity alerts!

## 📜 Description

This repository hosts a Python script provided by Sophos. The script utilizes `config.ini` to configure crucial parameters such as client secret, client ID, and tenant ID. It also includes a custom `SiemPy.ps1` script.

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
