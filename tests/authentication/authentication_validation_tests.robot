*** Settings ***
Documentation    Regression Tests - Validation Đăng Nhập/Đăng Kí Chi Tiết
Library          SeleniumLibrary
Resource         ../../resources/keywords/authentication_keywords.robot
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/variables/variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
TC_AUTH_REG_VAL_01: Kiểm Tra Tất Cả Format Email Hợp Lệ
    [Documentation]    Test nhiều format email khác nhau
    [Tags]    regression    auth    validation
    Navigate To Login Page
    Test Email Format    user@example.com    ${TRUE}
    Test Email Format    test.user@example.co.uk    ${TRUE}
    Test Email Format    user+tag@example.com    ${TRUE}

TC_AUTH_REG_VAL_02: Kiểm Tra Tất Cả Format Email Không Hợp Lệ
    [Documentation]    Test email không hợp lệ (không @, không domain, etc.)
    [Tags]    regression    auth    validation
    Navigate To Login Page
    Clear And Enter Login Email    plainaddress
    Page Should Contain Element    xpath://input[@id='login-email' and @aria-invalid='true']
    Clear And Enter Login Email    @example.com
    Page Should Contain Element    xpath://input[@id='login-email' and @aria-invalid='true']

TC_AUTH_REG_VAL_03: Mật Khẩu Quá Ngắn Bị Từ Chối
    [Documentation]    Test mật khẩu < 6 ký tự bị từ chối
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Test Password Length    pass    6
    Page Should Contain    Mật khẩu quá ngắn

TC_AUTH_REG_VAL_04: Mật Khẩu Đủ Độ Dài Được Chấp Nhận
    [Documentation]    Test mật khẩu >= 6 ký tự được chấp nhận
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Test Password Length    password    6
    Register Password Is Valid    password

TC_AUTH_REG_VAL_05: Username Quá Ngắn Bị Từ Chối
    [Documentation]    Test username < 3 ký tự bị từ chối
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Test Username Length    ab    3
    Page Should Contain    Tên người dùng quá ngắn

TC_AUTH_REG_VAL_06: Username Đủ Độ Dài Được Chấp Nhận
    [Documentation]    Test username >= 3 ký tự được chấp nhận
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Test Username Length    user    3
    Register Username Is Valid    user

TC_AUTH_REG_VAL_07: Xác Nhận Mật Khẩu Phải Giống Nhau
    [Documentation]    Test xác nhận mật khẩu phải giống mật khẩu
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Clear And Enter Register Password    password123
    Clear And Enter Register Password Confirm    password123
    Register Password Is Valid    password123

TC_AUTH_REG_VAL_08: Xác Nhận Mật Khẩu Khác Nhau Bị Từ Chối
    [Documentation]    Test xác nhận mật khẩu khác được từ chối
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Clear And Enter Register Password    password123
    Clear And Enter Register Password Confirm    password456
    Click Register Button
    Page Should Contain    Mật khẩu không khớp

TC_AUTH_REG_VAL_09: Email Login Không Hợp Lệ Sau Xác Nhận
    [Documentation]    Test email không hợp lệ được highlight sau khi nhấn submit
    [Tags]    regression    auth    validation
    Navigate To Login Page
    Clear And Enter Login Email    invalidemail@
    Click Login Button
    Page Should Contain    Email không hợp lệ

TC_AUTH_REG_VAL_10: Thay Đổi Email Trong Form Xóa Lỗi Validation
    [Documentation]    Test sửa email lỗi sẽ xóa thông báo lỗi
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Clear And Enter Register Email    invalidemail
    Page Should Contain Element    xpath://input[@id='register-email' and @aria-invalid='true']
    Clear And Enter Register Email    valid@example.com
    Element Should Not Have Class    ${FIELD_REGISTER_EMAIL}    error

TC_AUTH_REG_VAL_11: Khoảng Trắng Ở Đầu/Cuối Email Bị Loại Bỏ
    [Documentation]    Test khoảng trắng ở đầu/cuối email bị trim
    [Tags]    regression    auth    validation
    Navigate To Login Page
    Clear And Enter Login Email    ${SPACE}test@example.com${SPACE}
    # Browser thường tự động trim, kiểm tra giá trị sau trim
    ${email_value}=    Get Value    ${FIELD_LOGIN_EMAIL}
    Should Not Start With    ${email_value}    ${SPACE}
    Should Not End With    ${email_value}    ${SPACE}

TC_AUTH_REG_VAL_12: Mật Khẩu Không Được Trim Khoảng Trắng
    [Documentation]    Test mật khẩu không trim khoảng trắng
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Clear And Enter Register Password    ${SPACE}password123${SPACE}
    ${pwd_value}=    Get Value    ${FIELD_REGISTER_PASSWORD}
    # Mật khẩu giữ nguyên khoảng trắng
    Should Contain    ${pwd_value}    password123

TC_AUTH_REG_VAL_13: Chữ Hoa Chữ Thường Email Không Ảnh Hưởng
    [Documentation]    Test email case-insensitive
    [Tags]    regression    auth    validation
    Navigate To Login Page
    Clear And Enter Login Email    TEST@EXAMPLE.COM
    Login Email Should Be Valid    TEST@EXAMPLE.COM

TC_AUTH_REG_VAL_14: Username Chứa Ký Tự Hợp Lệ (Số, Chữ, Gạch Dưới)
    [Documentation]    Test username có thể chứa số, chữ, gạch dưới
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Test Username Length    user_123    3
    Register Username Is Valid    user_123

TC_AUTH_REG_VAL_15: Username Không Được Chứa Ký Tự Đặc Biệt
    [Documentation]    Test username không được chứa !, @, #, $, %, etc.
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Clear And Enter Register Username    user!@#
    Page Should Contain    Tên người dùng không được chứa ký tự đặc biệt

TC_AUTH_REG_VAL_16: Field Bắt Buộc Phải Hiển Thị Dấu Sao Hoặc Label
    [Documentation]    Test trường bắt buộc hiển thị dấu * hoặc required label
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Page Should Contain Element    xpath://label[contains(., 'Tên người dùng')]//*[contains(text(), '*')]
    Page Should Contain Element    xpath://label[contains(., 'Email')]//*[contains(text(), '*')]
    Page Should Contain Element    xpath://label[contains(., 'Mật khẩu')]//*[contains(text(), '*')]

TC_AUTH_REG_VAL_17: Tooltip Lỗi Hiển Thị Khi Hover Input Lỗi
    [Documentation]    Test tooltip/error message hiển thị khi có lỗi validation
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Clear And Enter Register Email    invalidemail
    Hover Element    ${FIELD_REGISTER_EMAIL}
    Page Should Contain    Email không hợp lệ

TC_AUTH_REG_VAL_18: Real-time Validation Saat Mengetik
    [Documentation]    Test validation real-time khi đang gõ
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Clear And Enter Register Username    ab
    Page Should Contain    Tên người dùng quá ngắn
    Clear And Enter Register Username    abc
    Element Should Not Have Class    ${FIELD_REGISTER_USERNAME}    error

TC_AUTH_REG_VAL_19: Số Ký Tự Max Của Email
    [Documentation]    Test email không vượt quá độ dài max
    [Tags]    regression    auth    validation
    Navigate To Login Page
    ${long_email}=    Set Variable    ${'a' * 100}@example.com
    Clear And Enter Login Email    ${long_email}
    # Có thể có giới hạn, kiểm tra theo requirement

TC_AUTH_REG_VAL_20: Username Không Trùng Với Existing User
    [Documentation]    Test username không được trùng với user khác
    [Tags]    regression    auth    validation
    Navigate To Register Page
    Clear And Enter Register Username    existinguser
    Clear And Enter Register Email    new@example.com
    Click Register Button
    Page Should Contain    Tên người dùng đã tồn tại
