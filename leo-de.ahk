; Skript für Autohotkey - http://autohotkey.com
; Funktionen:
; 1 Markiertes Wort bei http://leo.org übersetzen
; 2 Texteingabefeld öffnen, wenn kein Wort markiert ist
; 3 Wenn ein URL markiert ist, diesen URL an Standardbrowser übergeben
; Version: 1.0
; Erstellt am: 18.12.2005
; Autor: Peter Lederer, p.lederer@t-online.de
; Anregung: Andreas Borutta, http://borumat.de/kontakt
; Tastenkürzel: Win+Ü

#ü::
; Inhalt der Zwischenablage in Variable speichern, anschließend leeren
temp := ClipboardAll
Clipboard =
; Strg+C senden, Inhalt in Variablen speichern
Send, ^c
search := Clipboard

/*
Prüfung, ob sich in den ersten 8 Zeichen des markierten Bereichs die durch Komma 
getrennten Begriffe befinden Wenn nicht, Abbruch. Die Liste kann beliebig erweitert 
werden, alle Begriffe müssen durch Komma (ohne Leerzeichen) getrennt werden.
*/

StringLeft, strTest, search, 8
If strTest not contains www.,http://,https://,ftp://
	{
	If clipboard <>
		{
		; ursprüngliche Zwischenablage wiederherstellen	
	    	Clipboard := tmp
	    	; Speicher wieder freimachen
	    	tmp =
	    	Run, http://dict.leo.org/?search=%Search%
	    	Return
		}
	Else
		{
		Inputbox, search, Leo.org Übersetzung, Bitte Suchbegriff eingeben, , 300, 140
		If ErrorLevel <> 0
			Exit
		Else
			{
			; ursprüngliche Zwischenablage wiederherstellen
	    		Clipboard := tmp
	    		; Speicher wieder freimachen
	    		tmp =
			Run, http://dict.leo.org/?search=%Search%
			Return
			}
		}		
	}
Else
	{
	If clipboard <>
	   	{
		; ursprüngliche Zwischenablage wiederherstellen
	    	Clipboard := temp
	    	; Speicher wieder freimachen
	    	temp =
	    	; Festellen, ob an zweit- od. drittletzter Stelle ein Punkt steht
	    	StringLen, strLaenge2, search 
	    	StringMid, strPunkt2, search, strLaenge2 - 2, 1
	    	StringLen, strLaenge3, search 
	    	StringMid, strPunkt3, search, strLaenge3 - 3, 1
	    	StringLen, strLaenge4, search 
	    	StringMid, strPunkt4, search, strLaenge4 - 4, 1	    	
		If strPunkt2 = .
			{
	    		Run, %search%
			Return
			}
		Else If strPunkt3 = .
			{
	    		Run, %search%
			Return
			}
		Else If strPunkt4 = .
			{
	    		Run, %search%
			Return
			}		
		Else
		MsgBox, Die URL scheint nicht korrekt zu sein
		}
	Else
		{
		Clipboard := temp
		; Speicher wieder freimachen
		temp =
		}
	}
Return
