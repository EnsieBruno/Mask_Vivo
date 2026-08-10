Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Obtém o caminho do index.html na mesma pasta
caminhoHtml = fso.GetAbsolutePathName("index.html")

' Abre em modo App (dimensão 395x480) e ativa o modo "Sempre no Topo" via API do Windows
comando = "powershell -WindowStyle Hidden -Command """ & _
    "Start-Process msedge -ArgumentList '--app=""file:///" & caminhoHtml & """ --window-size=395,480';" & _
    "$code = 'using System; using System.Runtime.InteropServices; public class Win { [DllImport(""user32.dll"")] public static extern IntPtr FindWindow(string c, string n); [DllImport(""user32.dll"")] public static extern bool SetWindowPos(IntPtr h, IntPtr a, int x, int y, int cx, int cy, uint f); }';" & _
    "Add-Type -TypeDefinition $code;" & _
    "for ($i=0; $i -lt 15; $i++) { $h = [Win]::FindWindow($null, 'Máscara de Atendimento'); if ($h -ne [IntPtr]::Zero) { [Win]::SetWindowPos($h, -1, 0, 0, 0, 0, 3); break; } Start-Sleep -Milliseconds 200; }" & _
    """"

shell.Run comando, 0, False
