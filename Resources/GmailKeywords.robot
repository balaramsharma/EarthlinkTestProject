*** Settings ***
Library    AppiumLibrary

*** Variables ***
${emailLocator}     //android.widget.EditText
${passwordLocator}  //android.widget.EditText
${iagreeBtn}    //*[@resource-id='signinconsentNext']
${btnMore}  //android.widget.Button
${gotItBtn}     //*[contains(@resource-id,'welcome_tour_got_it')]
${takeMeToGmailBtn}     //*[contains(@resource-id,'action_done')]
${composeBtn}   //*[contains(@resource-id,'compose_button')]
${popUpBtn}     //*[contains(@resource-id,'button1')]
${toLocator}    id=com.google.android.gm:id/to
${subjectLocator}    id=com.google.android.gm:id/subject
${bodyLocator}    //*[@text='Compose email']
${sendBtn}  id=com.google.android.gm:id/send
${expandMenuBtn}    xpath=//android.widget.ImageButton[@content-desc="Open navigation drawer"]
${sentBoxBtn}  //*[@text='Sent']


*** Keywords ***
Open My Application
    [Arguments]   ${appName}     ${activityName}    ${url}=http://0.0.0.0:4723/wd/hub
    [Documentation]  Generic keyword to open any application with given app activity.
    Open Application   ${url}    platformName=Android    platformVersion=11	 deviceName=emulator-5554	appPackage=${appName}   appActivity=${activityName}

Open Gmail Application
    [Arguments]  ${appActivity}
    [Documentation]  Keyword to open gmail application with given app activity.
    Open Application   http://0.0.0.0:4723/wd/hub    platformName=Android    platformVersion=11	 deviceName=emulator-5554	appPackage=com.google.android.gm   appActivity=${appActivity}

Wait Until Login Form Appears
   [Documentation]  Waits for login form to appear
   Wait until element is visible  //*[@resource-id='headingText']   15   Sign In form not appeared.

Choose Google
    Click Text  Google

GM Input Text
    [Arguments]  ${locator}     ${text}
    [Documentation]  Extends build in keyword click element
    Wait Until Element Is Visible   ${emailLocator}     5   Textbox with locator:${locator} is not visible
    #Click Element   ${locator}
    Input Text   ${locator}     ${text}

Input Email
    [Arguments]  ${email}
    GM Input Text   ${emailLocator}     ${email}

Click Next Button
    Click Button   Next

Click I Agree Button
    Wait For Transition
    Click Button    I agree

Click More Button
    Wait For Transition     10
    Click Button    MORE

Click Accept Button
    Wait For Transition
    Click Button   ACCEPT
    Wait For Transition     10

Wait For Transition
    [Arguments]  ${maxWait}=5
    [Documentation]  Created this keyword just for hard waiting. Actually this keyword should have some explicit wait logics.Alhough hard sleep is not preferred,I have created it due to time constraints.
    Sleep   ${maxWait}

Wait And Click Element
    [Arguments]  ${locator}
    Wait Until Element Is Visible   ${locator}   15     Element with locator:${locator} is not visible till 15 seconds.
    Click Element   ${locator}

Click Button Got It
    Wait And Click Element   ${gotItBtn}

Click Button Take Me To Gmail
    Wait For Transition     3
    Wait And Click Element   ${takeMeToGmailBtn}

Input Password
    [Arguments]  ${pass}
    Sleep   1.0
    GM Input Text   ${passwordLocator}  ${pass}

Click On Compose Button
    Wait And Click Element  ${composeBtn}

Click Ok Pop Up Button If Appeared
   Wait For Transition  5
   Run Keyword And Ignore Error     Click Element    ${popUpBtn}
   Wait For Transition  2

Input Email Receiver
    [Arguments]     ${email}
    Input Text   ${toLocator}   ${email}
    Sleep   1

Input Email Subject
    [Arguments]     ${subject}
    Input Text   ${subjectLocator}   ${subject}
    Sleep   1

Input Email Content
    [Arguments]     ${content}
    Input Text   ${bodyLocator}   ${content}
    Sleep   1

Click Send Email Button
    Click Element   ${sendBtn}
    Wait For Transition

Open Navigation Drawer
    Wait And Click Element  ${expandMenuBtn}
    Wait For Transition     2

Open Sent Box
    Click Element   ${sentBoxBtn}
    Wait For Transition

Verify Email Exists In SentBox
    [Arguments]  ${emailSubject}
    Wait Until Element Is Visible   xpath=//android.widget.TextView[contains(@text,'${emailSubject}')]   10     Email with subject:${emailSubject} doesn't exist in sent box.
