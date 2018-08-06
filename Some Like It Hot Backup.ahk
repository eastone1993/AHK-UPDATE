﻿;----------------------------------- SOME LIKE IT HOTKEYS BEGIN BACKUP -------------------------------------------------------------------------------------------------------------
/*
Name: <FIRSTNAME> <LASTNAME>
Username: <USERNAME>
Initials: <INITIALS> 
Assistant: <ASSISTANT>
Roster File Path: C:\Users\<USERNAME>\Desktop\Rosters
*/
;put hotstrings here 
;----------------------------------- HOTSTRINGS -------------------------------------------------------------------------------------------------------------
::xsig::Sincerely,{enter}{enter}<FIRSTNAME> <LASTNAME>{enter}IXL Account Services{enter}{enter}Mailing Address:{enter}IXL Learning{enter}777 Mariners Island Blvd., Suite 600{enter}San Mateo, CA 94404 USA{enter}{enter}Toll-free 1.855.255.8800 | Direct 1.650.372.4300 | Fax: 1.650.372.4301
::lmk::Please let me know if you have any questions.
::tfyr::Thanks for your reply.
::tfcu::Thanks for contacting us.
::ihte::I hope this e-mail finds you well.
::tro::Thanks for reaching out{!}
::tgb::Thanks for getting back to me{!}
::gq::Great question{!}
::xur:: We have a new tool available in your administrator account  to ensure security and privacy for your data. You can simply click the  “Upload roster files” link found under the Account Management tab to access a secure upload page for all of your student and teacher information.
::ixlfdos::My name is <FIRSTNAME>, I'll be your account services coordinator moving forward. I'm reaching out because I've noticed you haven't uploaded any students to your roster yet. Also, you don't have your school's first day of classes listed on your account. Is there anything I can do to help get your account set up?
::xsi::Please send me a complete student list with the following student information in separate columns of an Excel spreadsheet:{enter}{enter}    •First name{enter}    •Last name{enter}    •Student ID number{enter}    •Grade level{enter}    •Teacher last name or teacher email{enter}{enter}Note that student’s first name, last name, student ID, and grade level are required. 
::fsu::Your account currently has fall setup enabled. IXL’s fall setup tool will help automatically promote students to the next grade level and clear class rosters two weeks prior to your first day of school, on [date]. Please advise if you would like this tool to remain enabled, or I am happy to assist you if you would like to have it turned off. 
::ifhb::I look forward to hearing back from you{!}
::yrsa::Your roster has been successfully added. 
::ysbr::Your student has been restored.
::orfdos::My name is <FIRSTNAME>, I'll be your account services coordinator moving forward. I'm reaching out because I've noticed you don't have your school's first day of classes listed on your account. This information is important for our internal systems. I look forward to hearing back from you{!} 
::ccadmin::I have copied your IXL administrator in this email for reference. 
;eric's requested hotstrings 
::qssr::https://www.ixl.com/userguides/IXLQuickStart_SiteRoster.pdf 
::afaq::https://www.ixl.com/help-center/School-administrators/665924
::aqsg::https://www.ixl.com/userguides/IXLQuickStart_Administrator.pdf
::xtemp::I have attached in this e-mail a blank roster template for your use.

;----------------------------------- SPELL CHECK -------------------------------------------------------------------------------------------------------------
:*?:recieve::receive 
::setup::set-up
::checkin::check-in
:*?:email::e-mail
:*?:seperate::separate
:*?:reccommend::recommend 
::ixl::IXL 
::teh::the 
::managment::management 
:*?:neccessary::necessary
;-----------------------------------DATE STAMP FUNCTION--------------------------------------------------------------------------------------------------------------------------------------
:R*?:ddd::
FormatTime, CurrentDateTime,, MM/dd/yyyy
SendInput %CurrentDateTime% + <INITIALS>{enter}{enter}{enter}{Up}
Return
;-----------------------------------EXCEL FUNCTIONS-----------------------------------------------------------------------------------------------------------------------------------------
^+q::
Send ^a
Send ^c
Send +{F11}
Send ^!v
Send v
Send {enter}
Return


/*
ALL IN ONE SCRUBBING AND SAVING FUNCTION: 
Check to see if Excel file contains all 4 columns that are important. If so, press Ctl+Shift+L to enable editing, remove unnecessary formating,
sort out blank rows, set file path, and save in CSV format. 
*/

^+l::
;enables editing 
Send !f
sleep, 250
Send i
sleep, 250
Send e
sleep, 250

;resets to main window 
Send {Esc}{Esc}{Esc}
sleep, 500

;scrubbing block 
Send ^{Home}
sleep, 500
Send, ^+{End}
sleep, 250
Send ^c
sleep, 250
Send +{F11}
sleep, 250
Send ^!v
sleep, 250
Send v
Send {enter}
sleep, 250

;sorts file to eliminate blank lines 
Send ^{Home} ;resets to A1:A1
sleep, 250
Send, {down}
sleep, 250
Send ^+{End} ;selects everything below header
sleep, 250
Send {alt}
sleep, 250
Send a 
sleep, 250
send sa      ;sorts out empty rows 
sleep, 500

;saving block 
Send {F12}
sleep, 500
Send {F4}{F6}{F6}{F6}{F6}{F6}{F6}
sleep, 500
Send d ;resets file type
Send c ;sets file type to csv 
Send !d ;moves to address bar 
sleep, 250
Send C:\Users\<USERNAME>\Desktop\Rosters ;file path
Send, {enter}
sleep, 250
Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab} ;navigates back to filename bar 
;MsgBox, Done
Return
;------------------------------------SEARCH FUNCTIONS---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
Ctrl+Shift+S EMAIL, ACCOUNT NUMBER, OR CASE NUMBER
EMAIL: Searches Quia, SubMan, and SalesForce
ACC#: Searches SubMan and salesforce
Case#: Searches SalesForce
*/
^+s:: 
Clipboard =
Send ^c
ClipWait
contents := Clipboard
contentsTrimmed = %contents%
if RegExMatch(contentsTrimmed, "[\w-_.]+@(?:\w+(?::\d+)?\.){1,3}(?:\w+\.?){1,2}", email) {
    
    Run, "chrome.exe" ; CREATES A NEW WINDOW OF CHROME

    ;QUIA SEARCH
    winactivate ahk_exe chrome.exe
    ;Send, ^t ; NOT NECESSARY TO CREATE NEW TAB FOR FIRST SEARCH WHEN WINDOW IS ALREADY PULLED UP
    Variable := "https://secure.quia.com/servlets/quia.internal.userInfo.UserInfo?logicModule=1&email=" . email
    Clipboard := Variable
    Send, ^v
    Send, {enter}
    Clipboard := email
    
    ;SALES FORCE SEARCH
    Send, ^t
    var1 := "https://ixl.my.salesforce.com/_ui/search/ui/UnifiedSearchResults?searchType=2&sen=0JZ&sen=001&sen=02s&sen=068&sen=003&sen=00T&sen=00U&sen=005&sen=500&sen=00O&str=" . email
    var2 := var1 . "&isdtp=vw&isWsVw=true&nonce=02541659de9dde0d96e44d154840e14be6f2bb3fcc1022859c569e3e55629581&sfdcIFrameOrigin=https%3A%2F%2Fixl.my.salesforce.com"
    ClipWait
    Clipboard := var2
    sleep, 500 ;WAIT FOR PAGE TO LOAD
    Send, ^v
    Send, {enter}
    Clipboard := email

    ;SUBMANAGER SEARCH
    var3 := Clipboard
    Send, ^t
    Clipboard := "https://secure.quia.com/actions/subManager/search/sub"
    Send, ^v
    Send, {enter}
    sleep, 1000 ;WAIT FOR PAGE TO LOAD
    Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
    Clipboard := var3
    Send, ^v
    Send, {enter}
    
     ;sends the screen to the right 
    sleep, 500
    Send, #+{Right} 
    
} else {
    Length := StrLen(contentsTrimmed)
    if (Length=8){
        
        ;Run, "chrome.exe" ; CREATES A NEW WINDOW OF CHROME
        
        ;SALESFORCE SEARCH
        winactivate ahk_exe chrome.exe
        Send, ^t
        var1 := "https://ixl.my.salesforce.com/_ui/search/ui/UnifiedSearchResults?searchType=2&sen=0JZ&sen=001&sen=02s&sen=068&sen=003&sen=00T&sen=00U&sen=005&sen=500&sen=00O&str=" . contentsTrimmed
        var2 := var1 . "&isdtp=vw&isWsVw=true&nonce=02541659de9dde0d96e44d154840e14be6f2bb3fcc1022859c569e3e55629581&sfdcIFrameOrigin=https%3A%2F%2Fixl.my.salesforce.com"
        ClipWait
        Clipboard := var2
        sleep, 500
        Send, ^v
        Send, {enter}

    } else if (Length>8) {
        
        ;Run, "chrome.exe" ; CREATES A NEW WINDOW OF CHROME

        ;SUBMANAGER SEARCH
        winactivate ahk_exe chrome.exe
        StringTrimLeft, NewStr, contentsTrimmed, 4 ;TRIMS PRECEDING A##- SO IT WOULD WORK WITH SALES FORCE
        Send, ^t
        Variable := "https://secure.quia.com/actions/subManager/account/view/" . contentsTrimmed
        ClipWait    
        Clipboard := Variable
        Send, ^v
        Send, {enter} 

        ;SALESFORCE SEARCH
        Send, ^t
        var1 := "https://ixl.my.salesforce.com/_ui/search/ui/UnifiedSearchResults?searchType=2&sen=0JZ&sen=001&sen=02s&sen=068&sen=003&sen=00T&sen=00U&sen=005&sen=500&sen=00O&str=" . NewStr
        var2 := var1 . "&isdtp=vw&isWsVw=true&nonce=02541659de9dde0d96e44d154840e14be6f2bb3fcc1022859c569e3e55629581&sfdcIFrameOrigin=https%3A%2F%2Fixl.my.salesforce.com"   
        ClipWait
        Clipboard := var2
        sleep, 500
        Send, ^v
        Send, {enter}

    } else { 

        ;Run, "chrome.exe" ; CREATES A NEW WINDOW OF CHROME

        ;SUBMANAGER SEARCH
        winactivate ahk_exe chrome.exe
        Send, ^t
        Variable := "https://secure.quia.com/actions/subManager/account/view/" . contentsTrimmed
        ClipWait    
        Clipboard := Variable
        Send, ^v
        Send, {enter}   

        ;SALESFORCE SEARCH
        Send, ^t
        var1 := "https://ixl.my.salesforce.com/_ui/search/ui/UnifiedSearchResults?searchType=2&sen=0JZ&sen=001&sen=02s&sen=068&sen=003&sen=00T&sen=00U&sen=005&sen=500&sen=00O&str=" . contentsTrimmed
        var2 := var1 . "&isdtp=vw&isWsVw=true&nonce=02541659de9dde0d96e44d154840e14be6f2bb3fcc1022859c569e3e55629581&sfdcIFrameOrigin=https%3A%2F%2Fixl.my.salesforce.com"   
        ClipWait
        Clipboard := var2
        sleep, 500
        Send, ^v
        Send, {enter}
    }

}
Return





^+d::
; Identifies selected text as username or e-mail and searches for account
; Start off empty to allow ClipWait to detect when the text has arrived.
Clipboard =
Send ^c
; Wait for the clipboard to contain text.
ClipWait
contents := Clipboard
contentsTrimmed = %contents%
if RegExMatch(contentsTrimmed, "[\w-_.]+@(?:\w+(?::\d+)?\.){1,3}(?:\w+\.?){1,2}", email) {
    winactivate ahk_exe chrome.exe
    Send, ^t
    Variable := "https://secure.quia.com/servlets/quia.internal.userInfo.UserInfo?logicModule=1&email=" . email
    Clipboard := Variable
    Send, ^v
    Send, {enter}
    Clipboard := email
    
} else {
    winactivate ahk_exe chrome.exe
    var1 := Clipboard
    Send, ^t
    Clipboard := "https://secure.quia.com/actions/subManager/search/sub"
    Send, ^v
    Send, {enter}
    sleep, 1000
    Send {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
    Clipboard := var1
    Send, ^v
    Send, {enter}
}
Return



;----------------------------------------------END COPY AND PASTE BACK UP---------------------------------------------------


