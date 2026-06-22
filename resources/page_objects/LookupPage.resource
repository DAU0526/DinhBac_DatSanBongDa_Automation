*** Settings ***
Library    SeleniumLibrary
Variables    ../locators/LookupPageLocators.py
Resource   ../common_variables.robot

*** Keywords ***
Open Lookup Page
    Go To    ${URL}/lookup
    Wait Until Element Is Visible    ${LOOKUP_INPUT}    ${TIMEOUT}

Type Booking Code
    [Arguments]    ${booking_code}
    Wait Until Element Is Visible    ${LOOKUP_INPUT}    ${TIMEOUT}
    Clear Element Text    ${LOOKUP_INPUT}
    Input Text    ${LOOKUP_INPUT}    ${booking_code}

Submit Lookup
    Wait Until Element Is Visible    ${LOOKUP_BUTTON}    ${TIMEOUT}
    Click Element    ${LOOKUP_BUTTON}
