*** Settings ***
Library    SeleniumLibrary
Resource   ../config/environment.robot

*** Variables ***
${FIELD_LOGIN_EMAIL}            xpath://input[@placeholder='name@example.com']
${FIELD_LOGIN_PASSWORD}         xpath://input[@placeholder='Nhập mật khẩu']
${BUTTON_LOGIN}                 xpath://button[contains(@class, 'login-button')]
${BUTTON_GOOGLE_LOGIN}          xpath://button[contains(@class, 'google-login')]
${BUTTON_FACEBOOK_LOGIN}        xpath://button[contains(@class, 'facebook-login')]
${LINK_REGISTER}                xpath://a[@href='/register']

${FIELD_REGISTER_NAME}                 xpath://input[@id='fullname']
${FIELD_REGISTER_USERNAME}             ${FIELD_REGISTER_NAME}
${FIELD_REGISTER_EMAIL}                xpath://input[@id='email']
${FIELD_REGISTER_PHONE}                xpath://input[@id='phone']
${FIELD_REGISTER_PASSWORD}             xpath://input[@id='password']
${FIELD_REGISTER_PASSWORD_CONFIRM}     xpath://input[@id='confirmPassword']
${BUTTON_REGISTER}                     xpath://button[@type='submit']
${LINK_LOGIN}                          xpath://a[@href='/login']

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
