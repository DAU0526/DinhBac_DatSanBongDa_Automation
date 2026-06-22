*** Settings ***
Documentation    Smoke Tests - Validation Đăng Nhập/Đăng Kí (Kiểm Tra Dữ Liệu Nhập Vào)
Library          SeleniumLibrary
Resource         ../../resources/keywords/authentication_keywords.robot
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/common_variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
TC_AUTH_VAL_01: Email Phải Có Format Hợp Lệ (Có @)
    [Documentation]    Kiểm tra email phải chứa @ để hợp lệ
    [Tags]    smoke    auth    validation
    Navigate To Login Page
    Test Email Format    test@example.com    ${TRUE}
    Login Email Should Be Valid    test@example.com

TC_AUTH_VAL_02: Email Không Hợp Lệ Khi Không Có @
    [Documentation]    Kiểm tra email không hợp lệ nếu không có @
    [Tags]    smoke    auth    validation
    Navigate To Login Page
    Clear And Enter Login Email    testexample.com
    Page Should Contain Element    xpath://input[@id='login-email' and @aria-invalid='true']

TC_AUTH_VAL_03: Email Không Hợp Lệ Khi Không Có Domain
    [Documentation]    Kiểm tra email phải có domain (.com, .vn, etc.)
    [Tags]    smoke    auth    validation
    Navigate To Login Page
    Clear And Enter Login Email    test@
    Page Should Contain Element    xpath://input[@id='login-email' and @aria-invalid='true']

TC_AUTH_VAL_04: Mật Khẩu Đăng Nhập Không Được Để Trống
    [Documentation]    Kiểm tra mật khẩu đăng nhập không được để trống
    [Tags]    smoke    auth    validation
    Navigate To Login Page
    Enter Login Email    test@example.com
    Enter Login Password    ${EMPTY}
    Click Login Button
    Page Should Contain    Mật khẩu không được để trống

TC_AUTH_VAL_05: Email Đăng Nhập Không Được Để Trống
    [Documentation]    Kiểm tra email đăng nhập không được để trống
    [Tags]    smoke    auth    validation
    Navigate To Login Page
    Enter Login Email    ${EMPTY}
    Enter Login Password    password123
    Click Login Button
    Page Should Contain    Email không được để trống

TC_AUTH_VAL_06: Username Đăng Kí Không Được Để Trống
    [Documentation]    Kiểm tra username đăng kí không được để trống
    [Tags]    smoke    auth    validation
    Navigate To Register Page
    Clear And Enter Register Username    ${EMPTY}
    Clear And Enter Register Email    test@example.com
    Page Should Contain    Tên người dùng không được để trống

TC_AUTH_VAL_07: Email Đăng Kí Không Được Để Trống
    [Documentation]    Kiểm tra email đăng kí không được để trống
    [Tags]    smoke    auth    validation
    Navigate To Register Page
    Clear And Enter Register Username    testuser
    Clear And Enter Register Email    ${EMPTY}
    Page Should Contain    Email không được để trống

TC_AUTH_VAL_08: Username Phải Có Độ Dài Tối Thiểu
    [Documentation]    Kiểm tra username phải ít nhất 3 ký tự
    [Tags]    smoke    auth    validation
    Navigate To Register Page
    Test Username Length    ab    3
    Page Should Contain    Tên người dùng quá ngắn

TC_AUTH_VAL_09: Mật Khẩu Phải Có Độ Dài Tối Thiểu
    [Documentation]    Kiểm tra mật khẩu phải ít nhất 6 ký tự
    [Tags]    smoke    auth    validation
    Navigate To Register Page
    Test Password Length    abc12    6
    Page Should Contain    Mật khẩu quá ngắn

TC_AUTH_VAL_10: Email Đăng Kí Phải Có Format Hợp Lệ
    [Documentation]    Kiểm tra email đăng kí phải chứa @ và domain
    [Tags]    smoke    auth    validation
    Navigate To Register Page
    Clear And Enter Register Email    invalidemail
    Page Should Contain Element    xpath://input[@id='register-email' and @aria-invalid='true']

TC_AUTH_VAL_11: Mật Khẩu Phải Xác Nhận Trùng Khớp
    [Documentation]    Kiểm tra mật khẩu và xác nhận mật khẩu phải giống nhau
    [Tags]    smoke    auth    validation
    Navigate To Register Page
    Clear And Enter Register Password    password123
    Clear And Enter Register Password Confirm    password456
    Click Register Button
    Page Should Contain    Mật khẩu không khớp

TC_AUTH_VAL_12: Username Không Được Chứa Ký Tự Đặc Biệt
    [Documentation]    Kiểm tra username không được chứa !, @, #, etc.
    [Tags]    smoke    auth    validation
    Navigate To Register Page
    Clear And Enter Register Username    test@user!
    Page Should Contain    Tên người dùng không được chứa ký tự đặc biệt

TC_AUTH_VAL_13: Email Phải Có Ký Tự @ Chỉ Một Lần
    [Documentation]    Kiểm tra email phải có @ chỉ một lần
    [Tags]    smoke    auth    validation
    Navigate To Login Page
    Clear And Enter Login Email    test@@example.com
    Page Should Contain Element    xpath://input[@id='login-email' and @aria-invalid='true']

TC_AUTH_VAL_14: Có Thể Nhập Số Điện Thoại Thay Vì Email (Nếu Support)
    [Documentation]    Kiểm tra có thể dùng số điện thoại để đăng nhập (nếu hỗ trợ)
    [Tags]    smoke    auth    validation
    Navigate To Login Page
    Clear And Enter Login Email    0912345678
    Textfield Value Should Be    ${FIELD_LOGIN_EMAIL}    0912345678

TC_AUTH_VAL_15: Mật Khẩu Phải Ẩn Khi Gõ
    [Documentation]    Kiểm tra ký tự mật khẩu phải ẩn (input type=password)
    [Tags]    smoke    auth    validation
    Navigate To Login Page
    Element Attribute Value Should Be    ${FIELD_LOGIN_PASSWORD}    type    password
