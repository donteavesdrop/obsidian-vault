chcp 65001 > $null

$folder = "Атаки\Веб-атаки"

$oldNames = @(
    "SQLi", "XSS", "CSRF", "SSRF", "XXE", "IDOR",
    "Open Redirect", "Path Traversal", "SSTI", "Command Injection",
    "Code Injection", "LDAP Injection", "NoSQL Injection",
    "ORM Injection", "XPath Injection", "HTML Injection",
    "CSS Injection", "Log Injection", "Mass Assignment",
    "CORS Misconfiguration", "CSP Bypass", "JWT Weak Secret",
    "JWT Algorithm Confusion", "Session Fixation", "Clickjacking",
    "CAPTCHA Bypass", "File Upload Bypass (Content-Type)",
    "File Upload Bypass (Double Extension)", "File Upload Bypass (Magic Bytes)",
    "Небезопасная десериализация", "Zip Slip", "YAML Deserialization",
    "PHP Object Injection", "Python Pickle Injection", "Ruby YAML Deserialization",
    "Node.js Deserialization", "Java Deserialization (RCE)"
)

foreach ($old in $oldNames) {
    $methodFile = Join-Path $folder "Методы защиты от $old.md"
    if (Test-Path $methodFile) {
        $content = Get-Content -Path $methodFile -Raw -Encoding UTF8
        $newContent = $content -replace "\[\[$old\]\]", "[[Атака на $old]]"
        if ($content -ne $newContent) {
            Set-Content -Path $methodFile -Value $newContent -Encoding UTF8 -NoNewline
            Write-Host "Updated: Методы защиты от $old" -ForegroundColor Green
        } else {
            Write-Host "No change: Методы защиты от $old" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Not found: Методы защиты от $old" -ForegroundColor Gray
    }
}

Write-Host "Done!" -ForegroundColor Cyan