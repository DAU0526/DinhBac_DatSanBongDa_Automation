*** Settings ***
Library    SeleniumLibrary
Resource   ../config/environment.robot

*** Variables ***
${FIELD_BOOKING_NAME}           xpath=//input[@placeholder='Nguyễn Văn A']
${FIELD_BOOKING_PHONE}          xpath=//input[@placeholder='090 123 4567']
${FIELD_BOOKING_EMAIL}          xpath=//input[@type='email']
${FIELD_BOOKING_NOTE}           xpath=//textarea
${FIELD_SELECT_DATE}            xpath=//div[contains(@class,'fd-schedule-date')]
${FIELD_SELECT_TIME}            xpath=//span[contains(text(),'Chưa chọn')]
${BUTTON_CONFIRM_BOOKING}       xpath=//button[contains(.,'XÁC NHẬN ĐẶT SÂN')]
${MESSAGE_SUCCESS}              xpath=//*[contains(text(),'Đặt sân thành công')]
${MESSAGE_ERROR}                xpath://div[contains(@class, 'error') or contains(@class, 'alert-error') or contains(@class, 'text-red')]
${MODAL_DIALOG}                 xpath://div[contains(@role, 'dialog') or contains(@class, 'modal')]

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
