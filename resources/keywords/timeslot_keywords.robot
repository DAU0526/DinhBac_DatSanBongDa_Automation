*** Settings ***
Library    SeleniumLibrary
Resource   ../config/environment.robot
Resource   ../pages/fields_page.robot
Resource   ../pages/field_detail_page.robot
Resource   booking_keywords.robot

*** Keywords ***
# ===================== NAVIGATION =====================
Navigate To Field Detail Page
    [Documentation]    Điều hướng tới trang chi tiết sân đầu tiên
    Navigate To Pitches Page
    Wait Until Element Is Visible
    ...    xpath=(//a[contains(text(),'Xem chi tiết')])[1]
    ...    ${TIMEOUT}
    Click Element
    ...    xpath=(//a[contains(text(),'Xem chi tiết')])[1]
    Wait Until Page Contains    Lịch đặt sân    ${TIMEOUT}

# ===================== TIME SLOT - READ =====================
Get Timeslot Count
    [Arguments]    ${date}=${EMPTY}
    [Documentation]    Đếm số lượng khung giờ hiển thị
    Open Time Slot Selection
    ${count}=    Get Element Count    ${TIMESLOT_ITEM}
    RETURN    ${count}

Get Available Timeslot Count
    [Documentation]    Đếm số lượng khung giờ còn trống (có thể đặt)
    Open Time Slot Selection
    ${count}=    Get Element Count    ${TIMESLOT_AVAILABLE}
    RETURN    ${count}

Get Booked Timeslot Count
    [Documentation]    Đếm số lượng khung giờ đã được đặt
    Open Time Slot Selection
    ${count}=    Get Element Count    xpath://button[contains(@class,'bf-slot-btn') and contains(@class,'booked')]
    RETURN    ${count}

Get Time Slot Price
    [Arguments]    ${time}
    [Documentation]    Lấy giá của khung giờ theo giờ bắt đầu (ví dụ: 14:00)
    Open Time Slot Selection
    ${price}=    Get Text
    ...    xpath://button[contains(@class,'bf-slot-btn')][.//span[contains(@class,'slot-time-label') and starts-with(normalize-space(),'${time}')]]/span[contains(@class,'opacity-60')]
    RETURN    ${price}

Get Selected Time Slot
    [Documentation]    Lấy giờ của khung giờ đang được chọn
    Open Time Slot Selection
    ${time}=    Get Text    xpath://button[contains(@class,'bf-slot-btn') and contains(@class,'selected')]//span[contains(@class,'slot-time-label')]
    RETURN    ${time}

Get Booking Summary Time
    [Documentation]    Lấy thông tin khung giờ hiển thị trong sidebar đặt sân
    ${text}=    Get Text    ${SIDEBAR_TIMESLOT_DISPLAY}
    RETURN    ${text}

Get Booking Total Price
    [Documentation]    Lấy tổng tiền hiển thị trong sidebar đặt sân
    ${total}=    Get Text    ${SIDEBAR_TOTAL_PRICE}
    RETURN    ${total}

# ===================== TIME SLOT - INTERACT =====================
Open Time Slot Selection
    [Documentation]    Click vào sidebar để hiển thị khu vực chọn khung giờ nếu chưa mở
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${TIMESLOT_GRID}
    Run Keyword If    not ${is_visible}    Click Element    ${SIDEBAR_TIMESLOT_DISPLAY}
    Wait Until Element Is Visible    ${TIMESLOT_GRID}    ${TIMEOUT}

Select Time Slot By Time
    [Arguments]    ${time}
    [Documentation]    Chọn khung giờ theo giờ bắt đầu (ví dụ: 06:00, 14:00, 19:00)
    Open Time Slot Selection
    Click Element
    ...    xpath://button[contains(@class,'bf-slot-btn') and not(contains(@class,'booked'))][.//span[contains(@class,'slot-time-label') and starts-with(normalize-space(),'${time}')]]
    Sleep    0.5s

Select First Available Time Slot
    [Documentation]    Chọn khung giờ còn trống đầu tiên
    Open Time Slot Selection
    Wait Until Element Is Visible    ${TIMESLOT_AVAILABLE}    ${TIMEOUT}
    Click Element    ${TIMESLOT_AVAILABLE}
    Sleep    0.5s

Select Time Slot By Index
    [Arguments]    ${index}
    [Documentation]    Chọn khung giờ theo vị trí (0-based)
    Open Time Slot Selection
    ${slots}=    Get WebElements    ${TIMESLOT_AVAILABLE}
    Click Element    ${slots}[${index}]
    Sleep    0.5s

# ===================== TIME SLOT - ASSERTIONS =====================
Time Slot Should Be Available
    [Arguments]    ${time}
    [Documentation]    Xác nhận khung giờ còn trống
    Open Time Slot Selection
    Page Should Contain Element
    ...    xpath://button[contains(@class,'bf-slot-btn') and not(contains(@class,'booked'))][.//span[contains(@class,'slot-time-label') and starts-with(normalize-space(),'${time}')]]

Time Slot Should Be Booked
    [Arguments]    ${time}
    [Documentation]    Xác nhận khung giờ đã đặt
    Open Time Slot Selection
    Page Should Contain Element
    ...    xpath://button[contains(@class,'bf-slot-btn') and contains(@class,'booked')][.//span[contains(@class,'slot-time-label') and starts-with(normalize-space(),'${time}')]]

Time Slot Should Not Be Available
    [Arguments]    ${time}
    [Documentation]    Xác nhận khung giờ không thể đặt (booked hoặc không tồn tại)
    Open Time Slot Selection
    Page Should Not Contain Element
    ...    xpath://button[contains(@class,'bf-slot-btn') and not(contains(@class,'booked'))][.//span[contains(@class,'slot-time-label') and starts-with(normalize-space(),'${time}')]]

Time Slot Should Be Selected
    [Arguments]    ${time}
    [Documentation]    Xác nhận khung giờ đang được chọn
    Open Time Slot Selection
    Page Should Contain Element
    ...    xpath://button[contains(@class,'bf-slot-btn') and contains(@class,'selected')][.//span[contains(@class,'slot-time-label') and starts-with(normalize-space(),'${time}')]]

Sidebar Should Show Selected Time
    [Documentation]    Xác nhận sidebar cập nhật thông tin khung giờ đã chọn
    Element Should Not Contain    ${SIDEBAR_TIMESLOT_DISPLAY}    Chưa chọn

Proceed Button Should Be Active
    [Documentation]    Xác nhận nút "Tiến hành đặt sân" đã active (không còn cursor-not-allowed)
    ${class}=    Get Element Attribute    ${SIDEBAR_PROCEED_BTN}    class
    Should Not Contain    ${class}    cursor-not-allowed

Proceed Button Should Be Inactive
    [Documentation]    Xác nhận nút "Tiến hành đặt sân" vẫn bị disabled
    ${class}=    Get Element Attribute    ${SIDEBAR_PROCEED_BTN}    class
    Should Contain    ${class}    cursor-not-allowed
