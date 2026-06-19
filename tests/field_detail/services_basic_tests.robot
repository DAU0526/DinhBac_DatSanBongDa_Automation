*** Settings ***
Documentation    Smoke Tests - Kiểm tra Dịch Vụ Đi Kèm Trên Trang Chi Tiết Sân
Library          SeleniumLibrary
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/keywords/services_keywords.robot
Resource         ../../resources/variables/variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
TC_SERVICE_SMOKE_01: Khu Vực Dịch Vụ Đi Kèm Hiển Thị
    [Documentation]    Kiểm tra div.service-section và tiêu đề "Dịch vụ đi kèm" xuất hiện trên trang chi tiết sân
    [Tags]    smoke    service
    Navigate To Field Detail Page
    Page Should Contain Element    ${SERVICES_SECTION}
    Page Should Contain    Dịch vụ đi kèm

TC_SERVICE_SMOKE_02: Có Ít Nhất Một Dịch Vụ Hiển Thị
    [Documentation]    Kiểm tra ss-grid chứa ít nhất 1 ss-card
    [Tags]    smoke    service
    Navigate To Field Detail Page
    ${count}=    Get Service Count
    Should Be True    ${count} > 0    Không có dịch vụ nào trong ss-grid

TC_SERVICE_SMOKE_03: Mỗi Dịch Vụ Hiển Thị Tên Và Giá
    [Documentation]    Kiểm tra p.ss-name và p.ss-price xuất hiện trong ss-card
    [Tags]    smoke    service
    Navigate To Field Detail Page
    Wait Until Page Contains Element    ${SERVICE_CARD}    ${TIMEOUT}
    Page Should Contain Element    ${SERVICE_NAME_LABEL}
    Page Should Contain Element    ${SERVICE_PRICE_LABEL}

TC_SERVICE_SMOKE_04: Mỗi Dịch Vụ Có Nút Tăng Giảm Số Lượng
    [Documentation]    Kiểm tra nút (+) và (-) tồn tại trong mỗi ss-card
    [Tags]    smoke    service
    Navigate To Field Detail Page
    Page Should Contain Element    ${SERVICE_BTN_PLUS}
    Page Should Contain Element    ${SERVICE_BTN_MINUS}

TC_SERVICE_SMOKE_05: Số Lượng Ban Đầu Là 0
    [Documentation]    Kiểm tra span.ss-qty của "Giày" và "Nước" ban đầu hiển thị 0
    [Tags]    smoke    service
    Navigate To Field Detail Page
    Service Quantity Should Be    ${SERVICE_NAME_GIAY}    0
    Service Quantity Should Be    ${SERVICE_NAME_NUOC}    0

TC_SERVICE_SMOKE_06: Nút Trừ Bị Disabled Khi Số Lượng Bằng 0
    [Documentation]    Kiểm tra button.ss-btn-minus có attribute disabled khi qty = 0
    [Tags]    smoke    service
    Navigate To Field Detail Page
    Service Minus Button Should Be Disabled    ${SERVICE_NAME_GIAY}
    Service Minus Button Should Be Disabled    ${SERVICE_NAME_NUOC}

TC_SERVICE_SMOKE_07: Có Thể Tăng Số Lượng Dịch Vụ
    [Documentation]    Kiểm tra nhấn (+) tăng ss-qty từ 0 lên 1
    [Tags]    smoke    service
    Navigate To Field Detail Page
    Add Service    ${SERVICE_NAME_GIAY}    1
    Service Quantity Should Be    ${SERVICE_NAME_GIAY}    1

TC_SERVICE_SMOKE_08: Dịch Vụ Giày Hiển Thị Giá Không Rỗng
    [Documentation]    Kiểm tra p.ss-price của "Giày" có nội dung
    [Tags]    smoke    service
    Navigate To Field Detail Page
    Service Price Should Not Be Empty    ${SERVICE_NAME_GIAY}
