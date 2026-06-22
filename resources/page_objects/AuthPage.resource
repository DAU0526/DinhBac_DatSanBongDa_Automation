*** Settings ***
Library    SeleniumLibrary
Variables    ../locators/AuthPageLocators.py
Resource   ../common_variables.robot

*** Keywords ***
Open Login Page
    Go To    ${URL}/login
    Wait Until Page Contains    Đăng nhập    ${TIMEOUT}
    Wait Until Page Contains Element    ${FIELD_LOGIN_EMAIL}    ${TIMEOUT}

Open Register Page
    Go To    ${URL}/register
    Wait Until Page Contains    Đăng ký tài khoản    ${TIMEOUT}
    Wait Until Page Contains Element    ${FIELD_REGISTER_NAME}    ${TIMEOUT}

Type Login Email
    [Arguments]    ${email}
    Input Text    ${FIELD_LOGIN_EMAIL}    ${email}

Type Login Password
    [Arguments]    ${password}
    Input Text    ${FIELD_LOGIN_PASSWORD}    ${password}

Submit Login Form
    Click Element    ${BUTTON_LOGIN}

Type Register Form
    [Arguments]    ${name}    ${email}    ${phone}    ${password}    ${password_confirm}
    Input Text    ${FIELD_REGISTER_NAME}    ${name}
    Input Text    ${FIELD_REGISTER_EMAIL}    ${email}
    Input Text    ${FIELD_REGISTER_PHONE}    ${phone}
    Input Text    ${FIELD_REGISTER_PASSWORD}    ${password}
    Input Text    ${FIELD_REGISTER_PASSWORD_CONFIRM}    ${password_confirm}

Submit Register Form
    Click Element    ${BUTTON_REGISTER}
