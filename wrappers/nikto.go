package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

// تعريف الألوان
const (
	RED     = "\033[0;31m"
	GREEN   = "\033[0;32m"
	YELLOW  = "\033[0;33m"
	BLUE    = "\033[0;34m"
	MAGENTA = "\033[0;35m"
	CYAN    = "\033[0;36m"
	WHITE   = "\033[1;37m"
	BOLD    = "\033[1m"
	RESET   = "\033[0m"
)

// عرض الشعار
func showBanner() {
	fmt.Printf("%s%s", BOLD, BLUE)
	fmt.Println("  _   _ _ _    _        ")
	fmt.Println(" | \\ | (_) | _| |_ ___  ")
	fmt.Println(" |  \\| | | |/ / __/ _ \\ ")
	fmt.Println(" | |\\  | |   <| || (_) |")
	fmt.Println(" |_| \\_|_|_|\\_\\\\__\\___/ ")
	fmt.Printf("%s%s====================\n", RESET, CYAN)
	fmt.Printf("%sNikto Web Scanner - v3.0.0%s\n", YELLOW, RESET)
	fmt.Printf("%s====================%s\n", CYAN, RESET)
	fmt.Printf("%sGo Wrapper%s\n\n", GREEN, RESET)
}

// عرض المساعدة
func showHelp() {
	fmt.Printf("%sاستخدام:%s %s [خيارات]\n\n", BOLD, RESET, os.Args[0])
	fmt.Printf("%sالخيارات الأساسية:%s\n", BOLD, RESET)
	fmt.Printf("  %s-h, --host%s HOST       الهدف المراد فحصه\n", GREEN, RESET)
	fmt.Printf("  %s-p, --port%s PORT       المنفذ المراد فحصه (الافتراضي: 80)\n", GREEN, RESET)
	fmt.Printf("  %s-o, --output%s FILE     حفظ النتائج في ملف\n", GREEN, RESET)
	fmt.Printf("  %s-F, --Format%s FORMAT   تنسيق الملف (csv, htm, xml, json)\n", GREEN, RESET)
	fmt.Printf("  %s-D, --Display%s OPTION  خيارات العرض (1-4,V,E)\n", GREEN, RESET)
	fmt.Printf("  %s--help%s                عرض هذه المساعدة\n\n", GREEN, RESET)
	fmt.Printf("%sأمثلة:%s\n", BOLD, RESET)
	fmt.Printf("  %s -h example.com\n", os.Args[0])
	fmt.Printf("  %s -h example.com -p 443 -o report.html -F htm\n\n", os.Args[0])
	fmt.Printf("%sملاحظة:%s هذا الغلاف يمرر جميع المعلمات إلى nikto.pl الأساسي.\n", YELLOW, RESET)
}

// التحقق من وجود Perl
func checkPerl() bool {
	cmd := exec.Command("perl", "--version")
	if err := cmd.Run(); err != nil {
		fmt.Printf("%sخطأ: Perl غير مثبت. الرجاء تثبيت Perl لتشغيل Nikto.%s\n", RED, RESET)
		return false
	}
	return true
}

// البحث عن سكربت Nikto الأساسي
func findNiktoScript() (string, bool) {
	// الحصول على المسار الحالي للسكربت
	exePath, err := os.Executable()
	if err != nil {
		fmt.Printf("%sخطأ: لا يمكن تحديد مسار البرنامج الحالي.%s\n", RED, RESET)
		return "", false
	}

	// الحصول على مسار المجلد الأب
	parentDir := filepath.Dir(filepath.Dir(exePath))
	niktoScript := filepath.Join(parentDir, "nikto.pl")

	// التحقق من وجود السكربت
	if _, err := os.Stat(niktoScript); os.IsNotExist(err) {
		fmt.Printf("%sخطأ: لم يتم العثور على سكربت Nikto الأساسي في %s%s\n", RED, niktoScript, RESET)
		return "", false
	}

	return niktoScript, true
}

// تشغيل Nikto
func runNikto(args []string) {
	// التحقق من وجود Perl
	if !checkPerl() {
		os.Exit(1)
	}

	// البحث عن سكربت Nikto
	niktoScript, found := findNiktoScript()
	if !found {
		os.Exit(1)
	}

	// تجهيز الأمر
	cmdArgs := []string{niktoScript}
	if len(args) > 1 {
		cmdArgs = append(cmdArgs, args[1:]...)
	}

	// عرض الأمر الذي سيتم تنفيذه
	fmt.Printf("%sجاري بدء الفحص...%s\n", CYAN, RESET)
	fmt.Printf("%sالأمر:%s perl %s\n\n", YELLOW, RESET, strings.Join(cmdArgs, " "))

	// تنفيذ Nikto
	cmd := exec.Command("perl", cmdArgs...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err := cmd.Run(); err != nil {
		fmt.Printf("\n%sحدث خطأ أثناء تنفيذ Nikto: %v%s\n", RED, err, RESET)
		os.Exit(1)
	}

	fmt.Printf("\n%sاكتمل الفحص.%s\n", GREEN, RESET)
}

func main() {
	// إذا لم يتم تمرير أي معلمات أو تم طلب المساعدة
	if len(os.Args) == 1 || contains(os.Args, "--help") {
		showBanner()
		showHelp()
		os.Exit(0)
	}

	// عرض الشعار
	showBanner()

	// تشغيل Nikto
	runNikto(os.Args)
}

// التحقق من وجود قيمة في مصفوفة
func contains(arr []string, val string) bool {
	for _, item := range arr {
		if item == val {
			return true
		}
	}
	return false
}
