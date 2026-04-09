$date = Get-Date -Format 'yyyy-MM-dd в HH:mm'
$vulns = @(
    "CSRF",
    "IDOR",
    "LFI_RFI",
    "SQLi",
    "SSRF",
    "XSS",
    "XXE",
    "Небезопасная десериализация",
    "Path Traversal",
    "Open Redirect",
    "Clickjacking",
    "SSTI",
    "HTTP Request Smuggling",
    "NoSQL Injection",
    "LDAP Injection",
    "CORS Misconfiguration",
    "WebSocket vulns",
    "Command Injection",
    "Host Header Injection",
    "Session Fixation",
    "Mass Assignment",
    "Log Injection",
    "Header Injection (CRLF)",
    "Blind XSS",
    "DOM-based XSS",
    "Reflected XSS",
    "Stored XSS",
    "Template Injection",
    "HTTP Parameter Pollution",
    "Cache Poisoning",
    "Race Condition",
    "GraphQL Introspection",
    "GraphQL Injection",
    "ORM Injection",
    "XPath Injection",
    "Code Injection",
    "CSS Injection",
    "HTML Injection",
    "JavaScript Injection",
    "WebSocket Hijacking",
    "PostMessage Vulnerability",
    "CSP Bypass",
    "SameSite Bypass",
    "Session Puzzling",
    "Cookie Tossing",
    "Parameter Tampering",
    "Business Logic Flaw",
    "Rate Limit Bypass",
    "CAPTCHA Bypass",
    "2FA Bypass",
    "JWT Weak Secret",
    "JWT Algorithm Confusion",
    "OAuth CSRF",
    "OAuth Redirect URI Manipulation",
    "SAML Replay Attack",
    "SAML XML Signature Wrapping",
    "LDAP Blind Injection",
    "NoSQL Blind Injection",
    "GraphQL Batching Attack",
    "GraphQL Resource Exhaustion",
    "Zip Slip",
    "File Upload Bypass (Double Extension)",
    "File Upload Bypass (Content-Type)",
    "File Upload Bypass (Magic Bytes)",
    "SVG XSS",
    "Markdown XSS",
    "SSI Injection",
    "ESI Injection",
    "XSLT Injection",
    "XQuery Injection",
    "JSON Injection",
    "YAML Deserialization",
    "Java Deserialization (RCE)",
    "PHP Object Injection",
    "Python Pickle Injection",
    "Ruby YAML Deserialization",
    "Node.js Deserialization"
)

foreach ($vuln in $vulns) {
    # Файл уязвимости
    $vulnFile = "$vuln.md"
    $contentVuln = "$vuln`n$date`nТеги:[[Веб-уязвимости]]`n----"
    [System.IO.File]::WriteAllText($vulnFile, $contentVuln, [System.Text.Encoding]::UTF8)

    # Файл методов защиты
    if ($vuln -eq "роп") {
        $methodFileName = "Методы защиты от Небезопасная дериализация.md"
    } else {
        $methodFileName = "Методы защиты от $vuln.md"
    }
    $methodContent = "$date`nТеги:[[$vuln]]`n`n----"
    [System.IO.File]::WriteAllText($methodFileName, $methodContent, [System.Text.Encoding]::UTF8)
}

Write-Host "Готово. Создано $($vulns.Count * 2) файлов." -ForegroundColor Green