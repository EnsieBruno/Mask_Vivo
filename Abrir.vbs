Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

caminhoHtml = fso.GetAbsolutePathName("index.html")

' Abre no Edge e desativa redimensionamento e maximização no Windows
comando = "powershell -WindowStyle Hidden -Command """ & _
    "Start-Process msedge -ArgumentList '--app=""file:///" & caminhoHtml & """ --window-size=388,415';" & _
    "$code = 'using System; using System.Runtime.InteropServices; public class Win { [DllImport(""user32.dll"")] public static extern IntPtr FindWindow(string c, string n); [DllImport(""user32.dll"")] public static extern int GetWindowLong(IntPtr h, int n); [DllImport(""user32.dll"")] public static extern int SetWindowLong(IntPtr h, int n, int v); [DllImport(""user32.dll"")] public static extern bool SetWindowPos(IntPtr h, IntPtr a, int x, int y, int cx, int cy, uint f); }';" & _
    "Add-Type -TypeDefinition $code;" & _
    "for ($i=0; $i -lt 20; $i++) { " & _
    "  $h = [Win]::FindWindow($null, 'Máscara de Atendimento'); " & _
    "  if ($h -ne [IntPtr]::Zero) { " & _
    "    $style = [Win]::GetWindowLong($h, -16); " & _
    "    $style = $style -band -not 0x00040000 -band -not 0x00010000; " & _
    "    [Win]::SetWindowLong($h, -16, $style); " & _
    "    [Win]::SetWindowPos($h, -1, 0, 0, 388, 415, 0x0002); " & _
    "    break; " & _
    "  } " & _
    "  Start-Sleep -Milliseconds 150; " & _
    "}"""

shell.Run comando, 0, False
