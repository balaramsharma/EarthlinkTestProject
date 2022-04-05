*** Settings ***
Resource    ${EXECDIR}${/}Resources${/}CommonKeywords.robot

Suite Setup  Run Keywords   Open My Browser  ${browser}   AND    Set Selenium Speed   0.2s
Suite Teardown    Close Browser


*** Variables ***
${browser}  Chrome
${loginUrl}  https://www.saucedemo.com
${standardUser}     standard_user
${lockedOutUser}    locked_out_user
${problemUser}   problem_user
${performanceGlitchUser}    performance_glitch_user
${password}     secret_sauce
${product}  Sauce Labs Backpack
${firstName}    automation
${lastName}     test
${zip}  0123
${itemNotAdded}     ${TRUE}

*** Test Cases ***
Login With Valid Username And Invalid Password
    Go To  ${loginUrl}
    Wait Until Login Page Appears
    Enter Username   ${standardUser}
    Enter Password   random12312
    Click On Login Button
    Verify Login Error Is Displayed

Login With Standard User
    Go To  ${loginUrl}
    Wait Until Login Page Appears
    Enter Username   ${standardUser}
    Enter Password   ${password}
    Click On Login Button
    Verify Login Is Successful

Add Items To The Cart
    Open Cart
    Remove Product If Exists In Cart    ${product}
    Go To Products Page
    Add A Product To Cart   ${product}
    Open Cart
    Verify Products Exists In Cart   ${product}
    Set Suite Variable  ${itemNotAdded}     ${FALSE}

Checkout Cart
    Skip If     ${itemNotAdded}     Product is not added in the cart. Hence skipping the test case.
    Proceed Checkout
    Fill Information And Continue Checkout  ${firstName}    ${lastName}     ${zip}
    Check Checkout Overview     ${product}
    Finish Checkout
    Verify Checkout Is Completed
    Click On Back Home

Logout From Application
    Expand Left Menu
    Click On Logout
    Wait Until Login Page Appears



    

