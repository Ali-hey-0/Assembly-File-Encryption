# CryptoVault Pro — Assembly File Encryption

## Project Metadata

- **Course:** Assembly Language
- **Instructor:** عادل حساس ایرانی (University Master)
- **Student:** Ali Heydari — aliheydari1381doc@gmail.com — GitHub: Ali-hey-0
- **Year / Semester:** 2025

A compact, single-file assembly project that demonstrates simple file
encryption utilities (XOR, Caesar, Vigenere, ROT13) for learning and
experimentation. This repository contains the assembly source and a
Makefile to build the program on Linux/x86-64 (WSL recommended on Windows).

## Included

- `encryption.asm` — Main x86-64 assembly source (NASM syntax).
- `Makefile` — Build and test targets.
- `test.sh` — Small test harness for basic verification.

## Requirements

- `nasm` (Netwide Assembler)
- `ld` (GNU linker)
- A Linux environment or WSL on Windows to build and run the binary.

## Build

Run from the project directory (use WSL or Linux):

```bash
make clean
make
```

This produces the `encryption` executable.

## Run

Run the program interactively and follow prompts:

```bash
./encryption
```

Use the same algorithm and key to decrypt an encrypted file.

## Tests

Run the included test harness (it will create temporary files):

```bash
make test
```

If `expect` is not installed, `test.sh` provides manual commands.

## Notes

- This project is educational and demonstrates basic ciphers in
  assembly. It is not suitable for production cryptography.

## License

Add a license file of your choice before publishing (e.g., MIT).

---

Clean repository layout: only source, Makefile, and test script remain.

# 🚀 راهنمای کامل: نصب و اجرا در Windows 10 + WSL

## 🎯 مخصوص کاربران VS Code + WSL

---

## 📋 فهرست سریع

1. [تنظیم WSL](https://claude.ai/chat/2baa109c-b514-433f-916e-2d09a7457485#%D8%AA%D9%86%D8%B8%DB%8C%D9%85-wsl)
2. [نصب ابزارها](https://claude.ai/chat/2baa109c-b514-433f-916e-2d09a7457485#%D9%86%D8%B5%D8%A8-%D8%A7%D8%A8%D8%B2%D8%A7%D8%B1%D9%87%D8%A7)
3. [راه اندازی پروژه](https://claude.ai/chat/2baa109c-b514-433f-916e-2d09a7457485#%D8%B1%D8%A7%D9%87%D8%A7%D9%86%D8%AF%D8%A7%D8%B2%DB%8C-%D9%BE%D8%B1%D9%88%DA%98%D9%87)
4. [حل مشکل Path](https://claude.ai/chat/2baa109c-b514-433f-916e-2d09a7457485#%D8%AD%D9%84-%D9%85%D8%B4%DA%A9%D9%84-path)
5. [استفاده در VS Code](https://claude.ai/chat/2baa109c-b514-433f-916e-2d09a7457485#%D8%A7%D8%B3%D8%AA%D9%81%D8%A7%D8%AF%D9%87-%D8%AF%D8%B1-vs-code)

---

## 🔧 تنظیم WSL

### مرحله 1: باز کردن ترمینال WSL در VS Code

```bash
# در VS Code:
# 1. Ctrl + ` (باز کردن Terminal)
# 2. از dropdown بالا، انتخاب کنید: Kali یا Ubuntu
# 3. یا دستور: wsl
```

### مرحله 2: رفتن به پوشه پروژه

#### ⚠️  **نکته مهم** : تبدیل مسیر Windows به WSL

```bash
# ❌ مسیر Windows (کار نمی‌کند):
C:\Users\WebVajhegan\Desktop\vs code\Python\Python\project\assembly

# ✅ مسیر WSL (درست):
/mnt/c/Users/WebVajhegan/Desktop/vs\ code/Python/Python/project/assembly

# 💡 فرمول تبدیل:
# C:\ → /mnt/c/
# D:\ → /mnt/d/
# فاصله‌ها → \ (backslash + space)
```

#### دستورات عملی:

```bash
# رفتن به پوشه پروژه
cd "/mnt/c/Users/WebVajhegan/Desktop/vs code/Python/Python/project/assembly"

# بررسی محتویات
ls -la

# ذخیره مسیر برای راحتی
pwd > ~/project_path.txt
```

---

## 🛠️ نصب ابزارها

### در Kali Linux:

```bash
# به‌روزرسانی
sudo apt-get update

# نصب NASM
sudo apt-get install -y nasm

# نصب Make
sudo apt-get install -y make

# نصب expect (برای تست)
sudo apt-get install -y expect

# بررسی نصب
nasm -v
make -v
```

### در Ubuntu (WSL):

```bash
sudo apt update
sudo apt install -y nasm make expect
```

---

## 📦 راه‌اندازی پروژه

### مرحله 1: ایجاد فایل‌ها

```bash
# در پوشه پروژه
cd "/mnt/c/Users/WebVajhegan/Desktop/vs code/Python/Python/project/assembly"

# ایجاد فایل اصلی
nano encryption.asm
# کد را paste کنید و Ctrl+O, Enter, Ctrl+X

# ایجاد Makefile
nano Makefile
# محتوا را paste کنید
```

### مرحله 2: کامپایل

```bash
# کامپایل با Make
make

# یا به صورت دستی:
nasm -f elf64 encryption.asm -o encryption.o
ld encryption.o -o encryption
```

### مرحله 3: اجرا

```bash
# اجرای برنامه
./encryption
```

---

## 🔍 حل مشکل Path

### روش 1: استفاده از مسیر نسبی (ساده‌ترین)

```bash
# فایل تست در همان پوشه بسازید
echo "Hello World! This is a test." > test.txt

# حالا در برنامه فقط اسم فایل را بنویسید:
./encryption
# انتخاب: 1
# Input: test.txt          ← فقط اسم فایل!
# Output: encrypted.txt    ← فقط اسم فایل!
# Key: mykey
```

### روش 2: مسیر کامل WSL

```bash
# اگر فایل در Desktop است:
/mnt/c/Users/WebVajhegan/Desktop/test.txt

# اگر فاصله در نام پوشه است:
/mnt/c/Users/WebVajhegan/Desktop/my\ folder/test.txt

# یا با گیومه:
"/mnt/c/Users/WebVajhegan/Desktop/my folder/test.txt"
```

### روش 3: استفاده از pwd

```bash
# نمایش مسیر فعلی
pwd
# خروجی مثال: /mnt/c/Users/WebVajhegan/Desktop/vs code/Python/Python/project/assembly

# حالا از این مسیر استفاده کنید:
# $(pwd)/test.txt
```

### 💡 نکات مهم Path:

```bash
# ✅ درست:
./test.txt
test.txt
/mnt/c/Users/YourName/file.txt

# ❌ اشتباه (Windows format):
C:\Users\YourName\file.txt
.\test.txt (در WSL کار نمی‌کند)
```

---

## 🎨 استفاده در VS Code

### ترفند 1: Terminal یکپارچه

```json
// در VS Code settings (Ctrl+,)
// جستجو: terminal.integrated.defaultProfile.windows

{
  "terminal.integrated.defaultProfile.windows": "Kali",
  "terminal.integrated.profiles.windows": {
    "Kali": {
      "path": "C:\\Windows\\System32\\wsl.exe",
      "args": ["-d", "kali-linux"]
    }
  }
}
```

### ترفند 2: Tasks برای کامپایل سریع

ایجاد فایل `.vscode/tasks.json`:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build Assembly",
      "type": "shell",
      "command": "make",
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "presentation": {
        "echo": true,
        "reveal": "always",
        "panel": "new"
      }
    },
    {
      "label": "Run Program",
      "type": "shell",
      "command": "./encryption",
      "dependsOn": ["Build Assembly"],
      "group": "test"
    }
  ]
}
```

حالا می‌تونید با `Ctrl+Shift+B` کامپایل کنید!

### ترفند 3: باز کردن پوشه در WSL

```bash
# در Windows Explorer:
# آدرس بار: \\wsl$\kali-linux\home\youruser

# یا در VS Code:
# File → Open Folder
# انتخاب از: \\wsl$\kali-linux\...
```

---

## 🎮 مثال کامل استفاده

```bash
# 1. رفتن به پوشه
cd "/mnt/c/Users/WebVajhegan/Desktop/vs code/Python/Python/project/assembly"

# 2. ساخت فایل تست
echo "This is my secret message!" > message.txt
echo "Another file to test" > file2.txt

# 3. کامپایل
make

# 4. اجرای برنامه
./encryption

# در منو:
# ╔════════════════ MAIN MENU ════════════════╗
# ║  [1] 🔒 Encrypt File                  ║
# ║  [2] 🔓 Decrypt File                  ║
# ║  [3] 🔄 Batch Encrypt (Multiple)     ║
# ║  [4] 🎲 Generate Random Key           ║
# ║  [5] 🛠️  Algorithm Settings           ║
# ║  [6] 📊 View Statistics               ║
# ║  [7] ℹ️  Help & Documentation         ║
# ║  [8] 📖 About This Program            ║
# ║  [9] 🚪 Exit                          ║
# ╚═══════════════════════════════════════════╝

# انتخاب کنید: 7  (برای راهنما)
# یا: 1 (برای رمزگذاری)

# برای رمزگذاری:
Your choice: 1

[⏳] Processing encryption...

📁 Input file path: message.txt
📝 Output file path: encrypted.txt
🔑 Encryption key: MySecretPassword

[✅] Operation completed successfully!
```

---

## 🆕 ویژگی‌های جدید برنامه

### 1️⃣ چندین الگوریتم

```
[5] Algorithm Settings
  [1] XOR Cipher (Fast)          ← سریع و قدرتمند
  [2] Caesar Cipher (Classic)    ← کلاسیک و ساده
  [3] Vigenere Cipher (Strong)   ← قوی‌تر
  [4] ROT13 (Quick)              ← سریع برای متن
```

### 2️⃣ رمزگذاری دسته‌ای

```
[3] Batch Encrypt
# می‌تونید چندین فایل را پشت سر هم رمز کنید
```

### 3️⃣ تولید کلید تصادفی

```
[4] Generate Random Key
# خروجی: jK9mPq2Xz5Wn8Rt4
```

### 4️⃣ آمار و گزارش

```
[6] View Statistics
# نمایش تعداد فایل‌های رمزشده و حجم کل
```

### 5️⃣ راهنمای جامع

```
[7] Help
# راهنمای کامل با نکات Path در WSL
```

---

## 🐛 حل مشکلات رایج

### مشکل 1: Cannot open input file

```bash
# علت: مسیر اشتباه است
# راه حل:

# بررسی فایل وجود دارد؟
ls -la message.txt

# اگر وجود دارد:
./encryption
# و فقط اسم فایل را بنویسید: message.txt

# یا مسیر کامل:
/mnt/c/Users/YourName/Desktop/message.txt
```

### مشکل 2: Permission denied

```bash
chmod +x encryption
chmod +x test.sh
```

### مشکل 3: Makefile errors

```bash
# کامپایل دستی:
nasm -f elf64 encryption.asm -o encryption.o
ld encryption.o -o encryption
```

### مشکل 4: فاصله در نام پوشه

```bash
# ❌ اشتباه:
cd /mnt/c/Users/My Name/Desktop

# ✅ درست:
cd /mnt/c/Users/My\ Name/Desktop
# یا
cd "/mnt/c/Users/My Name/Desktop"
```

---

## 📊 بررسی عملکرد

```bash
# اندازه فایل اجرایی
ls -lh encryption

# تست سریع
echo "Quick test" > test.txt
./encryption
# 1 → test.txt → out.txt → key123

# مقایسه
./encryption
# 2 → out.txt → decrypted.txt → key123

diff test.txt decrypted.txt
# خالی = موفق!
```

---

## 🎯 Workflow توصیه شده

```bash
# 1. هر روز شروع کار:
cd ~/project  # یا مسیر اصلی

# 2. ویرایش کد:
code encryption.asm  # در VS Code

# 3. کامپایل:
make clean && make

# 4. تست:
./encryption

# 5. Commit (اگر از Git استفاده می‌کنید):
git add .
git commit -m "Added new features"
```

---

## 💡 نکات پیشرفته

### ایجاد Alias برای راحتی

```bash
# اضافه کردن به ~/.bashrc
echo 'alias myproject="cd /mnt/c/Users/WebVajhegan/Desktop/vs\ code/Python/Python/project/assembly"' >> ~/.bashrc
source ~/.bashrc

# حالا فقط بنویسید:
myproject
```

### اسکریپت سریع برای تست

```bash
# ایجاد test_quick.sh
cat > test_quick.sh << 'EOF'
#!/bin/bash
echo "Test message $(date)" > test_$(date +%s).txt
echo "File created: test_$(date +%s).txt"
EOF

chmod +x test_quick.sh
```

---

## 🎓 برای ارائه

### دستورات نمایشی:

```bash
# 1. نمایش کد
cat encryption.asm | head -50

# 2. نمایش کامپایل
make clean
make

# 3. تست زنده
./encryption

# 4. نمایش آمار
# در برنامه: [6]

# 5. نمایش راهنما
# در برنامه: [7]
```

---

## 📞 کمک بیشتر

### لاگ‌های دیباگ:

```bash
# اجرا با لاگ
./encryption 2>&1 | tee debug.log

# مشاهده سیستم
uname -a
nasm -v
ld -v
```

### تست مسیر:

```bash
# بررسی مسیر فعلی
pwd

# لیست فایل‌ها
ls -la

# تست خواندن فایل
cat test.txt
```

---

## ✅ چک‌لیست نهایی

قبل از ارائه:

* [ ] WSL به درستی کار می‌کند
* [ ] NASM نصب شده (`nasm -v`)
* [ ] پروژه کامپایل می‌شود (`make`)
* [ ] برنامه اجرا می‌شود (`./encryption`)
* [ ] رمزگذاری کار می‌کند (تست با فایل)
* [ ] رمزگشایی کار می‌کند
* [ ] تمام منوها کار می‌کنند
* [ ] مستندات آماده است

---

## Author

- **Author**: Ali Heydari
- **Email**: aliheydari1381doc@gmail.com
- **GitHub**: [Ali-hey-0](https://github.com/Ali-hey-0)
