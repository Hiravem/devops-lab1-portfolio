# ============================================================
# verify.ps1 - Lab 1 Verification Script (Windows PowerShell)
# ============================================================

$pass = 0
$fail = 0
$total = 0

function Check-Result {
    param(
        [string]$TestName,
        [bool]$Success,
        [string]$Message = ""
    )
    $script:total++
    Write-Host -NoNewline "[$script:total] $TestName ... "
    if ($Success) {
        Write-Host "PASS" -ForegroundColor Green
        $script:pass++
    } else {
        Write-Host "FAIL ($Message)" -ForegroundColor Red
        $script:fail++
    }
}

Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "  VERIFY - Lab 1 DevOps Workflow" -ForegroundColor Cyan
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""

# 1. Git user.name
$userName = git config user.name
Check-Result "Git user.name configured ($userName)" (-not [string]::IsNullOrWhiteSpace($userName)) "user.name is not set"

# 2. Git user.email
$userEmail = git config user.email
Check-Result "Git user.email configured ($userEmail)" (-not [string]::IsNullOrWhiteSpace($userEmail)) "user.email is not set"

# 3. index.html exists
$hasIndex = Test-Path "index.html"
Check-Result "index.html exists" $hasIndex "index.html not found"

# 4. index.html line count
if ($hasIndex) {
    $lines = (Get-Content "index.html").Count
    Check-Result "index.html line count >= 10 ($lines lines)" ($lines -ge 10) "index.html is too short"
} else {
    Check-Result "index.html line count >= 10" $false "index.html not found"
}

# 5. .github/workflows/deploy.yml exists
$hasWorkflow = Test-Path ".github\workflows\deploy.yml"
Check-Result ".github/workflows/deploy.yml exists" $hasWorkflow "Pipeline file not found"

# 6. README.md exists
$hasReadme = Test-Path "README.md"
Check-Result "README.md exists" $hasReadme "README.md not found"

# 7. BAOCAO_LAB1.md exists
$hasReport = Test-Path "BAOCAO_LAB1.md"
Check-Result "BAOCAO_LAB1.md exists" $hasReport "BAOCAO_LAB1.md not found"

# 8. ho_ten_mssv.txt exists
$hasInfo = Test-Path "ho_ten_mssv.txt"
Check-Result "ho_ten_mssv.txt exists" $hasInfo "ho_ten_mssv.txt not found"

Write-Host ""
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host "  RESULTS: $pass/$total PASS, $fail FAIL" -ForegroundColor $(if ($fail -eq 0) { "Green" } else { "Yellow" })
Write-Host "===============================================" -ForegroundColor Cyan

if ($fail -eq 0) {
    Write-Host "ALL CHECKS PASSED! Ready for GitHub." -ForegroundColor Green
} else {
    Write-Host "Please resolve $fail failed checks before submission." -ForegroundColor Yellow
}
