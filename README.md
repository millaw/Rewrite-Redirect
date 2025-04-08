### Project Description:
This project provides a set of scripts to manage and validate rewrite rules for Nginx, Apache, and `.htaccess` configuration files. The primary script, `revise_rewrite_rules.sh`, processes a given configuration file to check the status of URLs and generate a revised configuration file with only live URLs. The `check_urls.sh` script is used to validate URLs independently. These tools are designed to streamline the management of rewrite rules and ensure that only valid URLs are included in the configuration.

### Running the Scripts:
**Have a configuration file ready and specify its name and type when running the script.**

1. Open Terminal.

2. Navigate to the Script Directory:
```
cd c:\Users\mwynn\Desktop\Plugins\rewrite-redirect
```

3. Make the Script Executable (if using a Linux-like environment):
```
chmod +x <file>
```

4. Run the `revise_rewrite_rules.sh` Script:
Specify the configuration file and the type (`nginx`, `apache`, or `htaccess`) as arguments:
```
./revise_rewrite_rules.sh <conf_file> <type>
```

For example:
- To process Nginx rewrite rules:
  ```
  ./revise_rewrite_rules.sh nginx_hostrewrites_for_cunyedu.conf nginx
  ```
- To process Apache redirects:
  ```
  ./revise_rewrite_rules.sh apache_redirects.conf apache
  ```
- To process `.htaccess` rewrite rules:
  ```
  ./revise_rewrite_rules.sh htaccess_rules.conf htaccess
  ```

5. Run the `check_urls.sh` Script:
Specify the configuration file as an argument:
```
./check_urls.sh <conf_file>
```

6. Wait for the "Check completed." message in Terminal.

### Output Files:
The results will be saved in the `CompletedChecks/` directory:
- `live_urls.txt`: Contains live URLs.
- `not_live_urls.txt`: Contains non-live URLs.
- `revised_<conf_file>`: Contains revised configuration rules.

### To Schedule the Script to Run Automatically:
Use a task scheduler like `cron` (on Linux/macOS) or Task Scheduler (on Windows) to automate the script execution.
