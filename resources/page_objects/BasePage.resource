*** Settings ***
Library    SeleniumLibrary
Variables    ../locators/BasePageLocators.py
Resource   ../common_variables.robot

*** Keywords ***
Open Application
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
    Wait Until Page Contains    Football Booking    ${TIMEOUT}

Close Application
    Close Browser

Go To Home Page
    Go To    ${URL}
    Wait Until Page Contains    Football Booking    ${TIMEOUT}

Click Navigation Link
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${TIMEOUT}
    Click Element    ${locator}
