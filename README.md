# PSscript_validator
PowerShell script that parse and validate the syntax.

## Usage
When the script is executed it prompts for the file location.
Once the file is selected the script will parse and analyze it and also check the encoding.

## Output valid script
```powershell

PS Script Validator and Encoding checker...

-----------------------------------------------------

1 script(s) processed, 0 script(s) contain syntax errors.

-----------------------------------------------------

Name                   BodyName EncodingName   
----                   -------- ------------   
japanese_dictionary_ok.ps1 utf-8    Unicode (UTF-8)
```

## Output invalid script
```powershell
PS Script Validator and Encoding checker...

-----------------------------------------------------


Path         : C:\Users\Sebastian\Desktop\input\japanese_dictionary_bad.ps1
ErrorMessage : Unexpected token '¯ãƒ©ã‚¤ã‚¢ãƒ³ãƒˆ' in expression or statement.
Content      : ¯ãƒ©ã‚¤ã‚¢ãƒ³ãƒˆ
Type         : Position
Start        : 166
Length       : 16
StartLine    : 4
StartColumn  : 84
EndLine      : 4
EndColumn    : 100

Path         : C:\Users\Sebastian\Desktop\input\japanese_dictionary_bad.ps1
ErrorMessage : The hash literal was incomplete.
Content      : 
Type         : Position
Start        : 166
Length       : 0
StartLine    : 4
StartColumn  : 84
EndLine      : 4
EndColumn    : 84

Path         : C:\Users\Sebastian\Desktop\input\japanese_dictionary_bad.ps1
ErrorMessage : Unexpected token '}' in expression or statement.
Content      : }
Type         : Position
Start        : 296
Length       : 1
StartLine    : 5
StartColumn  : 100
EndLine      : 5
EndColumn    : 101


1 script(s) processed, 1 script(s) contain syntax errors.

-----------------------------------------------------
Name         : japanese_dictionary_bad.ps1
BodyName     : iso-8859-1
EncodingName : Western European (Windows)
```

## License
[MIT](https://choosealicense.com/licenses/mit/)


