; Skript für Autohotkey - http://autohotkey.com
; Funktionen:
; 1 Markiertes Wort bei http://de.wikipedia.org suchen
; 2 Texteingabefeld öffnen, wenn kein Wort markiert ist
; 3 Wenn ein URL markiert ist, diesen URL an Standardbrowser übergeben
; Version: 1.0
; Erstellt am: 18.12.2005
; Autor: Peter Lederer, p.lederer@t-online.de
; Anregung: Andreas Borutta, http://borumat.de/kontakt
; Tastenkürzel: WIN+Ä

#ä::
; Inhalt der Zwischenablage in Variable speichern, anschließend leeren
temp := ClipboardAll
Clipboard =
; Strg+C senden, Inhalt in Variablen speichern
Send, ^c
strSuche := Clipboard

/*
Prüfung, ob sich in den ersten 8 Zeichen des markierten Bereichs die durch Komma 
getrennten Begriffe befinden Wenn nicht, Abbruch. Die Liste kann beliebig erweitert 
werden, alle Begriffe müssen durch Komma (ohne Leerzeichen) getrennt werden.
*/

StringLeft, strTest, strSuche, 8
If strTest not contains www.,http://,https://,ftp://
	{
	If clipboard <>
		{
		; ursprüngliche Zwischenablage wiederherstellen	
	    	Clipboard := tmp
	    	; Speicher wieder freimachen
	    	tmp =
	    	Run, http://de.wikipedia.org/wiki/?search=%strSuche%
	    	Return
		}
	Else
		{
		Inputbox, strSuche, Wikipedia-Suche, Bitte Suchbegriff eingeben, , 300, 140
		If ErrorLevel <> 0
			Exit
		Else
			{
			; ursprüngliche Zwischenablage wiederherstellen
	    		Clipboard := tmp
	    		; Speicher wieder freimachen
	    		tmp =
			Run, http://de.wikipedia.org/wiki/?search=%strSuche%
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
	    	StringLen, strLaenge2, strSuche 
	    	StringMid, strPunkt2, strSuche, strLaenge2 - 2, 1
	    	StringLen, strLaenge3, strSuche 
	    	StringMid, strPunkt3, strSuche, strLaenge3 - 3, 1
	    	StringLen, strLaenge4, strSuche 
	    	StringMid, strPunkt4, strSuche, strLaenge4 - 4, 1	    	
		If strPunkt2 = .
			{
	    		Run, %strSuche%
			Return
			}
		Else If strPunkt3 = .
			{
	    		Run, %strSuche%
			Return
			}
		Else If strPunkt4 = .
			{
	    		Run, %strSuche%
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