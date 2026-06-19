*** Settings ***
Documentation    Regression Tests - Kiểm tra các lỗi tái diễn
Library          SeleniumLibrary
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/variables/variables.robot

Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***

TC_REG_01: Chọn Sân Từ Trang Chủ Rồi Đặt Sân
    Navigate To Home Page
    Select Pitch From Home
    Select First Time Slot And Proceed To Booking
    Fill Customer Info
    ...    Nguyễn Văn A
    ...    0912345678
    ...    test@example.com
    Click Confirm Booking
    Confirm Booking In Modal
    Booking Should Be Successful

TC_REG_02: Chọn Sân Từ Trang Sân Bóng Rồi Đặt Sân
    Navigate To Pitches Page
    Add Pitch To Booking    Test
    Fill Customer Info
    ...    Trần Thị B
    ...    0987654321
    ...    test2@example.com
    Click Confirm Booking
    Confirm Booking In Modal
    Booking Should Be Successful

TC_REG_03: Không Thể Đặt Sân Khi Không Điền Tên
    Navigate To Booking Page
    Fill Customer Info
    ...    ${EMPTY}
    ...    0912345678
    ...    test@example.com
    Click Book Button
    Booking Should Fail With Error
    ...    Tên khách hàng không được để trống

TC_REG_04: Không Thể Đặt Sân Khi Điền Số Điện Thoại Không Hợp Lệ
    Navigate To Booking Page
    Fill Customer Info
    ...    Nguyễn Văn C
    ...    123
    ...    test3@example.com
    Click Book Button
    Booking Should Fail With Error
    ...    Số điện thoại không hợp lệ

TC_REG_05: Không Thể Đặt Sân Khi Điền Email Không Hợp Lệ
    Navigate To Booking Page
    Fill Customer Info
    ...    Phạm Văn D
    ...    0901234567
    ...    invalid-email
    Click Book Button
    Booking Should Fail With Error
    ...    Email không hợp lệ

TC_REG_06: Kiểm Tra Dữ Liệu Được Lưu Đúng Sau Khi Đặt Sân
    Navigate To Pitches Page
    Add Pitch To Booking    Test
    Fill Customer Info
    ...    Hoàng Thị E
    ...    0876543210
    ...    test5@example.com
    Textfield Value Should Be    ${FIELD_BOOKING_NAME}    Hoàng Thị E
    Textfield Value Should Be    ${FIELD_BOOKING_PHONE}    0876543210
    Textfield Value Should Be    ${FIELD_BOOKING_EMAIL}    test5@example.com
    Page Should Contain    Test
    Click Confirm Booking
    Confirm Booking In Modal
    Booking Should Be Successful