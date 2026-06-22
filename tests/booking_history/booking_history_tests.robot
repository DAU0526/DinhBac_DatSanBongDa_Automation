*** Settings ***
Documentation       Regression Tests - Lịch sử đặt sân
...                 Kiểm tra chi tiết toàn bộ thông tin hiển thị trong trang Lịch sử đặt sân:
...                 Tên sân, Ngày đặt, Khung giờ, Trạng thái
...                 Luồng: Mở website → Đăng nhập (04858758475/12345) → Lịch sử đặt sân → Kiểm tra chi tiết
Library             SeleniumLibrary
Resource            ../../resources/keywords/booking_history_keywords.robot
Resource            ../../resources/keywords/booking_keywords.robot
Resource            ../../resources/common_variables.robot

Suite Setup         Open Browser To Application
Suite Teardown      Close Browser Application

*** Test Cases ***

TC_HISTORY_REG_01: Toàn Bộ Luồng Mở Website Và Đăng Nhập
    [Documentation]    Kiểm tra website mở được và đăng nhập thành công với tài khoản 04858758475
    [Tags]    regression    booking-history    login    smoke
    Wait Until Page Contains    Football Booking    ${TIMEOUT}
    Login As Booking User
    Login Should Succeed And Redirect
    Capture Page Screenshot

TC_HISTORY_REG_02: Trang Lịch Sử Đặt Sân Hiển Thị Sau Đăng Nhập
    [Documentation]    Kiểm tra điều hướng thành công tới /my-bookings và trang hiển thị đúng tiêu đề
    [Tags]    regression    booking-history    navigation
    Navigate To My Bookings Page
    Booking History Page Should Be Displayed
    Page Should Contain    Lịch sử đặt sân
    Capture Page Screenshot

TC_HISTORY_REG_03: Danh Sách Đơn Đặt Sân Không Trống
    [Documentation]    Kiểm tra trang hiển thị ít nhất 1 đơn đặt sân - không được hiển thị trang trống
    [Tags]    regression    booking-history    orders
    Navigate To My Bookings Page
    Booking History Should Have Items
    Capture Page Screenshot

TC_HISTORY_REG_04: Tất Cả Đơn Đặt Sân Có Tên Sân
    [Documentation]    Kiểm tra từng đơn đặt sân đều hiển thị tên sân, không được để trống
    [Tags]    regression    booking-history    field-name
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    All Booking Items Should Have Field Name

TC_HISTORY_REG_05: Tất Cả Đơn Đặt Sân Có Ngày Đặt
    [Documentation]    Kiểm tra từng đơn đặt sân đều hiển thị ngày đặt, không được để trống
    [Tags]    regression    booking-history    date
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    All Booking Items Should Have Date

TC_HISTORY_REG_06: Tất Cả Đơn Đặt Sân Có Khung Giờ
    [Documentation]    Kiểm tra từng đơn đặt sân đều hiển thị khung giờ, không được để trống
    [Tags]    regression    booking-history    time-slot
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    All Booking Items Should Have Time Slot

TC_HISTORY_REG_07: Tất Cả Đơn Đặt Sân Có Trạng Thái
    [Documentation]    Kiểm tra từng đơn đặt sân đều hiển thị trạng thái, không được để trống
    [Tags]    regression    booking-history    status
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    All Booking Items Should Have Status

TC_HISTORY_REG_08: Trạng Thái Đơn Đặt Sân Phải Hợp Lệ
    [Documentation]    Kiểm tra giá trị trạng thái nằm trong danh sách hợp lệ
    ...    (Chờ xác nhận / Đã xác nhận / Đã hủy / Hoàn thành)
    [Tags]    regression    booking-history    status    validation
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    Status Should Be Valid

TC_HISTORY_REG_09: Đơn Đặt Sân Đầu Tiên Có Đầy Đủ Thông Tin
    [Documentation]    Kiểm tra đơn đặt sân đầu tiên hiển thị đủ 4 thông tin:
    ...    Tên sân, Ngày đặt, Khung giờ, Trạng thái
    [Tags]    regression    booking-history    complete-info
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    First Booking Should Have Complete Info
    Capture Page Screenshot

TC_HISTORY_REG_10: Log Toàn Bộ Thông Tin Lịch Sử Đặt Sân
    [Documentation]    Lấy và ghi log toàn bộ thông tin các đơn đặt sân để kiểm tra dữ liệu
    [Tags]    regression    booking-history    data-log
    Navigate To My Bookings Page
    Booking Orders Should Be Visible
    Get All Booking Info And Log
    Capture Page Screenshot

TC_HISTORY_REG_11: Điều Hướng Qua Menu Navbar Tới Lịch Sử Đặt Sân
    [Documentation]    Kiểm tra có thể vào trang Lịch sử đặt sân thông qua menu điều hướng
    [Tags]    regression    booking-history    navigation    navbar
    Go To    ${URL}
    Wait Until Page Contains    Football Booking    ${TIMEOUT}
    Navigate To My Bookings Via Nav
    Booking History Page Should Be Displayed
    Capture Page Screenshot

TC_HISTORY_REG_12: URL Trang Lịch Sử Đặt Sân Đúng
    [Documentation]    Kiểm tra URL khi vào trang Lịch sử đặt sân chứa 'my-bookings'
    [Tags]    regression    booking-history    url
    Navigate To My Bookings Page
    Location Should Contain    my-bookings
