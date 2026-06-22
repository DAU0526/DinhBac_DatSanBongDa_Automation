*** Settings ***
Library    SeleniumLibrary
Variables    ../locators/BookingPageLocators.py
Resource   ../common_variables.robot

*** Keywords ***
Fill Booking Customer Form
    [Arguments]    ${name}    ${phone}    ${email}
    Wait Until Element Is Visible    ${FIELD_BOOKING_NAME}    ${TIMEOUT}
    Clear Element Text    ${FIELD_BOOKING_NAME}
    Input Text    ${FIELD_BOOKING_NAME}    ${name}
    Clear Element Text    ${FIELD_BOOKING_PHONE}
    Input Text    ${FIELD_BOOKING_PHONE}    ${phone}
    Clear Element Text    ${FIELD_BOOKING_EMAIL}
    Input Text    ${FIELD_BOOKING_EMAIL}    ${email}

Submit Booking Form
    Wait Until Element Is Visible    ${BUTTON_CONFIRM_BOOKING}    ${TIMEOUT}
    Scroll Element Into View    ${BUTTON_CONFIRM_BOOKING}
    Click Element    ${BUTTON_CONFIRM_BOOKING}
