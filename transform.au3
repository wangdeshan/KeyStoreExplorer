#AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

main()



Func main()
	Local $Stt = "resources.properties"
	Local $AD3 = FileReadToArray($Stt)
	Local $AD1 = FileReadToArray($Stt & '.E.txt')
	Local $AD2 = FileReadToArray($Stt & '.T.txt')

	If @error Then
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : @error = ' & @error & @CRLF) ;### Debug Console
		main1()
		Return
	EndIf
	
	Local $SttN = 'resources_zh.properties'

;~ 	_ArrayDisplay($AD)
	
	For $I1 = 0 To UBound($AD2) - 1 Step 1
		Local $line = $AD2[$I1]
		If StringStripWS($line, 8) = '' Then ContinueLoop
		If StringLeft($line, 1) = '#' Then ContinueLoop

		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $line = ' & $line & @CRLF) ;### Debug Console
		
		Local $l = StringInStr($line, "=")
		Local $ln = StringLeft($line, $l - 1)
		$line = StringStripWS(StringTrimLeft($line, $l), 1 + 2)
		$AD3[$ln] = $AD1[$ln] & " " & $line
	Next
	
	Local $Sn = FileOpen($SttN, 2)

	For $I1 = 0 To UBound($AD3) - 1 Step 1
		FileWriteLine($Sn, $AD3[$I1])
	Next
	FileClose($Sn)
	
	ShellExecute("notepad", $SttN)
EndFunc   ;==>main


Func main1()
	Local $Stt = "resources.properties"
	Local $AD = FileReadToArray($Stt)
	
	If @error Then
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : @error = ' & @error & @CRLF) ;### Debug Console
		Return
	EndIf
	
	Local $SttN = $Stt & '.N.txt'
	Local $SttE = $Stt & '.E.txt'

;~ 	_ArrayDisplay($AD)
	Local $Sn = FileOpen($SttN, 2)
	Local $Se = FileOpen($SttE, 2)

	For $I1 = 0 To UBound($AD) - 1 Step 1
		Local $line = $AD[$I1]

		Local $l = StringInStr($line, "=")
		Local $e = StringLeft($line, $l)
		$line = StringTrimLeft($line, $l)
		FileWriteLine($Se, $e)
		
		If StringLen(StringStripWS($line, 8)) < 2 Then ContinueLoop
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : StringLeft($line, 1) = ' & StringLeft($line, 1) & @CRLF) ;### Debug Console
		If StringLeft($AD[$I1], 1) = '#' Then ContinueLoop

		FileWriteLine($Sn, $I1 & "=" & $line)

	Next
	FileClose($Sn)
	ShellExecute($SttN)
EndFunc   ;==>main1
