#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; This let's any window that partially matches the given name get activated

; ###############################################################################################################
; ## Key Symbols
; ##   # : Windows key
; ##   ! : Alt
; ##   ^ : Ctrl
; ##   + : Shift
; ##   & : Combine Keys
; ###############################################################################################################

;#Include google-de.ahk
;#Include leo-de.ahk
;#Include wikipedia-de.ahk
;#Include google-translate.ahk

;--------------------------------------------------------------------------------

+F5::Edit 	; Shift-F5 launches the current AutoHotkey script in preferred editor, else Notepad 
^F5::Reload 	; Ctrl-F5 reloads the current AutoHotKey script after any edits.

;--------------------------------------------------------------------------------
#IfWinActive, Chrome
#B::
Send ^+o
;wait until loaded
sleep 1000
Send {Tab 4}
return

;--------------------------------------------------------------------------------
#IfWinActive, Cmder
F1::MsgBox You are using CmdEr terminal emulation
::lm::ls -las | more
::xdf::while true; do clear; date; df; sleep 1; done

;--------------------------------------------------------------------------------
#IfWinActive
;F1::MsgBox You are using any other program

;--------------------------------------------------------------------------------
; Replace PrintScreen key with Context key
PrintScreen::Send {AppsKey}
#PrintScreen::Send {PrintScreen}

;--------------------------------------------------------------------------------
#g::
Run \\home-ch\home-ch$\B040910\Baloise\Gleitzeit\Gleitzeit_2020.xlsm
return

; --------------------------------------------------------------------------------
; Hotstrings
; --------------------------------------------------------------------------------

:*:---::{Raw}--------------------------------------------------------------------------------

:*:mbg::
(
Mit besten Grüssen

Simon

)

:*:mlg::
(
Liebe Grüsse

Simon

)

:*:-lorem::{Raw}Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.

; --------------------------------------------------------------------------------


; --------------------------------------------------------------------------------
; Program launch with numpad
; --------------------------------------------------------------------------------

Numpad0 & Numpad1::
#Numpad1::
Run, uedit64.exe
return

; --------------------------------------------------------------------------------
; Hybernate
; --------------------------------------------------------------------------------

#^h::
; Parameter #1: Pass 1 instead of 0 to hibernate rather than suspend.
; Parameter #2: Pass 1 instead of 0 to suspend immediately rather than asking each application for permission.
; Parameter #3: Pass 1 instead of 0 to disable all wake events.
DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)
return

; --------------------------------------------------------------------------------
; Volume Control
; --------------------------------------------------------------------------------

#PgUp::
Send {Volume_Up}
return

#PgDn::
Send {Volume_Down}
return

#Numpad0::
; Retrieve the ID/HWND of the active window
id := WinExist("A")
MsgBox % id
return

; --------------------------------------------------------------------------------
; Start command prompt in current folder
; --------------------------------------------------------------------------------
#IfWinActive ahk_class CabinetWClass ; for use in explorer.
^!h::
ClipSaved := ClipboardAll
Send !d
Sleep 10
Send ^c
Run, cmd /K "cd `"%clipboard%`""
Clipboard := ClipSaved
ClipSaved =
return
#IfWinActive

; --------------------------------------------------------------------------------
; Google Search highlighted text - Ctrl+Windows+G
; --------------------------------------------------------------------------------
^#g::
{
  OldClipboard := Clipboard
  Clipboard := ""
  Send, ^c
  ClipWait
  Run, http://www.google.com/search?q=%clipboard%
  Sleep 200
  Clipboard := OldClipboard
  Return
}


; --------------------------------------------------------------------------------
; Translate selected text to German in Google - Ctrl+Windows+T
; --------------------------------------------------------------------------------

^#t::
{
  OldClipboard := Clipboard
  Clipboard := ""
  Send ^c
  ClipWait
  Run, https://translate.google.com/?view=home&op=translate&sl=auto&tl=de&text=%Clipboard%
;                                                             |       |
;                                                             |       +---------> Target Language = DE
;                                                             |
;                                                             +-----------------> Source Language = Auto
  Sleep 200
  Clipboard := OldClipboard
  return
}