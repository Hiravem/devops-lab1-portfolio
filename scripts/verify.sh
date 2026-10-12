#!/bin/bash
# ============================================================
# verify.sh — Script kiểm tra kết quả Lab 1
# ============================================================
PASS=0; FAIL=0; TOTAL=0
check() {
    TOTAL=$((TOTAL + 1))
    echo -n "[$TOTAL] $1 ... "
    if [ "$2" = "OK" ]; then echo "✅ PASS"; PASS=$((PASS + 1))
    else echo "❌ $2"; FAIL=$((FAIL + 1)); fi
}

echo "==============================================="
echo "  VERIFY — Lab 1 DevOps Workflow"
echo "==============================================="
echo ""

# Git config
git config user.name &>/dev/null && check "Git user.name" "OK" || check "Git user.name" "Not configured"
git config user.email &>/dev/null && check "Git user.email" "OK" || check "Git user.email" "Not configured"

# index.html
[ -f "index.html" ] && check "index.html exists" "OK" || check "index.html exists" "File not found"
[ -f "index.html" ] && [ "$(wc -l < index.html)" -ge 10 ] && check "index.html ≥ 10 lines" "OK" || check "index.html ≥ 10 lines" "File too short"

# GitHub Actions workflow
[ -f ".github/workflows/deploy.yml" ] && check ".github/workflows/deploy.yml exists" "OK" || check ".github/workflows/deploy.yml exists" "Pipeline file not found"

# Documentation
[ -f "README.md" ] && check "README.md exists" "OK" || check "README.md exists" "README not found"
[ -f "BAOCAO_LAB1.md" ] && check "BAOCAO_LAB1.md exists" "OK" || check "BAOCAO_LAB1.md exists" "Report not found"
[ -f "ho_ten_mssv.txt" ] && check "ho_ten_mssv.txt exists" "OK" || check "ho_ten_mssv.txt exists" "Student info not found"

echo ""
echo "==============================================="
echo "  RESULTS: $PASS/$TOTAL PASS, $FAIL FAIL"
echo "==============================================="
[ "$FAIL" -eq 0 ] && echo "🎉 All checks PASS! Ready to push to GitHub." || echo "⚠️  $FAIL issue(s) to fix"
