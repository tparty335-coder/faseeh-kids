#!/usr/bin/env pwsh
<#
.SYNOPSIS
  Smart Asset Diet — فصيح الأطفال
  يُميّز بين PNG شفاف (alpha → lossless WebP) وغير شفاف (non-alpha → lossy WebP q=85)
  ويُميّز بين MP3 كلام/نطق (→ 64kbps mono) وموسيقى/نشيد (→ 128kbps stereo)

.PREREQUISITES
  - cwebp مثبّت (من libwebp): https://developers.google.com/speed/webp/download
  - ffmpeg مثبّت في PATH
  - تشغيل من جذر مشروع faseeh_kids

.USAGE
  .\tool\smart_asset_diet.ps1 [-DryRun] [-Confirm]
  DryRun = أطبع ما سيُفعل بدون تنفيذ فعلي
  Confirm = اسأل قبل كل تحويل (للاختبار التدريجي)
#>

param(
  [switch]$DryRun,
  [switch]$Confirm
)

$ErrorActionPreference = "Stop"
$ProjectRoot = $PSScriptRoot -replace '\\tool$', ''
$ImagesDir   = "$ProjectRoot\assets\images"
$AudioDir    = "$ProjectRoot\assets\audio"
$BackupDir   = "$ProjectRoot\scratch\asset_diet_backup_$(Get-Date -Format 'yyyyMMdd_HHmm')"

# ── دوال مساعدة ──────────────────────────────────────────────────────────────

function Has-Alpha($path) {
  $bytes = [System.IO.File]::ReadAllBytes($path)
  if ($bytes.Length -le 25) { return $false }
  $colorType = $bytes[25]
  return ($colorType -eq 4 -or $colorType -eq 6)
}

function Is-Music($filename) {
  # ملفات النشيد والموسيقى — تحتاج جودة أعلى
  $musicPatterns = @('nasheed', 'song', 'music', 'anthem', 'melody', 'tune')
  foreach ($p in $musicPatterns) {
    if ($filename -ilike "*$p*") { return $true }
  }
  return $false
}

function Format-MB($bytes) { return "$([math]::Round($bytes/1MB, 2)) MB" }

# ── تحقق من الأدوات ──────────────────────────────────────────────────────────
Write-Host "`n🔍 التحقق من الأدوات المطلوبة..." -ForegroundColor Cyan

$cwebpOk  = $null -ne (Get-Command cwebp  -ErrorAction SilentlyContinue)
$ffmpegOk = $null -ne (Get-Command ffmpeg -ErrorAction SilentlyContinue)

if (-not $cwebpOk)  { Write-Warning "cwebp غير موجود — تحويل PNG → WebP لن يعمل. ثبّت libwebp" }
if (-not $ffmpegOk) { Write-Warning "ffmpeg غير موجود — ضغط MP3 لن يعمل. ثبّت ffmpeg" }

# ── إحصائيات قبل ─────────────────────────────────────────────────────────────
$pngFiles  = Get-ChildItem $ImagesDir -Recurse -Filter "*.png"
$mp3Files  = Get-ChildItem $AudioDir  -Recurse -Filter "*.mp3"
$pngBefore = ($pngFiles | Measure-Object Length -Sum).Sum
$mp3Before = ($mp3Files | Measure-Object Length -Sum).Sum

Write-Host "`n📊 قبل الضغط:" -ForegroundColor Yellow
Write-Host "  PNG: $($pngFiles.Count) ملف = $(Format-MB $pngBefore)"
Write-Host "  MP3: $($mp3Files.Count) ملف = $(Format-MB $mp3Before)"

if ($DryRun) {
  Write-Host "`n[DRY RUN] الوضع الاستعراضي — لن يُحوَّل شيء" -ForegroundColor Magenta
}

# ── إنشاء مجلد النسخ الاحتياطية ─────────────────────────────────────────────
if (-not $DryRun) {
  New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null
  Write-Host "`n💾 النسخ الاحتياطية في: $BackupDir" -ForegroundColor Green
}

$pngConverted = 0; $pngSaved = 0
$mp3Compressed = 0; $mp3Saved = 0

# ═══════════════════════════════════════════════════════════════════════════════
# 1. تحويل PNG → WebP
# ═══════════════════════════════════════════════════════════════════════════════
Write-Host "`n🖼️  تحويل الصور PNG → WebP..." -ForegroundColor Cyan

foreach ($png in $pngFiles) {
  $hasAlpha  = Has-Alpha $png.FullName
  $webpPath  = $png.FullName -replace '\.png$', '.webp'
  $modeLabel = if ($hasAlpha) { "lossless" } else { "lossy q=85" }

  Write-Host "  $($png.Name) [$modeLabel]" -NoNewline

  if ($cwebpOk -and -not $DryRun) {
    if ($Confirm) {
      $ans = Read-Host " — حوّل؟ (y/n)"
      if ($ans -ne 'y') { Write-Host " تخطّي"; continue }
    }

    # نسخة احتياطية
    Copy-Item $png.FullName "$BackupDir\$($png.Name)"

    # تحويل
    if ($hasAlpha) {
      cwebp -lossless -q 100 $png.FullName -o $webpPath 2>$null
    } else {
      cwebp -q 85 $png.FullName -o $webpPath 2>$null
    }

    if (Test-Path $webpPath) {
      $saved = $png.Length - (Get-Item $webpPath).Length
      $pngSaved += $saved
      $pngConverted++
      # احذف PNG الأصلي بعد التحقق من WebP
      Remove-Item $png.FullName
      Write-Host " → وفّر $(Format-MB $saved)" -ForegroundColor Green
    } else {
      Write-Host " ✗ فشل التحويل" -ForegroundColor Red
    }
  } else {
    Write-Host " [DRY RUN]"
  }
}

# ═══════════════════════════════════════════════════════════════════════════════
# 2. ضغط MP3
# ═══════════════════════════════════════════════════════════════════════════════
Write-Host "`n🔊 ضغط ملفات الصوت MP3..." -ForegroundColor Cyan

foreach ($mp3 in $mp3Files) {
  $isMusic   = Is-Music $mp3.Name
  $bitrate   = if ($isMusic) { "128k" } else { "64k" }
  $channels  = if ($isMusic) { 2 } else { 1 }
  $modeLabel = if ($isMusic) { "موسيقى 128k stereo" } else { "كلام 64k mono" }

  # لا تعيد ضغط ملف صغير أصلاً (< 15 KB = جملة قصيرة)
  if ($mp3.Length -lt 15360) {
    Write-Host "  $($mp3.Name) → تخطّي (صغير جداً)" -ForegroundColor DarkGray
    continue
  }

  Write-Host "  $($mp3.Name) [$modeLabel]" -NoNewline

  if ($ffmpegOk -and -not $DryRun) {
    $tmpPath = $mp3.FullName + ".tmp.mp3"

    ffmpeg -y -i $mp3.FullName -b:a $bitrate -ac $channels -ar 44100 $tmpPath 2>$null

    if (Test-Path $tmpPath) {
      $tmpSize = (Get-Item $tmpPath).Length
      if ($tmpSize -lt $mp3.Length) {
        $saved = $mp3.Length - $tmpSize
        Copy-Item $mp3.FullName "$BackupDir\$($mp3.Name)" -ErrorAction SilentlyContinue
        Move-Item $tmpPath $mp3.FullName -Force
        $mp3Saved += $saved
        $mp3Compressed++
        Write-Host " → وفّر $(Format-MB $saved)" -ForegroundColor Green
      } else {
        Remove-Item $tmpPath -ErrorAction SilentlyContinue
        Write-Host " → لا توفير (تخطّي)" -ForegroundColor DarkGray
      }
    } else {
      Write-Host " ✗ فشل الضغط" -ForegroundColor Red
    }
  } else {
    Write-Host " [DRY RUN]"
  }
}

# ═══════════════════════════════════════════════════════════════════════════════
# 3. ملخص
# ═══════════════════════════════════════════════════════════════════════════════
Write-Host "`n" + "═"*60 -ForegroundColor Cyan
Write-Host "📊 ملخص حملة الضغط:" -ForegroundColor Yellow
Write-Host "  صور محوّلة : $pngConverted / $($pngFiles.Count) — وفّر $(Format-MB $pngSaved)"
Write-Host "  أصوات مضغوطة: $mp3Compressed / $($mp3Files.Count) — وفّر $(Format-MB $mp3Saved)"
Write-Host "  إجمالي التوفير: $(Format-MB ($pngSaved + $mp3Saved))"
Write-Host "`n✅ تذكّر: حدّث pubspec.yaml لاستخدام .webp بدلاً من .png في الأماكن المرجعية" -ForegroundColor Yellow
Write-Host "   أو استخدم AssetImage التي تقبل WebP تلقائياً في Flutter" -ForegroundColor DarkGray
