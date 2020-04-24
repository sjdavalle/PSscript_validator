$OutputEncoding = New-Object -typename System.Text.UTF8Encoding

 Write-Host "`nPS Script Validator and Encoding checker..."
 Write-Host "`n-----------------------------------------------------"

function Get-FileName($initialDirectory)
{   
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
    Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "All files (*.*)| *.*"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}

$ScriptPath = Get-FileName

function Get-Encoding
{
    param([Parameter(ValueFromPipeline=$True)] $filename)    
    
    begin {}

    process 
    {
        $reader = [System.IO.StreamReader]::new($filename, [System.Text.Encoding]::default,$true)
        $peek = $reader.Peek()
        $encoding = $reader.currentencoding
        $reader.close()

        [pscustomobject]@{
                Name=split-path $filename -leaf
                BodyName=$encoding.BodyName
                EncodingName=$encoding.EncodingName
        }

    }
}

function Test-PSScript
{

   param(
      [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)] 
      [ValidateNotNullOrEmpty()] 
      [Alias('PSPath','FullName')] 
      [System.String[]] $FilePath,

      [Switch]$IncludeSummaryReport
   )

   begin
   {
      $total=$fails=0
   }

   process
   {
       $FilePath | Foreach-Object {

         #check whether it is a file or not
         if(Test-Path -Path $_ -PathType Leaf)
         {
            $Path = Convert-Path –Path $_ 

            $Errors = $null
            $Content = Get-Content -Path $path 
            $Tokens = [System.Management.Automation.PsParser]::Tokenize($Content,[ref]$Errors)

            if($Errors)
            {
               $fails+=1
               $Errors | Foreach-Object { 
                  $_.Token | Add-Member -MemberType NoteProperty -Name Path -Value $Path -PassThru | `
                  Add-Member –MemberType NoteProperty -Name ErrorMessage -Value $_.Message -PassThru
               }
            }

           $total+=1 
         }  
      }
   } 

   end 
   {
      if($IncludeSummaryReport) 
      {
         Write-Host "`n$total script(s) processed, $fails script(s) contain syntax errors."
         Write-Host "`n-----------------------------------------------------"
      }
   }
} 

Test-PSScript -PSPAth $ScriptPath -IncludeSummaryReport

Get-Encoding $ScriptPath