You can configure your Raspberry Pi to run a script called `ubiais.sh` on every reboot without requiring user login using a few different methods. Here are two common and recommended approaches:

**1. Using systemd (Recommended):**

This is the most modern and robust method.  Systemd is the system and service manager for Linux systems, including Raspberry Pi OS.

* **Create a systemd service file:**

```bash
sudo nano /etc/systemd/system/ubiais.service
```

* **Paste the following configuration into the file, adjusting the paths and user as needed:**

```ini
[Unit]
Description=Ubiais Script
After=network-online.target  # Ensures network is up before script runs
Wants=network-online.target

[Service]
User=pi  # Change to the user that should run the script (usually 'pi')
WorkingDirectory=/home/pi/scripts  # Change to the directory containing ubiais.sh
ExecStart=/home/pi/scripts/ubiais.sh  # Change to the full path of your script
Restart=always  # Optional: Restarts the script if it crashes
# Type=oneshot  # Optional: If the script runs once and exits, uncomment this line
# RemainAfterExit=yes # Optional: If Type=oneshot is used, this may be necessary
# Environment=VARIABLE=value # Optional: Set environment variables

[Install]
WantedBy=multi-user.target
```

* **Explanation of the configuration:**
    * `Description`: A brief description of the service.
    * `After=network-online.target`: Ensures the network is up before the script runs. This is important if your script requires network access.
    * `Wants=network-online.target`: Similar to `After`, but also indicates a dependency.
    * `User`: Specifies the user under which the script should run.  It's generally a good idea to *not* run scripts as root unless absolutely necessary.
    * `WorkingDirectory`: Sets the working directory for the script.
    * `ExecStart`: The full path to the script to execute.
    * `Restart=always`:  This is optional but recommended. It will automatically restart the script if it crashes or is stopped.
    * `Type=oneshot` and `RemainAfterExit=yes`:  These are optional and should be used if your script runs once, performs a task, and then exits.  If your script is a daemon or needs to run continuously, omit these lines.
    * `Environment`: Allows setting environment variables for the script.
    * `WantedBy=multi-user.target`:  This ensures the service starts when the system boots into multi-user mode (normal operating mode).

* **Make the script executable:**

```bash
sudo chmod +x /home/pi/scripts/ubiais.sh
```

* **Enable and start the service:**

```bash
sudo systemctl enable ubiais.service
sudo systemctl start ubiais.service
```

* **Check the status of the service:**

```bash
sudo systemctl status ubiais.service
```

This will show you if the service is running and if there are any errors.  You can also check the logs using `journalctl -u ubiais.service`.

**2. Using rc.local (Less Recommended - Older Method):**

While still functional, `rc.local` is considered a less modern approach compared to systemd. Systemd offers better control and dependency management.  However, if you're working with a very old Raspberry Pi OS version, this might be the only option.

* **Enable rc.local (if not already enabled):**

```bash
sudo systemctl enable rc-local.service
```

* **Edit rc.local:**

```bash
sudo nano /etc/rc.local
```

* **Add the following line *before* the `exit 0` line, adjusting the path and user as needed:**

```bash
sudo -u pi /home/pi/scripts/ubiais.sh &
```

The `&` puts the script in the background, so the boot process can continue.  The `sudo -u pi` runs the script as the 'pi' user.

* **Make the script executable (if you haven't already):**

```bash
sudo chmod +x /home/pi/scripts/ubiais.sh
```

* **Reboot the Raspberry Pi:**

```bash
sudo reboot
```

**Important Considerations:**

* **Paths:** Double-check the paths to your script and the working directory in both methods.  Incorrect paths are a common source of errors.
* **User:** Running scripts as root is generally discouraged.  Use the `pi` user (or another non-root user) whenever possible.
* **Network:** If your script requires network access, ensure it runs *after* the network is up. The systemd example uses `network-online.target` for this purpose.  With `rc.local`, you might need to add a short delay (`sleep 10`) before your script if network access is crucial.
* **Debugging:** If your script isn't running, check the system logs (`/var/log/syslog` or `journalctl -u ubiais.service` for systemd) for errors.
* **Error Handling:**  It's a good practice to include error handling in your script, such as logging errors to a file, to help with debugging.

The systemd method is the strongly recommended approach due to its better integration with the system and its more robust features.  It's worth learning systemd as it's the standard for managing services on most modern Linux distributions.

