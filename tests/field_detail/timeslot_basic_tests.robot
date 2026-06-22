*** Settings ***
Documentation    Smoke Tests - Kiểm tra Khung Giờ Trên Trang Chi Tiết Sân
Library          SeleniumLibrary
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/keywords/timeslot_keywords.robot
Resource         ../../resources/common_variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
TC_TIME_SMOKE_01: Lịch Đặt Sân Hiển Thị Sau Khi Vào Trang Chi Tiết
    [Documentation]    Kiểm tra khu vực lịch đặt sân (fd-slots) xuất hiện trên trang chi tiết sân
    [Tags]    smoke    timeslot
    Navigate To Field Detail Page
    Wait Until Page Contains Element    ${TIMESLOT_LIST}    ${TIMEOUT}
    Page Should Contain    Lịch đặt sân

TC_TIME_SMOKE_02: Có Ít Nhất Một Khung Giờ Còn Trống
    [Documentation]    Kiểm tra có ít nhất 1 slot mang class fd-slot--available trên trang
    [Tags]    smoke    timeslot
    Navigate To Field Detail Page
    ${count}=    Get Timeslot Count
    Should Be True    ${count} > 0    Không có khung giờ nào còn trống

TC_TIME_SMOKE_03: Mỗi Khung Giờ Hiển Thị Giờ Và Giá
    [Documentation]    Kiểm tra mỗi slot có span.slot-time và span.slot-price trên giao diện chính
    [Tags]    smoke    timeslot
    Navigate To Field Detail Page
    Wait Until Page Contains Element    ${TIMESLOT_ITEM}    ${TIMEOUT}
    Page Should Contain Element    ${SLOT_TIME_LABEL}
    Page Should Contain Element    ${SLOT_PRICE_LABEL}

TC_TIME_SMOKE_04: Có Thể Chọn Khung Giờ Còn Trống
    [Documentation]    Kiểm tra click vào fd-slot--available thành công và slot chuyển sang selected
    [Tags]    smoke    timeslot
    Navigate To Field Detail Page
    Select First Available Time Slot
    Open Time Slot Selection
    Page Should Contain Element    ${TIMESLOT_SELECTED}

TC_TIME_SMOKE_05: Sidebar Cập Nhật Sau Khi Chọn Khung Giờ
    [Documentation]    Kiểm tra sidebar "Thông tin đặt sân" hiển thị thông tin sau khi chọn slot
    [Tags]    smoke    timeslot
    Navigate To Field Detail Page
    Select First Available Time Slot
    Sidebar Should Show Selected Time

TC_TIME_SMOKE_06: Nút Tiến Hành Đặt Sân Kích Hoạt Sau Khi Chọn Giờ
    [Documentation]    Kiểm tra nút "Tiến hành đặt sân" bỏ trạng thái cursor-not-allowed khi có slot được chọn
    [Tags]    smoke    timeslot
    Navigate To Field Detail Page
    Select First Available Time Slot
    Proceed Button Should Be Active

TC_TIME_SMOKE_07: Khung Giờ Cụ Thể Có Thể Chọn Theo Giờ
    [Documentation]    Kiểm tra có thể chọn slot 14:00 theo tên giờ (giờ chiều luôn hiển thị khi chạy test)
    [Tags]    smoke    timeslot
    Navigate To Field Detail Page
    Time Slot Should Be Available    14:00
    Select Time Slot By Time    14:00
    Time Slot Should Be Selected    14:00
