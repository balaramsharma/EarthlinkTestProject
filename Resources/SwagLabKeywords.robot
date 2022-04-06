*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    OperatingSystem
Library    String
Library    Collections

*** Variables ***
${productPage}  https://www.saucedemo.com/inventory.html

*** Keywords ***
Open My Browser
    [Arguments]    ${url}   ${browserName}=chrome
    [Documentation]    Opens browser locally.
    Append To Environment Variable  PATH    ${EXECDIR}${/}Driver${/}
    ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --ignore-certificate-errors
    ${options}=     Call Method     ${chrome_options}    to_capabilities    
    Open Browser    browser=${browserName}    desired_capabilities=${options}
    Maximize Browser Window

Wait Until Login Page Appears
    [Arguments]  ${maxWait}=15
    Wait Until Element Is Visible   class:login_wrapper-inner   ${maxWait}   Login page did not appeared till ${maxWait} seconds.

EL Input Text
    [Arguments]  ${locator}     ${text}
    [Documentation]  Waits for input textarea to be visible and inputs text in the textbox identified by locator.
    Wait Until Element Is Visible   ${locator}      10   Text input area with locator:${locator} is not visible.
    Input Text  ${locator}     ${text}
    #Sleeping 1s to avoid entered text to persist
    Sleep   1

Enter Username
    [Arguments]  ${name}
    EL Input Text  id:user-name    ${name}

Enter Password
    [Arguments]  ${pass}
    EL Input Text  id:password    ${pass}

Click On Login Button
    Wait And Click Element  id:login-button

Wait And Click Element
    [Arguments]  ${locator}
    [Documentation]  Waits for element to be visible and clicks the elememt.
    Wait Until Element Is Visible   ${locator}  10  Element with locator:${locator} is not visible.
    Click Element   ${locator}

Verify Login Is Successful
    [Arguments]  ${maxWait}=30
    Wait Until Element Is Visible  class:header_secondary_container     ${maxWait}  Login is not successful till ${maxWait} seconds.

Verify Login Error Is Displayed
    Wait Until Element Is Visible  //h3[contains(normalize-space(),'Username and password do not match any user in this service')]  15  Login error should have been displayed for invalid login

Remove Product If Exists In Cart
    [Arguments]  ${product}
    [Documentation]  Removes a product from cart if exists
    ${status}   Run Keyword And Return Status   Verify Products Exists In Cart   ${product}
    Return From Keyword If  ${status}   Remove A Product From Cart  ${product}

Remove A Product From Cart
    [Arguments]  ${product}
    [Documentation]  Removes a product from cart.
    Wait And Click Element  //div[@class='cart_item_label' and .//*[contains(text(),'${product}')]]//button[text()='Remove']
    Wait Until Element Is Not Visible   //div[@class='cart_item_label' and .//*[contains(text(),'${product}')]]     Product:${product} should have been removed from the cart

Verify Products Exists In Cart
    [Arguments]  ${product}
    [Documentation]  Verifies added product exists in the cart.
    Wait Until Element Is Visible   //div[@class='cart_item_label' and .//*[contains(text(),'${product}')]]     5   Product:${product} is not found in the cart.

Open Cart
    Wait And Click Element  class:shopping_cart_link
    Wait Until Element Is Visible   //span[text()='Your Cart']   15     Cart is not opened

Go To Products Page
    Go To   ${productPage}

Add A Product To Cart
    [Arguments]  ${product}
    [Documentation]  Adds a product into cart
    Wait Until Element Is Visible   //div[@class='inventory_item_description' and .//div[contains(text(),'${product}')]]    15   There is no product with name:${product}
    Wait And Click Element  //div[@class='inventory_item_description' and .//div[contains(text(),'${product}')]]//button[contains(@id,'add-to-cart')]

Proceed Checkout
    Click Element   id:checkout
    Wait Until Element Is Visible   //span[text()='Checkout: Your Information']     10   Information filling step in checkout is not visible.

Fill Information And Continue Checkout
    [Arguments]  ${firstName}   ${lastName}     ${zip}
    EL Input Text   id:first-name   ${firstName}
    EL Input Text   id:last-name   ${lastName}
    EL Input Text   id:postal-code   ${zip}
    Click Element   id:continue

Check Checkout Overview
    [Arguments]  ${productName}
    Wait Until Element Is Visible   //span[text()='Checkout: Overview']     10  Checkout overview page is not opened.
    Element Should Be Visible    //div[text()='${productName}']     The product:${productName} should be seen in the overview.
    Element Should Be Visible   //div[@class='summary_total_label'][contains(text(),'Total:')]   Total Amount should be displayed.

Finish Checkout
    Click Element   id:finish

Verify Checkout Is Completed
    Wait Until Element Is Visible   //span[text()='Checkout: Complete!']     10     Checkout complete step should appear.

Click On Back Home
    Click Element   id:back-to-products
    Wait Until Element Is Visible   //span[text()='Products']   10  Products page should be opened.

Expand Left Menu
    Click Element   id:react-burger-menu-btn
    Wait Until Element Is Visible   class:bm-item-list   15     Left menu is not expanded.
    Sleep  2.0

Click On Logout
    Click Element   id:logout_sidebar_link
