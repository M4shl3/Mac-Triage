# 🚀 Mac Triage Tool 🖥️🔍  

## 🔍 Overview  

The **Mac Triage Tool** is a **forensic collection script** designed for **digital forensics and security investigations**.  
Inspired by how KAPE works, it efficiently extracts critical macOS system artifacts **while preserving the original file system structure**, making forensic analysis and parsing seamless.  

This tool collects **FSEvents, Spotlight, Unified Logs, user artifacts, system logs and many more**, ensuring comprehensive data acquisition for forensic investigators and security professionals.  

---

## ✨ Features  

✔️ **Forensic Data Collection** – Extracts key macOS artifacts, including:  
      - **FSEvents, Unified Logs, Spotlight, KnowledgeC and .DS_Store**  
      - **User artifacts** (.bash_history, .zsh_history, SSH keys, documents, desktops)  
      - **System logs and preferences**  
      - **Library artifacts** (Application Support, LaunchDaemons, Preferences)  

✔️ **Maintains macOS File Structure** – Ensures compatibility with forensic analysis tools 📂  
✔️ **Automated Compression** – Packs collected artifacts into a `.zip` file for easy transfer 🗜️  
✔️ **Full File System Listing** – Generates a comprehensive inventory of collected files  
✔️ **Efficient & Modular Design** – Easily customizable for new forensic targets  
✔️ **Automated Cleanup** – Removes temporary files after data collection 🧹  

---

## 📌 Requirements  

Before running the tool, ensure you have the necessary dependencies installed:  

```bash
pip install -r requirements.txt
```

---

## ⚡ Installation & Usage

Clone the repository and run the script:  

```bash
git clone https://github.com/a1l4m/mac-triage-tool.git
cd mac-triage-tool
chmod +x mac-triage.sh
sudo bash Mac_Triage.sh

<< Add Image Here >>
```

🔹 **Root permissions are required** for full forensic collection.  
🔹 The script will collect system artifacts, store them in a structured directory, and compress everything into a `.zip` archive.  

---

## 📂 Output Structure  

After execution, the output structure will be something like this:  

```
📁 [Hostname_YMD_HMS].zip/
│── 📁 [Hostname-Triage]/
│   │── 📁 Private/
│   │    ├── 📁 etc/
│   │    ├── 📁 var/
│   │    │    ├── 📁 db/
│   │    │    ├── 📁 log/
│   │    │    ├── 📁 root/
│   │    │    ├── 📁 tmp/
│   │── 📁 Users/
│   │    ├── 📁 User1/
│   │    │    ├── 📄 .bash_history
│   │    │    ├── 📄 .zsh_history
│   │    │    ├── 📁 .ssh
│   │    │    ├── 📄 .sh_history
│   │    │    ├── 📄 .DS_Store
│   │    │    ├── 📁 .zsh_sessions/
│   │    │    ├── 📁 .bash_sessions/
│   │    │    ├── 📁 Documents/
│   │    │    ├── 📁 Desktop/
│   │    │    ├── 📁 Library/
│   │    ├── 📁 User2/
│   │── 📁 UnifiedLogs/
│   │── 📁 Spotlight/
│   │── 📁 FSEvents/
│   │── 📁 Library/
│   │    ├── 📁 Application Support/
│   │    ├── 📁 LaunchDaemons/
│   │    ├── 📁 Logs/
│   │    ├── 📁 Preferences/
│   │── 📁 System/
│   │    ├── 📁 Library/
│   │    ├──────  📄 CoreServices/SystemVersion.plist
│   ├── 📄 Full_File_Listing.txt
│   ├── 📄 [Hostname_YMD_HMS]_Processing_Details.txt
│   ├── 📄 [Hostname_YMD_HMS]_File_Hashes.txt
```

---

## 📝 Logging  

All actions and errors are logged in:  

```
Processing_Details.txt
```

---

## 🛠️ Authors  

- **[a1l4m](https://linkedin/in/a1l4m)** - Khaled Allam  
  - 🌐 [Site](https://a1l4m.github.io)  
  - 📧 [Email](mailto:khal3d.a1lam@gmail.com)  

- **[M4shl3](https://www.linkedin.com/in/m4shl3)** - Ahmed Mahmoud  
  - 🔗 [blog](https://hackmd.io/@M4shl3) 
  - 📧 [Email](ahmedelsalkh627@gmail.com)

---

## 🤝 Contributing  

Contributions are welcome!  

1. **Fork** the repository  
2. **Create** a new branch (`git checkout -b feature-new-feature`)  
3. **Commit** your changes (`git commit -m "Add new feature"`)  
4. **Push** to the branch (`git push origin feature-new-feature`)  
5. **Open a Pull Request** 🚀  

---

## ⚠️ Disclaimer  

As we don't like to reinvent the wheel, some parts of our code and structure were taken from the open-source project by **Brimor Labs** named **Live Response Collection**. We would like to give them credit for their contribution to the forensic community.
