*** Settings ***
Documentation    Smoke Tests - Kiểm tra chức năng đặt sân bóng
Library          SeleniumLibrary

Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/common_variables.robot

Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***

TC_SMOKE_01: Có Thể Truy Cập Trang Danh Sách Sân
    [Documentation]    Kiểm tra truy cập trang danh sách sân
    [Tags]    smoke

    Navigate To Pitches Page

    Page Should Contain
    ...    Sân

TC_SMOKE_02: Có Thể Xem Chi Tiết Sân
    [Documentation]    Kiểm tra mở trang chi tiết sân
    [Tags]    smoke

    Navigate To Pitches Page

    Click Element
    ...    xpath=(//a[contains(.,'Xem chi tiết')])[1]

    Wait Until Page Contains
    ...    Lịch đặt sân
    ...    20s

TC_SMOKE_03: Có Thể Điều Hướng Đến Trang Booking
    [Documentation]    Kiểm tra luồng chọn sân và chuyển sang trang booking
    [Tags]    smoke

    Navigate To Booking Page

    Page Should Contain
    ...    Xác nhận đặt sân

TC_SMOKE_04: Form Booking Hiển Thị Đầy Đủ
    [Documentation]    Kiểm tra các trường trên form booking
    [Tags]    smoke

    Navigate To Booking Page

    Page Should Contain Element
    ...    ${FIELD_BOOKING_NAME}

    Page Should Contain Element
    ...    ${FIELD_BOOKING_PHONE}

    Page Should Contain Element
    ...    ${FIELD_BOOKING_EMAIL}

    Page Should Contain Element
    ...    ${FIELD_BOOKING_NOTE}

    Page Should Contain Element
    ...    ${BUTTON_CONFIRM_BOOKING}

TC_SMOKE_05: Có Thể Nhấn Nút Xác Nhận Đặt Sân
    [Documentation]    Kiểm tra submit booking
    [Tags]    smoke

    Navigate To Booking Page

    Fill Booking Information

    Confirm Booking

    Capture Page Screenshot
TC_SMOKE_06: Popup Xác Nhận Hiển Thị
    [Tags]    smoke

    Navigate To Booking Page

    Fill Booking Information

    Click Confirm Booking

    Confirm Booking Modal Should Be Visible
TC_SMOKE_07: Xác Nhận Đặt Sân Thành Công
    [Tags]    smoke

    Navigate To Booking Page

    Fill Booking Information

    Click Confirm Booking

    Confirm Booking Modal Should Be Visible

    Confirm Booking In Modal

    Capture Page Screenshot
TC_SMOKE_08: Có Thể Hủy Booking Trong Modal
    [Documentation]    Kiểm tra người dùng có thể hủy booking tại popup xác nhận
    [Tags]    smoke

    Navigate To Booking Page

    Fill Booking Information

    Click Confirm Booking

    Cancel Booking In Modal

    Capture Page Screenshot
