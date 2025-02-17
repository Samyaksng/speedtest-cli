---

```markdown
# SpeedTest Bash Script 🚀

Welcome to the **SpeedTest Bash Script**! This script leverages the power of [speedtest-cli](https://github.com/sivel/speedtest-cli) and [jq](https://stedolan.github.io/jq/) to run a network speed test and display the results in a beautifully organized format.

> **Note:**  
> Ensure you have both `speedtest-cli` and `jq` installed on your system before using this script.

## 📋 Overview

This script:
- **Checks Dependencies:** Verifies if `speedtest-cli` and `jq` are installed.
- **Runs a Speed Test:** Executes a network speed test and collects results in JSON format.
- **Parses Results:** Extracts important details like timestamp, ping, download/upload speeds, server info, and client IP.
- **Displays Output:** Presents the results in an easy-to-read, organized format.

## 🔧 Prerequisites

Before running the script, make sure you have the following installed:

- **speedtest-cli:**  
  Install via pip:
  ```bash
  pip install speedtest-cli
  ```
- **jq:**  
  Install on Debian/Ubuntu:
  ```bash
  sudo apt-get install jq
  ```

## 🏃‍♂️ Usage

1. **Clone or download the repository.**

2. **Make the script executable:**
   ```bash
   chmod +x speedtest2.sh
   ```

3. **Run the script:**
   ```bash
   ./speedtest2.sh
   ```

## 📊 What It Does

- **Dependency Check:**  
  The script verifies if `speedtest-cli` and `jq` are available. If not, it prompts you to install them.

- **Speed Test Execution:**  
  It runs `speedtest-cli` with the `--json` flag to capture the test results.

- **Result Parsing:**  
  Using `jq`, it extracts:
  - `timestamp`
  - `ping`
  - `download` (converted to Mbps)
  - `upload` (converted to Mbps)
  - `server` details (name, country, sponsor)
  - `client` IP

- **Output Display:**  
  All the results are then neatly printed in a tabulated format.

## 📝 To-Do List

- [ ] **Improve Error Handling:**  
  Enhance error checking (e.g., handle no internet connection or invalid JSON).

- [ ] **Output to File Option:**  
  Add functionality to save the test results to a file for logging purposes.

- [ ] **Extended Metrics:**  
  Consider adding more metrics like jitter and packet loss.

- [ ] **User-Friendly Help Message:**  
  Include a detailed help/usage guide when running the script with a `--help` flag.

- [ ] **Graphical Interface:**  
  Develop a simple GUI or web interface to display real-time results.

- [ ] **Multi-Server Testing:**  
  Allow users to choose between different test servers.


## 🤝 Contributing

Contributions are welcome! If you have ideas for improvements or find any issues, feel free to open an issue or submit a pull request.

---

Happy Testing! 🚀⚡
```
