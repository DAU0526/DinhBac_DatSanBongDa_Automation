*** Settings ***
Library    SeleniumLibrary
Resource   ../config/environment.robot

*** Variables ***
${LOOKUP_INPUT}                 css=input.input-field
${LOOKUP_BUTTON}                css=button.btn-lookup-now
${LOOKUP_RESULT_SUCCESS}        xpath=//*[contains(@class,'lookup-result') or contains(@class,'result-card') or contains(@class,'booking-result') or contains(@class,'order-detail')]
${LOOKUP_RESULT_NOT_FOUND}      xpath=//*[contains(text(),'không tìm thấy') or contains(text(),'Không tìm thấy') or contains(text(),'không tồn tại') or contains(@class,'not-found') or contains(@class,'error-msg')]

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
