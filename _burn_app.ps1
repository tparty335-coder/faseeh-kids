# سكربت الحرق والاختبار التلقائي على جهاز التابلت (HVA63BT9 أو أي جهاز متصل)
param (
    [string]$Device = ""
)

$apk = "d:\Projects\faseeh_kids\build\app\outputs\flutter-apk\app-release.apk"
if (-not (Test-Path $apk)) {
    $apk = "d:\Projects\faseeh_kids\build\app\outputs\flutter-apk\app-arm64-v8a-release.apk"
}

Write-Host "=== مرحلة الحرق والاختبار: فصيح كيدز ===" -ForegroundColor Cyan
Write-Host "ملف APK المختار: $apk" -ForegroundColor Yellow

$devices = adb devices | Where-Object { $_ -match "\tdevice" }
if (-not $devices) {
    Write-Host "في انتظار توصيل الجهاز عبر USB أو تفعيل تصحيح أخطاء USB (USB Debugging)..." -ForegroundColor Magenta
    adb wait-for-device
}

$devList = adb devices | Where-Object { $_ -match "\tdevice" }
Write-Host "الأجهزة المتصلة:`n$devList" -ForegroundColor Green

$devId = if ($Device) { $Device } else { ($devList[0] -split "\t")[0] }
Write-Host "جاري الحرق والتثبيت على الجهاز: $devId ..." -ForegroundColor Cyan

adb -s $devId install -r $apk
if ($LASTEXITCODE -ne 0) {
    Write-Host "فشل التثبيت الأولي، محاولة التثبيت مع خيارات التجاوز (-d -g)..." -ForegroundColor Yellow
    adb -s $devId install -r -d -g $apk
}

Write-Host "إيقاف أي نسخة سابقة وتشغيل التطبيق..." -ForegroundColor Cyan
adb -s $devId shell am force-stop com.faseeh.kids
Start-Sleep -Seconds 1
adb -s $devId shell am start -n com.faseeh.kids/.MainActivity

Write-Host "انتظار 4 ثوانٍ لظهور شاشة البداية..." -ForegroundColor Cyan
Start-Sleep -Seconds 4

$screenshot = "d:\Projects\faseeh_kids\screen_burn_test.png"
adb -s $devId exec-out screencap -p > $screenshot
Write-Host "تم التقاط لقطة شاشة للتحقق: $screenshot" -ForegroundColor Green
Write-Host "=== اكتمل الحرق بنجاح! التطبيق يعمل الآن على الجهاز ===" -ForegroundColor Green
