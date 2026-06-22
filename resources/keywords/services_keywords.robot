*** Settings ***
Library    SeleniumLibrary
Library    ../locators/FieldsPageLocators.py    WITH NAME    fields_locators
Library    ../locators/FieldDetailPageLocators.py    WITH NAME    field_detail_locators
Resource   ../common_variables.robot
Resource   ../page_objects/FieldsPage.resource
Resource   ../page_objects/FieldDetailPage.resource
Resource   ../booking_keywords.robot

*** Keywords ***
# ===================== NAVIGATION =====================

Navigate To Field Detail Page
    [Documentation]    Điều hướng tới trang chi tiết sân (dịch vụ nằm ở đây)
    Navigate To Pitches Page
    Wait Until Element Is Visible
    ...    xpath=(//a[contains(text(),'Xem chi tiết')])[1]
    ...    ${TIMEOUT}
    Click Element
    ...    xpath=(//a[contains(text(),'Xem chi tiết')])[1]
    Wait Until Page Contains    Dịch vụ đi kèm    ${TIMEOUT}

    Capture Page Screenshot

# ===================== READ =====================

View Available Services
    [Documentation]    Xác nhận khu vực dịch vụ đi kèm (service-section) hiển thị
    Page Should Contain    Dịch vụ đi kèm
    Wait Until Page Contains Element    ${field_detail_locators.SERVICES_LIST}    ${TIMEOUT}

    Capture Page Screenshot

Get Available Services
    [Documentation]    Trả về danh sách tất cả các ss-card trên trang
    ${cards}=    Get WebElements    ${field_detail_locators.SERVICE_CARD}
    RETURN    ${cards}

Get Service Count
    [Documentation]    Đếm số lượng dịch vụ (ss-card) hiển thị
    ${count}=    Get Element Count    ${field_detail_locators.SERVICE_CARD}
    RETURN    ${count}

Get Service Quantity
    [Arguments]    ${service_name}
    [Documentation]    Lấy số lượng hiện tại của dịch vụ (từ span.ss-qty)
    ${qty}=    Get Text
    ...    xpath://div[contains(@class,'ss-card')][.//p[contains(@class,'ss-name') and normalize-space()='${service_name}']]//span[contains(@class,'ss-qty')]
    RETURN    ${qty}

Get Service Price
    [Arguments]    ${service_name}
    [Documentation]    Lấy giá của dịch vụ (từ p.ss-price)
    ${price}=    Get Text
    ...    xpath://div[contains(@class,'ss-card')][.//p[contains(@class,'ss-name') and normalize-space()='${service_name}']]//p[contains(@class,'ss-price')]
    RETURN    ${price}

Get Sidebar Service Total
    [Documentation]    Lấy tổng tiền dịch vụ thêm hiển thị trong sidebar
    ${total}=    Get Text    ${field_detail_locators.SIDEBAR_SERVICE_PRICE}
    RETURN    ${total}

# ===================== INTERACT =====================

Click Plus Button
    [Arguments]    ${service_name}
    [Documentation]    Nhấn nút (+) để tăng số lượng dịch vụ
    Click Element
    ...    xpath://div[contains(@class,'ss-card')][.//p[contains(@class,'ss-name') and normalize-space()='${service_name}']]//button[contains(@class,'ss-btn-plus')]

    Capture Page Screenshot

Click Minus Button
    [Arguments]    ${service_name}
    [Documentation]    Nhấn nút (-) để giảm số lượng dịch vụ
    Click Element
    ...    xpath://div[contains(@class,'ss-card')][.//p[contains(@class,'ss-name') and normalize-space()='${service_name}']]//button[contains(@class,'ss-btn-minus')]

    Capture Page Screenshot

Add Service
    [Arguments]    ${service_name}    ${quantity}=1
    [Documentation]    Thêm dịch vụ với số lượng cho trước bằng cách nhấn (+) nhiều lần
    FOR    ${i}    IN RANGE    ${quantity}
        Click Plus Button    ${service_name}
    END

    Capture Page Screenshot

Select Multiple Services
    [Arguments]    @{service_names}
    [Documentation]    Them nhieu dich vu, moi dich vu tang 1 lan neu tim thay tren trang
    FOR    ${service_name}    IN    @{service_names}
        ${exists}=    Run Keyword And Return Status    Service Should Be Visible    ${service_name}
        Run Keyword If    ${exists}    Add Service    ${service_name}    1
        Run Keyword If    not ${exists}    Log    Service not found, skipped: ${service_name}
    END

Remove Service
    [Arguments]    ${service_name}    ${quantity}=1
    [Documentation]    Giảm số lượng dịch vụ bằng cách nhấn (-) nhiều lần
    FOR    ${i}    IN RANGE    ${quantity}
        Click Minus Button    ${service_name}
    END

    Capture Page Screenshot

Reset Service Quantity
    [Arguments]    ${service_name}
    [Documentation]    Giảm số lượng dịch vụ về 0 bằng cách nhấn (-) cho đến khi qty = 0
    ${qty}=    Get Service Quantity    ${service_name}
    WHILE    '${qty}' != '0'
        Click Minus Button    ${service_name}
        ${qty}=    Get Service Quantity    ${service_name}
    END

    Capture Page Screenshot

# ===================== ASSERTIONS =====================

Service Should Be Visible
    [Arguments]    ${service_name}
    [Documentation]    Xác nhận ss-card với tên dịch vụ tồn tại trên trang
    Page Should Contain Element
    ...    xpath://div[contains(@class,'ss-card')][.//p[contains(@class,'ss-name') and normalize-space()='${service_name}']]

    Capture Page Screenshot

Service Quantity Should Be
    [Arguments]    ${service_name}    ${expected_qty}
    [Documentation]    Xác nhận span.ss-qty của dịch vụ bằng giá trị mong đợi
    ${qty}=    Get Service Quantity    ${service_name}
    Should Be Equal As Strings    ${qty}    ${expected_qty}

    Capture Page Screenshot

Service Minus Button Should Be Disabled
    [Arguments]    ${service_name}
    [Documentation]    Xác nhận nút (-) bị disabled (khi qty = 0)
    Element Should Be Disabled
    ...    xpath://div[contains(@class,'ss-card')][.//p[contains(@class,'ss-name') and normalize-space()='${service_name}']]//button[contains(@class,'ss-btn-minus')]

    Capture Page Screenshot

Service Minus Button Should Be Enabled
    [Arguments]    ${service_name}
    [Documentation]    Xác nhận nút (-) đã enabled (khi qty > 0)
    Element Should Be Enabled
    ...    xpath://div[contains(@class,'ss-card')][.//p[contains(@class,'ss-name') and normalize-space()='${service_name}']]//button[contains(@class,'ss-btn-minus')]

    Capture Page Screenshot

Service Price Should Not Be Empty
    [Arguments]    ${service_name}
    [Documentation]    Xác nhận p.ss-price của dịch vụ có nội dung
    ${price}=    Get Service Price    ${service_name}
    Should Not Be Empty    ${price}

    Capture Page Screenshot
