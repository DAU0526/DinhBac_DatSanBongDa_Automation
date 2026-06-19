*** Settings ***
Documentation       Smoke Tests - Kiểm tra Lịch sử đặt sân
...                 Luồng: Mở website → Đăng nhập → Vào Lịch sử đặt sân → Kiểm tra đơn đặt sân
Library             SeleniumLibrary
Resource            ../../resources/keywords/booking_history_keywords.robot
Resource            ../../resources/keywords/booking_keywords.robot
Resource            ../../resources/variables/variables.robot

Suite Setup         Open Browser To Application
Suite Teardown      Close Browser Application

*** Test Cases ***

TC_HISTORY_SMOKE_01: Mở Website Thành Công
    [Documentation]    Kiểm tra website mở được và hiển thị trang chủ
    [Tags]    smoke    booking-history    website
    Wait Until Page Contains    Football Booking    ${TIMEOUT}
    Capture Page Screenshot

TC_HISTORY_SMOKE_02: Đăng Nhập Bằng Tài Khoản Hợp Lệ
    [Documentation]    Đăng nhập bằng SĐT 04858758475 / pass 12345
    [Tags]    smoke    booking-history    login
    Login As Booking User
    Login Should Succeed And Redirect
    Capture Page Screenshot

TC_HISTORY_SMOKE_03: Điều Hướng Tới Trang Lịch Sử Đặt Sân
    [Documentation]    Vào trang Lịch sử đặt sân sau khi đã đăng nhập
    [Tags]    smoke    booking-history    navigation
    Navigate To My Bookings Page
    Booking History Page Should Be Displayed
    Capture Page Screenshot

TC_HISTORY_SMOKE_04: Trang Lịch Sử Có Xuất Hiện Đơn Đặt Sân
    [Documentation]    Kiểm tra có ít nhất 1 đơn đặt sân được hiển thị
    [Tags]    smoke    booking-history    orders
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    Capture Page Screenshot

TC_HISTORY_SMOKE_05: Đơn Đặt Sân Hiển Thị Tên Sân
    [Documentation]    Kiểm tra cột/trường tên sân có nội dung
    [Tags]    smoke    booking-history    field-name
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    Booking History Should Show Field Name

TC_HISTORY_SMOKE_06: Đơn Đặt Sân Hiển Thị Ngày Đặt
    [Documentation]    Kiểm tra cột/trường ngày đặt có nội dung
    [Tags]    smoke    booking-history    date
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    Booking History Should Show Booking Date

TC_HISTORY_SMOKE_07: Đơn Đặt Sân Hiển Thị Khung Giờ
    [Documentation]    Kiểm tra cột/trường khung giờ có nội dung
    [Tags]    smoke    booking-history    time-slot
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    Booking History Should Show Time Slot

TC_HISTORY_SMOKE_08: Đơn Đặt Sân Hiển Thị Trạng Thái
    [Documentation]    Kiểm tra cột/trường trạng thái có nội dung
    [Tags]    smoke    booking-history    status
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    Booking History Should Show Status
