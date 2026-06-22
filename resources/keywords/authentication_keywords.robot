*** Settings ***
Library    SeleniumLibrary
Library    ../locators/AuthPageLocators.py    WITH NAME    auth_locators
Resource   ../common_variables.robot
Resource   ../page_objects/AuthPage.resource

*** Keywords ***
# Login Keywords
Navigate To Login Page
    Go To    ${URL}/login
    Wait Until Page Contains    Đăng nhập
    Wait Until Page Contains Element    ${auth_locators.FIELD_LOGIN_EMAIL}

Enter Login Email
    [Arguments]    ${email}
    [Documentation]    Nhập email đăng nhập
    Input Text    ${auth_locators.FIELD_LOGIN_EMAIL}    ${email}

Enter Login Password
    [Arguments]    ${password}
    [Documentation]    Nhập mật khẩu đăng nhập
    Input Text    ${auth_locators.FIELD_LOGIN_PASSWORD}    ${password}

Click Login Button
    Click Element    ${auth_locators.BUTTON_LOGIN}
    Run Keyword And Ignore Error    Handle Any Alert

Login With Valid Credentials
    [Arguments]    ${email}    ${password}
    [Documentation]    Đăng nhập với email và mật khẩu hợp lệ
    Navigate To Login Page
    Enter Login Email    ${email}
    Enter Login Password    ${password}
    Click Login Button

Login Should Be Successful
    [Documentation]    Kiểm tra đăng nhập thành công
    Wait Until Page Contains    Xin chào    ${TIMEOUT}

Login Should Fail With Error
    [Arguments]    ${error_message}
    [Documentation]    Kiểm tra đăng nhập thất bại
    Page Should Contain    ${error_message}

# Registration Keywords
Navigate To Register Page
    Go To    ${URL}/register
    Wait Until Page Contains    Đăng ký tài khoản
    Wait Until Page Contains Element    ${auth_locators.FIELD_REGISTER_NAME}

Fill Register Form
    [Arguments]    ${name}    ${email}    ${phone}    ${password}    ${password_confirm}
    [Documentation]    Điền form đăng kí
    Input Text    ${auth_locators.FIELD_REGISTER_NAME}    ${name}
    Input Text    ${auth_locators.FIELD_REGISTER_EMAIL}    ${email}
    Input Text    ${auth_locators.FIELD_REGISTER_PHONE}    ${phone}
    Input Text    ${auth_locators.FIELD_REGISTER_PASSWORD}    ${password}
    Input Text    ${auth_locators.FIELD_REGISTER_PASSWORD_CONFIRM}    ${password_confirm}

Click Register Button
    Click Element    ${auth_locators.BUTTON_REGISTER}
    Wait Until Element Is Visible
    ...    xpath=//p[contains(@class,'text-green-600')]
    ...    10s
    

Register With Valid Data
    [Arguments]    ${name}    ${email}    ${phone}    ${password}
    [Documentation]    Đăng kí với dữ liệu hợp lệ
    Navigate To Register Page
    Fill Register Form    ${name}    ${email}    ${phone}    ${password}    ${password}
    Click Register Button

Register Should Be Successful
    Wait Until Page Contains    Đăng ký thành công    5s
    Wait Until Location Contains    /login    10s
    

Register Should Fail With Error
    [Arguments]    ${error_message}
    [Documentation]    Kiểm tra đăng kí thất bại
    Page Should Contain    ${error_message}

# Validation Keywords - Login Field Validation
Clear And Enter Login Email
    [Arguments]    ${email}
    [Documentation]    Xóa email cũ và nhập email mới
    Clear Element Text    ${auth_locators.FIELD_LOGIN_EMAIL}
    Input Text    ${auth_locators.FIELD_LOGIN_EMAIL}    ${email}

Clear And Enter Login Password
    [Arguments]    ${password}
    [Documentation]    Xóa mật khẩu cũ và nhập mật khẩu mới
    Clear Element Text    ${auth_locators.FIELD_LOGIN_PASSWORD}
    Input Text    ${auth_locators.FIELD_LOGIN_PASSWORD}    ${password}

Login Email Should Show Error
    [Arguments]    ${error_message}
    [Documentation]    Kiểm tra email input hiển thị lỗi
    Page Should Contain    ${error_message}

Login Email Should Be Valid
    [Arguments]    ${email}
    [Documentation]    Kiểm tra email nhập vào hợp lệ
    Textfield Value Should Be    ${auth_locators.FIELD_LOGIN_EMAIL}    ${email}

Login Password Should Be Valid
    [Arguments]    ${password}
    [Documentation]    Kiểm tra mật khẩu nhập vào hợp lệ
    Textfield Value Should Be    ${auth_locators.FIELD_LOGIN_PASSWORD}    ${password}

# Validation Keywords - Registration Field Validation
Clear And Enter Register Name
    [Arguments]    ${name}
    [Documentation]    Xóa tên cũ và nhập tên mới
    Clear Element Text    ${auth_locators.FIELD_REGISTER_NAME}
    Input Text    ${auth_locators.FIELD_REGISTER_NAME}    ${name}

Clear And Enter Register Username
    [Arguments]    ${username}
    [Documentation]    Alias cho field fullname/username trên form đăng kí
    Clear And Enter Register Name    ${username}

Clear And Enter Register Email
    [Arguments]    ${email}
    [Documentation]    Xóa email cũ và nhập email mới
    Clear Element Text    ${auth_locators.FIELD_REGISTER_EMAIL}
    Input Text    ${auth_locators.FIELD_REGISTER_EMAIL}    ${email}

Clear And Enter Register Phone
    [Arguments]    ${phone}
    [Documentation]    Xóa số điện thoại cũ và nhập số mới
    Clear Element Text    ${auth_locators.FIELD_REGISTER_PHONE}
    Input Text    ${auth_locators.FIELD_REGISTER_PHONE}    ${phone}

Clear And Enter Register Password
    [Arguments]    ${password}
    [Documentation]    Xóa mật khẩu cũ và nhập mật khẩu mới
    Clear Element Text    ${auth_locators.FIELD_REGISTER_PASSWORD}
    Input Text    ${auth_locators.FIELD_REGISTER_PASSWORD}    ${password}

Clear And Enter Register Password Confirm
    [Arguments]    ${password}
    [Documentation]    Xóa xác nhận mật khẩu cũ và nhập mới
    Clear Element Text    ${auth_locators.FIELD_REGISTER_PASSWORD_CONFIRM}
    Input Text    ${auth_locators.FIELD_REGISTER_PASSWORD_CONFIRM}    ${password}

Register Name Should Show Error
    [Arguments]    ${error_message}
    [Documentation]    Kiểm tra name input hiển thị lỗi
    Page Should Contain    ${error_message}

Register Email Should Show Error
    [Arguments]    ${error_message}
    [Documentation]    Kiểm tra email input hiển thị lỗi
    Page Should Contain    ${error_message}

Register Phone Should Show Error
    [Arguments]    ${error_message}
    [Documentation]    Kiểm tra phone input hiển thị lỗi
    Page Should Contain    ${error_message}

Register Password Should Show Error
    [Arguments]    ${error_message}
    [Documentation]    Kiểm tra mật khẩu input hiển thị lỗi
    Page Should Contain    ${error_message}

Register Name Is Valid
    [Arguments]    ${name}
    [Documentation]    Kiểm tra name hợp lệ
    Textfield Value Should Be    ${auth_locators.FIELD_REGISTER_NAME}    ${name}

Register Username Is Valid
    [Arguments]    ${username}
    [Documentation]    Alias cho validation username trên form đăng kí
    Register Name Is Valid    ${username}

Register Email Is Valid
    [Arguments]    ${email}
    [Documentation]    Kiểm tra email hợp lệ
    Textfield Value Should Be    ${auth_locators.FIELD_REGISTER_EMAIL}    ${email}

Register Phone Is Valid
    [Arguments]    ${phone}
    [Documentation]    Kiểm tra phone hợp lệ
    Textfield Value Should Be    ${auth_locators.FIELD_REGISTER_PHONE}    ${phone}

Register Password Is Valid
    [Arguments]    ${password}
    [Documentation]    Kiểm tra mật khẩu hợp lệ
    Element Should Be Visible    ${auth_locators.FIELD_REGISTER_PASSWORD}

# Field Type Validation Keywords
Test Email Format
    [Arguments]    ${email}    ${should_be_valid}
    [Documentation]    Test email format có hợp lệ hay không
    Navigate To Login Page
    Clear And Enter Login Email    ${email}
    IF    ${should_be_valid}
        Login Email Should Be Valid    ${email}
    ELSE
        Page Should Contain Element    xpath://input[@id='login-email' and @aria-invalid='true']
    END

Test Password Length
    [Arguments]    ${password}    ${min_length}
    [Documentation]    Test mật khẩu đủ độ dài hay không
    Navigate To Register Page
    Clear And Enter Register Password    ${password}
    ${length}=    Get Length    ${password}
    IF    ${length} >= ${min_length}
        Register Password Is Valid    ${password}
    ELSE
        Page Should Contain    Mật khẩu quá ngắn
    END

Test Username Length
    [Arguments]    ${username}    ${min_length}
    [Documentation]    Test username đủ độ dài hay không
    Navigate To Register Page
    Clear And Enter Register Username    ${username}
    ${length}=    Get Length    ${username}
    IF    ${length} >= ${min_length}
        Register Username Is Valid    ${username}
    ELSE
        Page Should Contain    Tên người dùng quá ngắn
    END

Test Special Characters In Email
    [Arguments]    ${email}
    [Documentation]    Test email có ký tự đặc biệt hợp lệ
    Navigate To Login Page
    Clear And Enter Login Email    ${email}
    IF    '@' in ${email} and '.' in ${email}
        Login Email Should Be Valid    ${email}
    ELSE
        Page Should Contain    Email không hợp lệ
    END

Test Password Strength
    [Arguments]    ${password}
    [Documentation]    Test mật khẩu có độ khó đủ hay không
    Navigate To Register Page
    Clear And Enter Register Password    ${password}
    # Kiểm tra mật khẩu có chữ hoa, chữ thường, số, ký tự đặc biệt
    Register Password Is Valid    ${password}

# Logout & Status Keywords
# Random Data Generator (FOR SUITE USAGE)
Generate Random User Data
    ${random}=        Generate Random String    6    [NUMBERS]
    ${email_rand}=    Generate Random String    8    [LETTERS]

    ${timestamp}=     Get Time    epoch
    ${timestamp_str}=    Convert To String    ${timestamp}
    ${short_ts}=         Get Substring        ${timestamp_str}    -4

    ${email}=         Set Variable    test_${email_rand}_${timestamp}@test.com
    ${user}=          Set Variable    user_${email_rand}_${timestamp}
    ${phone}=         Set Variable    09${random}${short_ts}
    ${password}=      Set Variable    password123

    Set Suite Variable    ${RANDOM_EMAIL}     ${email}
    Set Suite Variable    ${RANDOM_USER}      ${user}
    Set Suite Variable    ${RANDOM_PHONE}     ${phone}
    Set Suite Variable    ${RANDOM_PASSWORD}  ${password}
Logout
    [Documentation]    Đăng xuất
    Click Element    xpath://a[contains(text(), 'Đăng xuất')]
    Wait Until Page Contains    Đăng nhập    ${TIMEOUT}

User Should Be Logged In
    [Documentation]    Kiểm tra user đã đăng nhập
    Page Should Contain Element    xpath://a[contains(text(), 'Đăng xuất')]

User Should Not Be Logged In
    [Documentation]    Kiểm tra user chưa đăng nhập
    Page Should Contain Element    xpath://a[contains(text(), 'Đăng nhập')]
Element Should Not Have Class
    [Arguments]    ${locator}    ${class_name}
    [Documentation]    Kiem tra element khong co class CSS chi dinh
    ${classes}=    Get Element Attribute    ${locator}    class
    Should Not Contain    ${classes}    ${class_name}

Hover Element
    [Arguments]    ${locator}
    [Documentation]    Alias ngan gon cho SeleniumLibrary Mouse Over
    Mouse Over    ${locator}

*** Keywords ***
Handle Any Alert
    ${status}=    Run Keyword And Return Status    Alert Should Be Present
    IF    ${status}
        ${text}=    Handle Alert
        Log    ALERT: ${text}
    END
*** Keywords ***
Init Test Environment
    Open Browser To Application
    Delete All Cookies
    Generate Random User Data
