# jekyll-newpost.ps1

# 获取当前日期（格式：YYYY-MM-DD）
$date = Get-Date -Format "yyyy-MM-dd"

# 输入文章标题
$title = Read-Host "输入文章标题（支持中文/英文）"

# 处理标题格式（小写/去符号/空格转短横线）
$cleanTitle = $title.ToLower() -replace '[^\p{L}\p{Nd}]', ' ' -replace '\s+','-' -replace '-+$'

# 组合完整文件名
$filename = "${date}-${cleanTitle}.md"
$fullPath = Join-Path "_posts" $filename

# 自动生成 Front Matter 模板
$frontMatter = @"
---
layout: post
title: "$title"
date: $($date)T00:00:00+08:00
categories: []
tags: []
---
"@

# 创建 _posts 目录（如果不存在）
if (-not (Test-Path "_posts")) {
    New-Item -ItemType Directory "_posts" | Out-Null
}

# 创建文件并写入内容
$frontMatter | Out-File -Encoding utf8 $fullPath

# 输出结果
Write-Host "✅ 文件已生成：" -NoNewline -ForegroundColor Green
Write-Host $fullPath