*** Settings ***
Documentation       Smoke Tests - Tra cứu đơn đặt sân
...                 Luồng: Mở website → Đăng nhập (04858758475/12345) → Vào trang Tra cứu
...                 → Nhập mã sân → Nhấn nút Tra cứu ngay → Kiểm tra kết quả
Library             SeleniumLibrary
Resource            ../../resources/keywords/lookup_keywords.robot
Resource            ../../resources/keywords/booking_keywords.robot
Resource            ../../resources/variables/variables.robot

Suite Setup         Open Browser To Application
Suite Teardown      Close Browser Application

*** Test Cases ***

TC_LOOKUP_SMOKE_01: Mở Website Thành Công
    [Documentation]    Kiểm tra website mở được và trang chủ hiển thị
    [Tags]    smoke    lookup    website
    Wait Until Page Contains    Football Booking    ${TIMEOUT}
    Capture Page Screenshot

TC_LOOKUP_SMOKE_02: Đăng Nhập Bằng Tài Khoản 04858758475
    [Documentation]    Đăng nhập với SĐT 04858758475 / mật khẩu 12345
    [Tags]    smoke    lookup    login
    Login For Lookup Test
    ${url}=    Get Location
    Should Not Contain    ${url}    /login
    Capture Page Screenshot

TC_LOOKUP_SMOKE_03: Điều Hướng Tới Trang Tra Cứu
    [Documentation]    Vào trang /lookup sau khi đăng nhập
    [Tags]    smoke    lookup    navigation
    Navigate To Lookup Page
    Lookup Page Should Be Displayed
    Capture Page Screenshot

TC_LOOKUP_SMOKE_04: Ô Nhập Mã Sân Hiển Thị Và Sẵn Sàng Nhập
    [Documentation]    Kiểm tra input field có class "input-field" hiển thị và enabled
    [Tags]    smoke    lookup    ui
    Navigate To Lookup Page
    Input Field Should Be Visible And Enabled

TC_LOOKUP_SMOKE_05: Placeholder Ô Nhập Mã Đúng Định Dạng
    [Documentation]    Kiểm tra placeholder là "VD: BK123456"
    [Tags]    smoke    lookup    ui
    Navigate To Lookup Page
    Input Field Placeholder Should Be Correct

TC_LOOKUP_SMOKE_06: Nút Tra Cứu Ngay Hiển Thị Và Có Thể Click
    [Documentation]    Kiểm tra button "btn-lookup-now" hiển thị và enabled
    [Tags]    smoke    lookup    ui
    Navigate To Lookup Page
    Lookup Button Should Be Visible And Enabled

TC_LOOKUP_SMOKE_07: Có Thể Nhập Mã Sân Vào Ô Input
    [Documentation]    Nhập mã BK72E700B3 vào ô tra cứu và kiểm tra giá trị
    [Tags]    smoke    lookup    input
    Navigate To Lookup Page
    Can Input Booking Code    BK72E700B3

TC_LOOKUP_SMOKE_08: Nhấn Nút Tra Cứu Ngay Sau Khi Nhập Mã
    [Documentation]    Nhập mã BK123456 rồi click nút Tra cứu ngay
    [Tags]    smoke    lookup    action
    Navigate To Lookup Page
    Lookup Booking Code    BK72E700B3
    Capture Page Screenshot
