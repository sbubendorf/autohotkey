; Skript für Autohotkey - http://autohotkey.com
; Funktionen:
; 1 Markiertes Wort /markierte Wörter bei http://google.de suchen
; 2 Texteingabefeld öffnen, wenn kein Wort markiert ist
; 3 Wenn ein URL markiert ist, diesen URL an Standardbrowser übergeben
; Version: 1.0
; Erstellt am: 18.12.2005
; Autor: Peter Lederer, p.lederer@t-online.de
; Anregung: Andreas Borutta, http://borumat.de/kontakt
; Tastenkürzel: Win+Ö
 
#ö::
; Inhalt der Zwischenablage in Variable speichern, anschließend leeren
temp := ClipboardAll
Clipboard =
; Strg+C senden, Inhalt in Variablen speichern
Send, ^c
wort := Clipboard

/*
Prüfung, ob sich in den ersten 8 Zeichen des markierten Bereichs die durch Komma 
getrennten Begriffe befinden Wenn nicht, Abbruch. Die Liste kann beliebig erweitert 
werden, alle Begriffe müssen durch Komma (ohne Leerzeichen) getrennt werden.
*/

StringLeft, strTest, wort, 8
If strTest not contains www.,http://,https://,ftp://
	{
	If clipboard <>
		{
		; ursprüngliche Zwischenablage wiederherstellen	
	    	Clipboard := tmp
	    	; Speicher wieder freimachen
	    	tmp =
	    	Run, http://google.de/search?hl=de&meta=lr=lang_de&q=%wort%
	    	Return
		}
	Else
		{
		Inputbox, wort, Google.de Suche, Bitte Suchbegriff eingeben, , 300, 140
		If ErrorLevel <> 0
			Exit
		Else
			{
			; ursprüngliche Zwischenablage wiederherstellen
	    		Clipboard := tmp
	    		; Speicher wieder freimachen
	    		tmp =
			Run, http://google.de/search?hl=de&meta=lr=lang_de&q=%wort%
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
	    	StringLen, strLaenge2, wort 
	    	StringMid, strPunkt2, wort, strLaenge2 - 2, 1
	    	StringLen, strLaenge3, wort 
	    	StringMid, strPunkt3, wort, strLaenge3 - 3, 1
	    	StringLen, strLaenge4, wort 
	    	StringMid, strPunkt4, wort, strLaenge4 - 4, 1	    	
		If strPunkt2 = .
			{
	    		Run, %wort%
			Return
			}
		Else If strPunkt3 = .
			{
	    		Run, %wort%
			Return
			}
		Else If strPunkt4 = .
			{
	    		Run, %wort%
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
