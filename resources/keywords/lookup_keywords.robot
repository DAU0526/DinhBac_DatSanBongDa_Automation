*** Settings ***
Library    SeleniumLibrary
Resource   ../config/environment.robot
Resource   ../testdata/booking_data.robot
Resource   ../pages/base_page.robot
Resource   ../pages/auth_page.robot
Resource   ../pages/lookup_page.robot

*** Keywords ***

# ========================= NAVIGATION =========================
Navigate To Lookup Page
    [Documentation]    Điều hướng trực tiếp tới trang Tra cứu đơn đặt sân
    Go To    ${URL}/lookup
    Sleep    2s
    Wait Until Element Is Visible    ${LOOKUP_INPUT}    ${TIMEOUT}

Navigate To Lookup Via Nav
    [Documentation]    Điều hướng tới trang Tra cứu qua menu điều hướng
    Wait Until Element Is Visible    ${NAV_LOOKUP}    ${TIMEOUT}
    Click Element    ${NAV_LOOKUP}
    Sleep    2s
    Wait Until Element Is Visible    ${LOOKUP_INPUT}    ${TIMEOUT}

# ========================= LOGIN HELPER =========================
Login For Lookup Test
    [Documentation]    Đăng nhập bằng tài khoản 04858758475 / 12345 để test tra cứu
    Go To    ${URL}/login
    Wait Until Page Contains    Đăng nhập    ${TIMEOUT}
    Wait Until Element Is Visible    ${FIELD_LOGIN_EMAIL}    ${TIMEOUT}
    Input Text    ${FIELD_LOGIN_EMAIL}    ${BOOKING_HISTORY_PHONE}
    Input Text    ${FIELD_LOGIN_PASSWORD}    ${BOOKING_HISTORY_PASSWORD}
    Click Element    ${BUTTON_LOGIN}
    Sleep    3s

# ========================= LOOKUP PAGE - ELEMENT CHECKS =========================
Lookup Page Should Be Displayed
    [Documentation]    Kiểm tra trang Tra cứu hiển thị đúng
    Location Should Contain    lookup
    Element Should Be Visible    ${LOOKUP_INPUT}
    Element Should Be Visible    ${LOOKUP_BUTTON}

Input Field Should Be Visible And Enabled
    [Documentation]    Kiểm tra ô nhập mã đặt sân hiển thị và sẵn sàng nhập
    Element Should Be Visible    ${LOOKUP_INPUT}
    Element Should Be Enabled    ${LOOKUP_INPUT}

Input Field Placeholder Should Be Correct
    [Documentation]    Kiểm tra placeholder của ô nhập mã là "VD: BK123456"
    ${placeholder}=    Get Element Attribute    ${LOOKUP_INPUT}    placeholder
    Should Be Equal    ${placeholder}    VD: BK123456

Lookup Button Should Be Visible And Enabled
    [Documentation]    Kiểm tra nút "Tra cứu ngay" hiển thị và có thể click
    Element Should Be Visible    ${LOOKUP_BUTTON}
    Element Should Be Enabled    ${LOOKUP_BUTTON}

Lookup Button Should Have Search Icon
    [Documentation]    Kiểm tra nút Tra cứu có icon search
    Page Should Contain Element    css=button.btn-lookup-now span.material-symbols-outlined

# ========================= LOOKUP ACTIONS =========================
Enter Booking Code
    [Arguments]    ${booking_code}
    [Documentation]    Nhập mã đặt sân vào ô tra cứu
    Wait Until Element Is Visible    ${LOOKUP_INPUT}    ${TIMEOUT}
    Clear Element Text    ${LOOKUP_INPUT}
    Input Text    ${LOOKUP_INPUT}    ${booking_code}
    ${value}=    Get Value    ${LOOKUP_INPUT}
    Should Be Equal    ${value}    ${booking_code}
    Log    Đã nhập mã tra cứu: ${booking_code}

Clear Booking Code Input
    [Documentation]    Xóa nội dung ô nhập mã
    Clear Element Text    ${LOOKUP_INPUT}
    ${value}=    Get Value    ${LOOKUP_INPUT}
    Should Be Empty    ${value}

Click Lookup Button
    [Documentation]    Nhấn nút "Tra cứu ngay"
    Wait Until Element Is Visible    ${LOOKUP_BUTTON}    ${TIMEOUT}
    Click Element    ${LOOKUP_BUTTON}
    Sleep    2s

Lookup Booking Code
    [Arguments]    ${booking_code}
    [Documentation]    Nhập mã đặt sân và nhấn tra cứu
    Enter Booking Code    ${booking_code}
    Click Lookup Button

# ========================= RESULT VERIFICATION =========================
Lookup Should Show Result
    [Documentation]    Kiểm tra có kết quả tra cứu hiển thị (dù tìm thấy hay không)
    Sleep    2s
    ${found_result}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${LOOKUP_RESULT_SUCCESS}
    ${found_not_found}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${LOOKUP_RESULT_NOT_FOUND}
    ${has_any_response}=    Evaluate    ${found_result} or ${found_not_found}
    Should Be True    ${has_any_response}
    ...    msg=Sau khi tra cứu không có kết quả hoặc thông báo nào hiển thị

Lookup Should Show Not Found Message
    [Documentation]    Kiểm tra thông báo "không tìm thấy" khi mã không tồn tại
    Sleep    2s
    Element Should Be Visible    ${LOOKUP_RESULT_NOT_FOUND}
    Log    Hệ thống hiển thị thông báo không tìm thấy đúng như mong đợi

Lookup With Valid Code Should Show Result
    [Arguments]    ${booking_code}
    [Documentation]    Tra cứu với mã hợp lệ và kiểm tra có kết quả
    Lookup Booking Code    ${booking_code}
    Lookup Should Show Result

Lookup With Invalid Code Should Show Not Found
    [Arguments]    ${booking_code}
    [Documentation]    Tra cứu với mã không tồn tại và kiểm tra thông báo lỗi
    Lookup Booking Code    ${booking_code}
    Lookup Should Show Not Found Message

Input Field Value Should Be
    [Arguments]    ${expected_value}
    [Documentation]    Kiểm tra giá trị hiện tại trong ô nhập mã
    ${actual}=    Get Value    ${LOOKUP_INPUT}
    Should Be Equal    ${actual}    ${expected_value}
    Log    Giá trị ô nhập: ${actual}

Can Input Booking Code
    [Arguments]    ${booking_code}
    [Documentation]    Kiểm tra có thể nhập mã vào ô input
    Enter Booking Code    ${booking_code}
    Input Field Value Should Be    ${booking_code}

Press Enter To Lookup
    [Documentation]    Nhấn Enter thay vì click nút để tra cứu
    Press Keys    ${LOOKUP_INPUT}    RETURN
    Sleep    2s
