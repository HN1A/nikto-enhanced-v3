#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Nikto Python Wrapper
# تطوير: Manus AI - 2025

import os
import sys
import argparse
import subprocess
import platform
from pathlib import Path

# تعريف الألوان
class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[0;33m'
    BLUE = '\033[0;34m'
    MAGENTA = '\033[0;35m'
    CYAN = '\033[0;36m'
    WHITE = '\033[1;37m'
    BOLD = '\033[1m'
    RESET = '\033[0m'

# شعار Nikto المحسن بالألوان
def show_banner():
    print(f"{Colors.BOLD}{Colors.BLUE}")
    print("  _   _ _ _    _        ")
    print(" | \\ | (_) | _| |_ ___  ")
    print(" |  \\| | | |/ / __/ _ \\ ")
    print(" | |\\  | |   <| || (_) |")
    print(" |_| \\_|_|_|\\_\\\\__\\___/ ")
    print(f"{Colors.RESET}{Colors.CYAN}===================={Colors.RESET}")
    print(f"{Colors.YELLOW}Nikto Web Scanner - v3.0.0{Colors.RESET}")
    print(f"{Colors.CYAN}===================={Colors.RESET}")
    print(f"{Colors.GREEN}Python Wrapper{Colors.RESET}")
    print("")

# وظيفة المساعدة
def show_help():
    print(f"{Colors.BOLD}استخدام:{Colors.RESET} python3 {sys.argv[0]} [خيارات]")
    print("")
    print(f"{Colors.BOLD}الخيارات الأساسية:{Colors.RESET}")
    print(f"  {Colors.GREEN}-h, --host{Colors.RESET} HOST       الهدف المراد فحصه")
    print(f"  {Colors.GREEN}-p, --port{Colors.RESET} PORT       المنفذ المراد فحصه (الافتراضي: 80)")
    print(f"  {Colors.GREEN}-o, --output{Colors.RESET} FILE     حفظ النتائج في ملف")
    print(f"  {Colors.GREEN}-F, --Format{Colors.RESET} FORMAT   تنسيق الملف (csv, htm, xml, json)")
    print(f"  {Colors.GREEN}-D, --Display{Colors.RESET} OPTION  خيارات العرض (1-4,V,E)")
    print(f"  {Colors.GREEN}--help{Colors.RESET}                عرض هذه المساعدة")
    print("")
    print(f"{Colors.BOLD}أمثلة:{Colors.RESET}")
    print(f"  python3 {sys.argv[0]} -h example.com")
    print(f"  python3 {sys.argv[0]} -h example.com -p 443 -o report.html -F htm")
    print("")
    print(f"{Colors.YELLOW}ملاحظة:{Colors.RESET} هذا الغلاف يمرر جميع المعلمات إلى nikto.pl الأساسي.")

def find_nikto_script():
    # الحصول على المسار الحالي للسكربت
    script_path = Path(os.path.abspath(__file__))
    nikto_dir = script_path.parent.parent
    nikto_script = nikto_dir / "nikto.pl"
    
    if not nikto_script.exists():
        print(f"{Colors.RED}خطأ: لم يتم العثور على سكربت Nikto الأساسي في {nikto_script}{Colors.RESET}")
        sys.exit(1)
    
    return str(nikto_script)

def check_perl():
    try:
        subprocess.run(["perl", "--version"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
    except (subprocess.SubprocessError, FileNotFoundError):
        print(f"{Colors.RED}خطأ: Perl غير مثبت. الرجاء تثبيت Perl لتشغيل Nikto.{Colors.RESET}")
        sys.exit(1)

def run_nikto(args):
    nikto_script = find_nikto_script()
    check_perl()
    
    # تحويل المعلمات من Python إلى صيغة Nikto
    nikto_args = []
    for arg in args:
        if arg != sys.argv[0]:  # تجاهل اسم السكربت نفسه
            nikto_args.append(arg)
    
    # عرض الشعار
    show_banner()
    
    # عرض الأمر الذي سيتم تنفيذه
    cmd = ["perl", nikto_script] + nikto_args
    print(f"{Colors.CYAN}جاري بدء الفحص...{Colors.RESET}")
    print(f"{Colors.YELLOW}الأمر:{Colors.RESET} {' '.join(cmd)}")
    print("")
    
    # تنفيذ Nikto
    try:
        process = subprocess.run(cmd, check=True)
        print("")
        print(f"{Colors.GREEN}اكتمل الفحص.{Colors.RESET}")
    except subprocess.CalledProcessError as e:
        print(f"{Colors.RED}حدث خطأ أثناء تنفيذ Nikto: {e}{Colors.RESET}")
        sys.exit(e.returncode)

def main():
    # إذا لم يتم تمرير أي معلمات أو تم طلب المساعدة
    if len(sys.argv) == 1 or "--help" in sys.argv:
        show_banner()
        show_help()
        sys.exit(0)
    
    # تمرير جميع المعلمات إلى Nikto
    run_nikto(sys.argv)

if __name__ == "__main__":
    main()
