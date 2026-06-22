*** Settings ***
Documentation    Regression Tests - Kiểm tra Chi Tiết Dịch Vụ Đi Kèm Trên Trang Chi Tiết Sân
Library          SeleniumLibrary
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/keywords/services_keywords.robot
Resource         ../../resources/common_variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
TC_SERVICE_REG_01: Trang Chi Tiết Sân Hiển Thị Đầy Đủ Khu Vực Dịch Vụ
    [Documentation]    Kiểm tra service-section, ss-grid, ss-card, tiêu đề đều hiển thị
    [Tags]    regression    service
    Navigate To Field Detail Page
    Page Should Contain Element    ${SERVICES_SECTION}
    Page Should Contain Element    ${SERVICES_LIST}
    Page Should Contain Element    ${SERVICE_CARD}
    Page Should Contain    Dịch vụ đi kèm

TC_SERVICE_REG_02: Số Lượng Dịch Vụ Lớn Hơn 0
    [Documentation]    Kiểm tra ss-grid có ít nhất 1 ss-card
    [Tags]    regression    service
    Navigate To Field Detail Page
    ${count}=    Get Service Count
    Should Be True    ${count} > 0    Phải có ít nhất 1 dịch vụ đi kèm

TC_SERVICE_REG_03: Dịch Vụ Giày Hiển Thị Đúng Tên Và Giá
    [Documentation]    Kiểm tra ss-card "Giày" có p.ss-name = "Giày" và p.ss-price không rỗng
    [Tags]    regression    service
    Navigate To Field Detail Page
    Service Should Be Visible    ${SERVICE_NAME_GIAY}
    Service Price Should Not Be Empty    ${SERVICE_NAME_GIAY}

TC_SERVICE_REG_04: Dịch Vụ Nước Hiển Thị Đúng Tên Và Giá
    [Documentation]    Kiểm tra ss-card "Nước" có p.ss-name = "Nước" và p.ss-price không rỗng
    [Tags]    regression    service
    Navigate To Field Detail Page
    Service Should Be Visible    ${SERVICE_NAME_NUOC}
    Service Price Should Not Be Empty    ${SERVICE_NAME_NUOC}

TC_SERVICE_REG_05: Số Lượng Ban Đầu Của Tất Cả Dịch Vụ Là 0
    [Documentation]    Kiểm tra span.ss-qty của "Giày" và "Nước" đều = 0 khi mới vào trang
    [Tags]    regression    service
    Navigate To Field Detail Page
    Service Quantity Should Be    ${SERVICE_NAME_GIAY}    0
    Service Quantity Should Be    ${SERVICE_NAME_NUOC}    0

TC_SERVICE_REG_06: Nút Trừ Disabled Khi Qty Bằng 0
    [Documentation]    Kiểm tra button.ss-btn-minus có disabled khi ss-qty = 0
    [Tags]    regression    service
    Navigate To Field Detail Page
    Service Minus Button Should Be Disabled    ${SERVICE_NAME_GIAY}
    Service Minus Button Should Be Disabled    ${SERVICE_NAME_NUOC}

TC_SERVICE_REG_07: Nhấn Cộng Tăng Số Lượng Dịch Vụ Giày Lên 1
    [Documentation]    Kiểm tra click (+) → ss-qty tăng từ 0 lên 1
    [Tags]    regression    service
    Navigate To Field Detail Page
    Service Quantity Should Be    ${SERVICE_NAME_GIAY}    0
    Add Service    ${SERVICE_NAME_GIAY}    1
    Service Quantity Should Be    ${SERVICE_NAME_GIAY}    1

TC_SERVICE_REG_08: Nút Trừ Enabled Sau Khi Tăng Số Lượng
    [Documentation]    Kiểm tra button.ss-btn-minus không còn disabled sau khi qty > 0
    [Tags]    regression    service
    Navigate To Field Detail Page
    Add Service    ${SERVICE_NAME_GIAY}    1
    Service Minus Button Should Be Enabled    ${SERVICE_NAME_GIAY}

TC_SERVICE_REG_09: Nhấn Trừ Giảm Số Lượng Về 0
    [Documentation]    Kiểm tra click (-) sau khi qty = 1 → qty trở về 0
    [Tags]    regression    service
    Navigate To Field Detail Page
    Add Service    ${SERVICE_NAME_GIAY}    1
    Service Quantity Should Be    ${SERVICE_NAME_GIAY}    1
    Remove Service    ${SERVICE_NAME_GIAY}    1
    Service Quantity Should Be    ${SERVICE_NAME_GIAY}    0

TC_SERVICE_REG_10: Nút Trừ Bị Disabled Lại Khi Qty Trở Về 0
    [Documentation]    Kiểm tra button.ss-btn-minus bị disabled lại khi qty giảm về 0
    [Tags]    regression    service
    Navigate To Field Detail Page
    Add Service    ${SERVICE_NAME_GIAY}    1
    Remove Service    ${SERVICE_NAME_GIAY}    1
    Service Minus Button Should Be Disabled    ${SERVICE_NAME_GIAY}

TC_SERVICE_REG_11: Có Thể Tăng Số Lượng Lên Nhiều Lần
    [Documentation]    Kiểm tra nhấn (+) 3 lần → qty = 3
    [Tags]    regression    service
    Navigate To Field Detail Page
    Add Service    ${SERVICE_NAME_NUOC}    3
    Service Quantity Should Be    ${SERVICE_NAME_NUOC}    3

TC_SERVICE_REG_12: Hai Dịch Vụ Có Thể Tăng Độc Lập
    [Documentation]    Kiểm tra tăng số lượng "Giày" và "Nước" không ảnh hưởng lẫn nhau
    [Tags]    regression    service
    Navigate To Field Detail Page
    Add Service    ${SERVICE_NAME_GIAY}    2
    Add Service    ${SERVICE_NAME_NUOC}    1
    Service Quantity Should Be    ${SERVICE_NAME_GIAY}    2
    Service Quantity Should Be    ${SERVICE_NAME_NUOC}    1

TC_SERVICE_REG_13: Sidebar Hiển Thị Tổng Tiền Dịch Vụ
    [Documentation]    Kiểm tra sidebar hiển thị "Dịch vụ thêm" với giá trị hợp lệ
    [Tags]    regression    service
    Navigate To Field Detail Page
    ${total}=    Get Sidebar Service Total
    Should Not Be Empty    ${total}

TC_SERVICE_REG_14: Reset Số Lượng Về 0 Sau Khi Tăng
    [Documentation]    Kiểm tra keyword Reset Service Quantity giảm qty về 0 thành công
    [Tags]    regression    service
    Navigate To Field Detail Page
    Add Service    ${SERVICE_NAME_GIAY}    3
    Reset Service Quantity    ${SERVICE_NAME_GIAY}
    Service Quantity Should Be    ${SERVICE_NAME_GIAY}    0
    Service Minus Button Should Be Disabled    ${SERVICE_NAME_GIAY}
