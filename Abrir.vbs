Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' Pega o caminho do index.html na mesma pasta deste arquivo
caminhoHtml = fso.GetAbsolutePathName("index.html")

' Abre no Edge em modo Aplicativo (sem abas e sem barra de URL)
shell.Run "msedge --app=""file:///" & caminhoHtml & """ --window-size=400,520", 0
