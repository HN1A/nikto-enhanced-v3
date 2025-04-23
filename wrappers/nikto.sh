#!/bin/bash
# Nikto Bash Wrapper
# تطوير: Manus AI - 2025

# تعريف الألوان
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
RESET='\033[0m'

# شعار Nikto المحسن بالألوان
function show_banner() {
    echo -e "${BOLD}${BLUE}"
    echo -e "  _   _ _ _    _        "
    echo -e " | \ | (_) | _| |_ ___  "
    echo -e " |  \| | | |/ / __/ _ \ "
    echo -e " | |\  | |   <| || (_) |"
    echo -e " |_| \_|_|_|\_\\__\___/ "
    echo -e "${RESET}${CYAN}====================${RESET}"
    echo -e "${YELLOW}Nikto Web Scanner - v3.0.0${RESET}"
    echo -e "${CYAN}====================${RESET}"
    echo -e "${GREEN}Bash Wrapper${RESET}"
    echo ""
}

# وظيفة المساعدة
function show_help() {
    echo -e "${BOLD}استخدام:${RESET} $0 [خيارات]"
    echo ""
    echo -e "${BOLD}الخيارات الأساسية:${RESET}"
    echo -e "  ${GREEN}-h, --host${RESET} HOST       الهدف المراد فحصه"
    echo -e "  ${GREEN}-p, --port${RESET} PORT       المنفذ المراد فحصه (الافتراضي: 80)"
    echo -e "  ${GREEN}-o, --output${RESET} FILE     حفظ النتائج في ملف"
    echo -e "  ${GREEN}-F, --Format${RESET} FORMAT   تنسيق الملف (csv, htm, xml, json)"
    echo -e "  ${GREEN}-D, --Display${RESET} OPTION  خيارات العرض (1-4,V,E)"
    echo -e "  ${GREEN}--help${RESET}                عرض هذه المساعدة"
    echo ""
    echo -e "${BOLD}أمثلة:${RESET}"
    echo -e "  $0 -h example.com"
    echo -e "  $0 -h example.com -p 443 -o report.html -F htm"
    echo ""
    echo -e "${YELLOW}ملاحظة:${RESET} هذا الغلاف يمرر جميع المعلمات إلى nikto.pl الأساسي."
}

# التحقق من وجود Perl
if ! command -v perl &> /dev/null; then
    echo -e "${RED}خطأ: Perl غير مثبت. الرجاء تثبيت Perl لتشغيل Nikto.${RESET}"
    exit 1
fi

# الحصول على المسار الحالي للسكربت
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
NIKTO_DIR="$(dirname "$SCRIPT_DIR")"
NIKTO_SCRIPT="$NIKTO_DIR/nikto.pl"

# التحقق من وجود سكربت Nikto الأساسي
if [ ! -f "$NIKTO_SCRIPT" ]; then
    echo -e "${RED}خطأ: لم يتم العثور على سكربت Nikto الأساسي في $NIKTO_SCRIPT${RESET}"
    exit 1
fi

# عرض المساعدة إذا لم يتم تمرير أي معلمات
if [ $# -eq 0 ]; then
    show_banner
    show_help
    exit 0
fi

# معالجة المعلمات
if [ "$1" == "--help" ]; then
    show_banner
    show_help
    exit 0
fi

# عرض الشعار
show_banner

# تمرير جميع المعلمات إلى سكربت Nikto الأساسي
echo -e "${CYAN}جاري بدء الفحص...${RESET}"
echo -e "${YELLOW}الأمر:${RESET} perl $NIKTO_SCRIPT $@"
echo ""

# تنفيذ Nikto مع المعلمات المقدمة
perl "$NIKTO_SCRIPT" "$@"

# عرض رسالة الإكمال
echo ""
echo -e "${GREEN}اكتمل الفحص.${RESET}"
