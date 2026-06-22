*** Settings ***
Library    SeleniumLibrary
Library    ../locators/LookupPageLocators.py    WITH NAME    lookup_locators
Resource   ../common_variables.robot

*** Keywords ***
Open Lookup Page
    Go To    ${URL}/lookup
    Wait Until Element Is Visible    ${lookup_locators.LOOKUP_INPUT}    ${TIMEOUT}

Type Booking Code
    [Arguments]    ${booking_code}
    Wait Until Element Is Visible    ${lookup_locators.LOOKUP_INPUT}    ${TIMEOUT}
    Clear Element Text    ${lookup_locators.LOOKUP_INPUT}
    Input Text    ${lookup_locators.LOOKUP_INPUT}    ${booking_code}

Submit Lookup
    Wait Until Element Is Visible    ${lookup_locators.LOOKUP_BUTTON}    ${TIMEOUT}
    Click Element    ${lookup_locators.LOOKUP_BUTTON}
