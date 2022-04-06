*** Settings ***
Resource    ../Resources/GmailKeywords.robot

Suite Teardown   Close Application

*** Variables ***
${gmailSetupActivity}  com.google.android.gm.setup.AccountSetupFinalGmail
${gmailAccountAccessActivity}   com.google.android.gm.ConversationListActivityGmail
${email}    <yourgmail>
${pass}     <yourpassword>
${receiver}     mytestt90@gmail.com
${subject}   Automation Test
${content}  Hello,${\n}This is automation test message.Please ignore it.${\n}Thank you.


*** Test Cases ***
Open Gmail And Setup Account
    Open Gmail Application   ${gmailSetupActivity}
    Choose Google
    Wait Until Login Form Appears
    Input Email     ${email}
    Click Next Button
    Input Password  ${pass}
    Click Next Button
    Click I Agree Button
    Click More Button
    Click Accept Button

Open Gmail For Sending Email
    Open Gmail Application  ${gmailAccountAccessActivity}
    Click Button Got It
    Click Button Take Me To Gmail

Compose And Send Email
    Click On Compose Button
    Click Ok Pop Up Button If Appeared
    Input Email Receiver    ${receiver}
    Input Email Subject     ${subject}
    Input Email Content     ${content}
    Click Send Email Button

Verify Email Is Sent
    Open Navigation Drawer
    Open Sent Box
    Verify Email Exists In SentBox  ${subject}
