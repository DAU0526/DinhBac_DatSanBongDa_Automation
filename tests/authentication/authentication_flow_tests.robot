*** Settings ***
Documentation    Regression Tests - Kiểm tra Đăng Nhập/Đăng Kí
Library          SeleniumLibrary
Library          String
Resource         ../../resources/keywords/authentication_keywords.robot
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/common_variables.robot
Suite Setup     Init Test Environment
Suite Teardown   Close Browser Application
*** Test Cases ***
TC_AUTH_REG_01: Đăng Kí Thành Công Với Thông Tin Hợp Lệ
    [Documentation]    Kiểm tra đăng kí với thông tin hợp lệ
    [Tags]    regression    auth

    Register With Valid Data
    ...    ${RANDOM_USER}
    ...    ${RANDOM_EMAIL}
    ...    ${RANDOM_PHONE}
    ...    ${RANDOM_PASSWORD}

    Wait Until Page Contains    Đăng ký thành công    10s
    Wait Until Location Contains    /login    15s


TC_AUTH_REG_02: Đăng Nhập Thành Công Với Thông Tin Hợp Lệ
    [Documentation]    Kiểm tra đăng nhập bằng tài khoản vừa đăng ký
    [Tags]    regression    auth

    Login With Valid Credentials
    ...    ${RANDOM_EMAIL}
    ...    ${RANDOM_PASSWORD}

    Wait Until Page Contains    Xin chào    15s
    

TC_AUTH_REG_03: Sau Khi Đăng Nhập Có Thể Đặt Sân
    [Documentation]    Kiểm tra user đã đăng nhập có thể đặt sân
    [Tags]    regression    auth

    Login With Valid Credentials
...    ${RANDOM_EMAIL}
...    ${RANDOM_PASSWORD}

    Wait Until Page Contains    Xin chào    15s

    Navigate To Booking Page

    Wait Until Location Contains    /booking    10s
    Wait Until Page Contains    Thông tin khách hàng    10s


TC_AUTH_REG_04: Đăng Xuất Thành Công
    [Documentation]    Kiểm tra đăng xuất hoạt động đúng
    [Tags]    regression    auth

    Login With Valid Credentials
    ...    ${RANDOM_EMAIL}
    ...    ${RANDOM_PASSWORD}

   

    Logout
    Wait Until Page Contains    Đăng nhập    10s
    Wait Until Location Contains    /login    10s

TC_AUTH_REG_05: Đăng Nhập Thất Bại Khi Email Sai
    [Documentation]    Kiểm tra thông báo lỗi khi email sai
    [Tags]    regression    auth

    Navigate To Login Page
    Enter Login Email    wrong@example.com
    Enter Login Password    password123
    Click Login Button

    Login Should Fail With Error    Tài khoản không tồn tại
    


TC_AUTH_REG_06: Đăng Nhập Thất Bại Khi Mật Khẩu Sai
    [Documentation]    Kiểm tra thông báo lỗi khi mật khẩu sai
    [Tags]    regression    auth

    Navigate To Login Page
    Enter Login Email    ${RANDOM_EMAIL}
    Enter Login Password    wrongpassword
    Click Login Button

    Login Should Fail With Error    Email hoặc mật khẩu không đúng


TC_AUTH_REG_07: Đăng Nhập Thất Bại Khi Để Trống Email
    [Documentation]    Kiểm tra thông báo lỗi khi email trống
    [Tags]    regression    auth

    Navigate To Login Page
    Enter Login Password    ${RANDOM_PASSWORD}
    Click Login Button

    Login Should Fail With Error    Thiếu dữ liệu


TC_AUTH_REG_08: Đăng Nhập Thất Bại Khi Để Trống Mật Khẩu
    [Documentation]    Kiểm tra thông báo lỗi khi mật khẩu trống
    [Tags]    regression    auth

    Navigate To Login Page
    Enter Login Email    ${RANDOM_EMAIL}
    Click Login Button

    Login Should Fail With Error    Thiếu dữ liệu


TC_AUTH_REG_09: Đăng Kí Thất Bại Khi Email Đã Tồn Tại
    [Documentation]    Kiểm tra thông báo lỗi khi email đã đăng kí
    [Tags]    regression    auth

    Navigate To Register Page

    Fill Register Form
    ...    user2
    ...    ${RANDOM_EMAIL}
    ...    ${RANDOM_PHONE}
    ...    ${RANDOM_PASSWORD}
    ...    ${RANDOM_PASSWORD}

    Click Register Button

    Register Should Fail With Error    Email này đã được đăng kí
   


TC_AUTH_REG_10: Đăng Kí Thất Bại Khi Mật Khẩu Không Khớp
    [Documentation]    Kiểm tra thông báo lỗi khi mật khẩu không khớp
    [Tags]    regression    auth

    Navigate To Register Page

    Fill Register Form
    ...    ${RANDOM_USER}
    ...    abc@test.com
    ...    ${RANDOM_PHONE}
    ...    ${RANDOM_PASSWORD}
    ...    password456

    Click Register Button

    Register Should Fail With Error    Mật khẩu không khớp
    


TC_AUTH_REG_11: Đăng Kí Thất Bại Khi Email Không Hợp Lệ
    [Documentation]    Kiểm tra thông báo lỗi khi email không đúng format
    [Tags]    regression    auth

    Navigate To Register Page

    Fill Register Form
    ...    ${RANDOM_USER}
    ...    invalid-email
    ...    ${RANDOM_PHONE}
    ...    ${RANDOM_PASSWORD}
    ...    ${RANDOM_PASSWORD}

    Click Register Button

    Register Should Fail With Error    Email không hợp lệ
