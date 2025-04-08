### Project Description:
This project provides a set of scripts to manage and validate Nginx rewrite rules. The primary script, `revise_nginx_rewrite_rules.sh`, processes a given Nginx configuration file to check the status of URLs and generate a revised configuration file with only live URLs. The `check_urls.sh` script is used to validate URLs independently. These tools are designed to streamline the management of Nginx rewrite rules and ensure that only valid URLs are included in the configuration.

### Running the .sh script:
**Have a *.conf file ready and specify its name when running the script.**

1. Open Terminal.

2. Navigate to the Script Directory:
```
cd /path/to/the/script/directory
```

3. Make the Script Executable:
```
chmod +x <file>
```

4. Run the Script:
For `revise_nginx_rewrite_rules.sh`, specify the configuration file as an argument:
```
./revise_nginx_rewrite_rules.sh <conf_file>
```

For `check_urls.sh`, specify the configuration file as an argument:
```
./check_urls.sh <conf_file>
```

5. Wait for the "Check completed." message in Terminal.

### To schedule the script to run automatically on macOS, use cron:

1. Open the Crontab File:
```
crontab -e
```

2. Add a Cron Job. For example, to run the script every day at 2 AM:
```
0 2 * * * /path/to/the/script/directory/<file>
```

3. Save and Exit.
