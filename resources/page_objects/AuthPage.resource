*** Settings ***
Library    SeleniumLibrary
Library    ../locators/AuthPageLocators.py    WITH NAME    auth_locators
Resource   ../common_variables.robot

*** Keywords ***
Open Login Page
    Go To    ${URL}/login
    Wait Until Page Contains    Đăng nhập    ${TIMEOUT}
    Wait Until Page Contains Element    ${auth_locators.FIELD_LOGIN_EMAIL}    ${TIMEOUT}

Open Register Page
    Go To    ${URL}/register
    Wait Until Page Contains    Đăng ký tài khoản    ${TIMEOUT}
    Wait Until Page Contains Element    ${auth_locators.FIELD_REGISTER_NAME}    ${TIMEOUT}

Type Login Email
    [Arguments]    ${email}
    Input Text    ${auth_locators.FIELD_LOGIN_EMAIL}    ${email}

Type Login Password
    [Arguments]    ${password}
    Input Text    ${auth_locators.FIELD_LOGIN_PASSWORD}    ${password}

Submit Login Form
    Click Element    ${auth_locators.BUTTON_LOGIN}

Type Register Form
    [Arguments]    ${name}    ${email}    ${phone}    ${password}    ${password_confirm}
    Input Text    ${auth_locators.FIELD_REGISTER_NAME}    ${name}
    Input Text    ${auth_locators.FIELD_REGISTER_EMAIL}    ${email}
    Input Text    ${auth_locators.FIELD_REGISTER_PHONE}    ${phone}
    Input Text    ${auth_locators.FIELD_REGISTER_PASSWORD}    ${password}
    Input Text    ${auth_locators.FIELD_REGISTER_PASSWORD_CONFIRM}    ${password_confirm}

Submit Register Form
    Click Element    ${auth_locators.BUTTON_REGISTER}
