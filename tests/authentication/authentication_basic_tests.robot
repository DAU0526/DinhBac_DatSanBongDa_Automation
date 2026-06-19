*** Settings ***
Documentation    Smoke Tests - Kiểm tra Đăng Nhập/Đăng Kí
Library          SeleniumLibrary
Resource         ../../resources/keywords/authentication_keywords.robot
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/variables/variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
TC_AUTH_SMOKE_01: Trang Đăng Nhập Hiển Thị Đúng
    [Documentation]    Kiểm tra trang đăng nhập có tất cả các trường
    [Tags]    smoke    auth
    Navigate To Login Page
    Page Should Contain    Email
    Page Should Contain    Mật khẩu
    Page Should Contain Element    ${BUTTON_LOGIN}

TC_AUTH_SMOKE_02: Trang Đăng Kí Hiển Thị Đúng
    [Documentation]    Kiểm tra trang đăng kí có tất cả các trường
    [Tags]    smoke    auth
    Navigate To Register Page
    Page Should Contain    Tên người dùng
    Page Should Contain    Email
    Page Should Contain    Mật khẩu
    Page Should Contain    Xác nhận mật khẩu
    Page Should Contain Element    ${BUTTON_REGISTER}

TC_AUTH_SMOKE_03: Có Thể Nhập Email Đăng Nhập
    [Documentation]    Kiểm tra input email trong form đăng nhập
    [Tags]    smoke    auth
    Navigate To Login Page
    Input Text    ${FIELD_LOGIN_EMAIL}    test@example.com
    Textfield Value Should Be    ${FIELD_LOGIN_EMAIL}    test@example.com

TC_AUTH_SMOKE_04: Có Thể Nhập Mật Khẩu Đăng Nhập
    [Documentation]    Kiểm tra input mật khẩu trong form đăng nhập
    [Tags]    smoke    auth
    Navigate To Login Page
    Input Text    ${FIELD_LOGIN_PASSWORD}    password123
    Textfield Value Should Be    ${FIELD_LOGIN_PASSWORD}    password123

TC_AUTH_SMOKE_05: Có Thể Nhập Thông Tin Đăng Kí
    [Documentation]    Kiểm tra input các trường trong form đăng kí
    [Tags]    smoke    auth
    Navigate To Register Page
    Input Text    ${FIELD_REGISTER_NAME}    testuser
    Input Text    ${FIELD_REGISTER_EMAIL}    newuser@example.com
    Input Text    ${FIELD_REGISTER_PASSWORD}    password123
    Input Text    ${FIELD_REGISTER_PASSWORD_CONFIRM}    password123
    Textfield Value Should Be    ${FIELD_REGISTER_NAME}    testuser

TC_AUTH_SMOKE_06: Nút Đăng Nhập Enabled
    [Documentation]    Kiểm tra nút đăng nhập có thể click
    [Tags]    smoke    auth
    Navigate To Login Page
    Element Should Be Enabled    ${BUTTON_LOGIN}

TC_AUTH_SMOKE_07: Nút Đăng Kí Enabled
    [Documentation]    Kiểm tra nút đăng kí có thể click
    [Tags]    smoke    auth
    Navigate To Register Page
    Element Should Be Enabled    ${BUTTON_REGISTER}

TC_AUTH_SMOKE_08: Có Thể Quay Lại Từ Trang Đăng Nhập
    [Documentation]    Kiểm tra có link quay lại trang chủ
    [Tags]    smoke    auth
    Navigate To Login Page
    Page Should Contain Element    xpath://a[contains(text(), 'Quay lại')]
