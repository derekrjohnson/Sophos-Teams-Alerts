# Set environment variables
# $Env:TEAMS_WEBHOOK_URL = "C:\processing\sophos_teams_alerts\webhook-url"

# Calculate the Unix timestamp for one minute ago
# $unix_timestamp = [int][double]::Parse((Get-Date (Get-Date).AddMinutes(-2) -UFormat %s))

# paths
$pythonPath = "C:\Program Files\Python311\python.exe"
$siemPath = "C:\processing\sophos_teams_alerts\siem.py"

# Run the python script
Start-Process -FilePath $pythonPath -ArgumentList $siemPath, "-q", "-l" -Wait
Write-Host "siem.py has run successfully."

# Set input file path
$input_file = 'C:\processing\sophos_teams_alerts\log\result.txt'

# Check if the input file exists and has content
if ((Test-Path $input_file) -and (Get-Item $input_file).Length -gt 0) {
    Write-Host "Input file exists and has content."

    # Read data from input file
    $json_content = Get-Content $input_file -Raw
    $json_objects = $json_content -split '\r?\n' | Where-Object { $_ -match '^{.*}$' } | ConvertFrom-Json

    # Check if the JSON objects exist
    if ($json_objects) {
        Write-Host "JSON objects found. Starting processing."

        # Process each JSON object
        foreach ($data in $json_objects) {

            # Create the facts array for the current JSON object
            $facts = @(
                @{
                    "name" = "Type"
                    "value" = $data.type
                },
                @{
                    "name" = "Severity"
                    "value" = $data.severity
                },
                @{
                    "name" = "Source Info"
                    "value" = "@{ip=$($data.source_info.ip)}"
                },
                @{
                    "name" = "Customer ID"
                    "value" = $data.customer_id
                },
                @{
                    "name" = "Endpoint ID"
                    "value" = $data.endpoint_id
                },
                @{
                    "name" = "Endpoint Type"
                    "value" = $data.endpoint_type
                },
                @{
                    "name" = "Name"
                    "value" = $data.name
                },
                @{
                    "name" = "ID"
                    "value" = $data.id
                },
                @{
                    "name" = "Group"
                    "value" = $data.group
                },
                @{
                    "name" = "Datastream"
                    "value" = $data.datastream
                },
                @{
                    "name" = "SUSER"
                    "value" = $data.suser
                },
                @{
                    "name" = "RT"
                    "value" = $data.rt
                },
                @{
                    "name" = "DUID"
                    "value" = $data.duid
                },
                @{
                    "name" = "END"
                    "value" = $data.end
                },
                @{
                    "name" = "DHOST"
                    "value" = $data.dhost
                }
            )

            # Create the message object
            $message = @{
                "@type" = "MessageCard"
                "@context" = "http://schema.org/extensions"
                "themeColor" = "0076D7"
                "summary" = "Summary of the message"
                "sections" = @(
                    @{
                        "activityTitle" = "Sophos Security Alert"
                        "facts" = $facts
                    }
                )
                "markdown" = $true
            }

            # Convert message object to JSON
            $json_data = $message | ConvertTo-Json -Depth 10

            # Set webhook URL
            $webhook_receiver_url = [Environment]::GetEnvironmentVariable('TEAMS_WEBHOOK_URL')

            # Send POST request to webhook URL
            if ($data.severity -in @("medium", "high", "critical")) {
                $response = Invoke-WebRequest -Uri $webhook_receiver_url -UseBasicParsing -Method "POST" -ContentType "application/json" -Body $json_data
            } else {
                Write-Host "Severity is low. Not sending to Teams."
            }

            # Check the response status code
            if ($response.StatusCode -eq 200) {
                Write-Host "JSON file '$input_file' successfully sent to Teams."

                # Clear the result.txt file
                Set-Content -Path $input_file -Value $null
            } else {
                Write-Host "Failed to send JSON file '$input_file' to Teams. Status code: $($response.StatusCode)"
            }
        }
    } else {
        Write-Host "No JSON objects found in the input file."
    }
} else {
    Write-Host "Input file '$input_file' does not exist or is empty."
}
