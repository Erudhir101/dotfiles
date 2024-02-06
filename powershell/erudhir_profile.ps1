#set Powershell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

#Alias
Set-Alias ll ls
Set-Alias g git
Set-Alias tt tree 
Set-Alias v nvim 
Set-Alias grep findstr 

#Prompt
# oh-my-posh init pwsh | Invoke-Expression
$omp_config = Join-Path $PSScriptRoot ".\erudhir_style.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

#Terminal Icons
Import-Module Terminal-Icons

#PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

#Function
function whereis($command) {
  
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
