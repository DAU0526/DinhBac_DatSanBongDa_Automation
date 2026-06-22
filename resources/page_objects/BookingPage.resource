*** Settings ***
Library    SeleniumLibrary
Library    ../locators/BookingPageLocators.py    WITH NAME    booking_locators
Resource   ../common_variables.robot

*** Keywords ***
Fill Booking Customer Form
    [Arguments]    ${name}    ${phone}    ${email}
    Wait Until Element Is Visible    ${booking_locators.FIELD_BOOKING_NAME}    ${TIMEOUT}
    Clear Element Text    ${booking_locators.FIELD_BOOKING_NAME}
    Input Text    ${booking_locators.FIELD_BOOKING_NAME}    ${name}
    Clear Element Text    ${booking_locators.FIELD_BOOKING_PHONE}
    Input Text    ${booking_locators.FIELD_BOOKING_PHONE}    ${phone}
    Clear Element Text    ${booking_locators.FIELD_BOOKING_EMAIL}
    Input Text    ${booking_locators.FIELD_BOOKING_EMAIL}    ${email}

Submit Booking Form
    Wait Until Element Is Visible    ${booking_locators.BUTTON_CONFIRM_BOOKING}    ${TIMEOUT}
    Scroll Element Into View    ${booking_locators.BUTTON_CONFIRM_BOOKING}
    Click Element    ${booking_locators.BUTTON_CONFIRM_BOOKING}
