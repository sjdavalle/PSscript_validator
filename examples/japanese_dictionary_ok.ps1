$OutputEncoding = New-Object -typename System.Text.UTF8Encoding

# Dictionaries
$ClientToken=@{English='Client'; Spanish='cliente'; Italian='cliente'; Japanese='クライアント タイプ'};
$IdleToken =@{English='Idle'; Spanish='inactivo'; Italian='inattivo'; Japanese='アイドル時間'};

$isSpanish =  Get-UICulture | Select-String 'es-';
$isItalian =  Get-UICulture | Select-String 'it-';
$isJapanese =  Get-UICulture | Select-String 'ja-';

if($isSpanish){
    $ClientString = $ClientToken.Spanish;
    $IdleString = $IdleToken.Spanish;
}elseif($isItalian){
    $ClientString = $ClientToken.Italian;
    $IdleString = $IdleToken.Italian;
}elseif($isJapanese){
    $ClientString = $ClientToken.Japanese;
    $IdleString = $IdleToken.Japanese;
}else{
    $ClientString = $ClientToken.English;
    $IdleString = $IdleToken.English;
}

Write-Host "$ClientString - $IdleString"
