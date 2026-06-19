*** Settings ***
Library    SeleniumLibrary
Resource   ../config/environment.robot

*** Variables ***
${NAV_HOME}                     xpath=//a[@href='/']
${NAV_FIELDS}                   xpath=//a[@href='/fields']
${NAV_BOOKING}                  xpath=//a[@href='/booking']
${NAV_LOOKUP}                   xpath=//a[@href='/lookup']
${NAV_MY_BOOKINGS}              xpath=//a[@href='/my-bookings']

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
