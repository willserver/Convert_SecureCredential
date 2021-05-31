#----- File Path Define -----
$ReadFilePath = ".\PlainText.txt"
$WriteFilePath = ".\EncryptText.txt"

#----- Main Process -----
if ((Get-ChildItem -Path $ReadFilePath) -ne $null) {    #Check PlainText.txt
    Write-Host "PlainText.txt Found."
    [String]$ReadPlainText = @(Get-Content $ReadFilePath)   #Read PlainText.txt
    Write-Host "PlainText.txt Read Success."

}else{
    Write-Host "PlainText.txt Not Found. Script Exit."  #if PlainText.txt file not found, Script Exit.
    Exit 0
}

if ($ReadPlainText -ne $null) {     #If PlainText.txt file is not null, Processing execution
    try {
        $Secure_String = ConvertTo-SecureString $ReadPlainText -AsPlainText -Force      #Convert plain text to secure string.
        Write-Host "Convert To Secure String Success."
    }
    catch {                 #If secure string convert error, Script Exit.
        
        Write-Host "Convert To Secure String Error."
        Write-Host $_.Exception
        Exit 0
    }

}else {       #If PlainText.txt file is null, Script Exit.
    Write-Host "PlainText.txt Null." 
    Exit 0
}
try {
    $Encrypt_String = ConvertFrom-SecureString -SecureString $Secure_String         #Convert secure string to encrypt string.
    Write-Host "Create Encrypt String Success."
}
catch {         #If secure string convert error, Script Eixt.
    Write-Host "Convert from secure string Error."
    Write-Host $_.Exception
    Exit 0
    
}

Write-Output $Encrypt_String | Add-Content $WriteFilePath -Encoding UTF8        #write encrypt string.
Write-Host "Encrypt String Write Success."


