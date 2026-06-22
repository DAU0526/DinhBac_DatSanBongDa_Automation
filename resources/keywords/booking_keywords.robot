*** Settings ***
Library    SeleniumLibrary
Variables    ../locators/BookingPageLocators.py
Variables    ../locators/FieldDetailPageLocators.py
Resource   ../common_variables.robot
Resource   ../common_variables.robot
Resource   ../page_objects/BasePage.resource
Resource   ../page_objects/HomePage.resource
Resource   ../page_objects/FieldsPage.resource
Resource   ../page_objects/FieldDetailPage.resource
Resource   ../page_objects/BookingPage.resource

*** Keywords ***

# Setup & Teardown Keywords

Open Browser To Application
    [Documentation]    Mở browser và truy cập website
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
    Wait Until Page Contains    Football Booking    ${TIMEOUT}

Close Browser Application
    [Documentation]    Đóng browser
    Close Browser

# Navigation Keywords

Navigate To Home Page
    [Documentation]    Quay lại trang chủ
    Go To    ${URL}
    Wait Until Page Contains    Football Booking    ${TIMEOUT}

Navigate To Pitches Page
    Go To    ${URL}/fields

    Sleep    3s

    Wait Until Element Is Visible
    ...    xpath=(//a[contains(text(),'Xem chi tiết')])[1]
    ...    20s

    Scroll Element Into View
    ...    xpath=(//a[contains(text(),'Xem chi tiết')])[1]

    Sleep    1s

Navigate To Booking Page
    [Documentation]    Điều hướng tới trang booking theo luồng thực tế

    Navigate To Pitches Page

    Wait Until Element Is Visible
    ...    xpath=(//a[contains(text(),'Xem chi tiết')])[1]
    ...    ${TIMEOUT}

    Click Element
    ...    xpath=(//a[contains(text(),'Xem chi tiết')])[1]

    Wait Until Page Contains
    ...    Lịch đặt sân
    ...    ${TIMEOUT}

    Wait Until Element Is Visible
    ...    xpath=//span[contains(text(),'Chưa chọn')]
    ...    ${TIMEOUT}

    Click Element
    ...    xpath=//span[contains(text(),'Chưa chọn')]

    Sleep    2s

    # Chọn khung giờ đầu tiên

    Wait Until Element Is Visible
    ...    xpath=(//button[contains(@class,'bf-slot-btn')])[1]
    ...    ${TIMEOUT}

    Click Element
    ...    xpath=(//button[contains(@class,'bf-slot-btn')])[1]

    Sleep    2s
    ${slot_text}=    Get Text
    ...    xpath=//span[contains(@class,'text-slate-900')]

    Log To Console    SLOT_SELECTED=${slot_text}

    Capture Page Screenshot

    ${selected}=    Get Text
...    xpath=//span[contains(@class,'text-slate-900')]

    Log To Console
    ...    SELECTED_SLOT=${selected}

    Scroll Element Into View
    ...    xpath=//a[contains(.,'Tiến hành đặt sân')]

    Sleep    2s

    Click Link
    ...    xpath=//a[contains(.,'Tiến hành đặt sân')]

    Wait Until Page Contains
    ...    Xác nhận đặt sân
    ...    ${TIMEOUT}

# Home Page - Pitch Selection Keywords

Select Pitch From Home
    [Arguments]    ${pitch_name}=${EMPTY}

    Navigate To Home Page

    Wait Until Element Is Visible
    ...    xpath=(//a[contains(@href,'/fields/')])[1]
    ...    ${TIMEOUT}

    IF    '${pitch_name}' != '${EMPTY}'
        ${pitch_link}=    Set Variable
        ...    xpath=//h5[contains(normalize-space(.),'${pitch_name}')]/ancestor::div[contains(@class,'p-6')]//a[contains(@href,'/fields/')]

        ${count}=    Get Element Count    ${pitch_link}

        IF    ${count} > 0
            Click Element    ${pitch_link}
        ELSE
            Click Element
            ...    xpath=(//a[contains(@href,'/fields/')])[1]
        END
    ELSE
        Click Element
        ...    xpath=(//a[contains(@href,'/fields/')])[1]
    END

    Wait Until Page Contains
    ...    Lịch đặt sân
    ...    ${TIMEOUT}

Get Available Pitches From Home
    Navigate To Home Page

    ${pitches}=    Get WebElements
    ...    xpath://div[contains(@class,'pitch-card') or contains(@class,'bg-white')]//h5

    RETURN    ${pitches}

# Pitches Page - Selection & Details Keywords

Select Pitch From Pitches Page
    [Arguments]    ${pitch_name}

    Navigate To Pitches Page

    Click Element
    ...    xpath://h5[contains(text(),'${pitch_name}')]

    Wait Until Page Contains
    ...    Chi tiết sân
    ...    ${TIMEOUT}

View Pitch Full Details
    [Arguments]    ${pitch_name}

    Navigate To Pitches Page

    Click Element
    ...    xpath=//h5[contains(text(),'${pitch_name}')]/ancestor::div[contains(@class,'p-6')]//a[contains(text(),'Xem chi tiết')]

    Wait Until Page Contains
    ...    Lịch đặt sân
    ...    ${TIMEOUT}

Add Pitch To Booking
    [Arguments]    ${pitch_name}

    View Pitch Full Details    ${pitch_name}

    Select First Time Slot And Proceed To Booking

Select First Time Slot And Proceed To Booking
    [Documentation]    Chọn khung giờ đầu tiên và chuyển sang trang xác nhận đặt sân

    Wait Until Element Is Visible
    ...    xpath=//span[contains(text(),'Chưa chọn')]
    ...    ${TIMEOUT}

    Click Element
    ...    xpath=//span[contains(text(),'Chưa chọn')]

    Sleep    1s

    Wait Until Element Is Visible
    ...    xpath=(//button[contains(@class,'bf-slot-btn')])[1]
    ...    ${TIMEOUT}

    Click Element
    ...    xpath=(//button[contains(@class,'bf-slot-btn')])[1]

    Sleep    1s

    Click Proceed To Booking

# Booking Page - Date Selection Keywords

Select Date On Calendar
    [Arguments]    ${date}

    Click Element    ${FIELD_SELECT_DATE}

    Wait Until Page Contains
    ...    ${date}
    ...    ${TIMEOUT}

    Click Element
    ...    xpath://div[contains(text(),'${date}')]

# Booking Page - Time Slot Selection Keywords

Select Time Slot
    [Arguments]    ${time}

    Click Element    ${FIELD_SELECT_TIME}

    Wait Until Page Contains
    ...    ${time}
    ...    ${TIMEOUT}

    Click Element
    ...    xpath://option[contains(text(),'${time}')]

# Booking Page - Customer Info Keywords
Fill Customer Info
    [Arguments]    ${name}    ${phone}    ${email}

    Wait Until Element Is Visible
    ...    ${FIELD_BOOKING_NAME}
    ...    ${TIMEOUT}

    Clear Element Text    ${FIELD_BOOKING_NAME}
    Input Text    ${FIELD_BOOKING_NAME}    ${name}

    Clear Element Text    ${FIELD_BOOKING_PHONE}
    Input Text    ${FIELD_BOOKING_PHONE}    ${phone}

    Clear Element Text    ${FIELD_BOOKING_EMAIL}
    Input Text    ${FIELD_BOOKING_EMAIL}    ${email}

Fill Booking Information

    Wait Until Element Is Visible
    ...    ${FIELD_BOOKING_NAME}
    ...    ${TIMEOUT}

    Clear Element Text
    ...    ${FIELD_BOOKING_NAME}

    Input Text
    ...    ${FIELD_BOOKING_NAME}
    ...    Nguyễn Văn A

    Clear Element Text
    ...    ${FIELD_BOOKING_PHONE}

    Input Text
    ...    ${FIELD_BOOKING_PHONE}
    ...    0912345678

    Clear Element Text
    ...    ${FIELD_BOOKING_EMAIL}

    Input Text
    ...    ${FIELD_BOOKING_EMAIL}
    ...    test@gmail.com

# Booking Page - Confirmation Keywords
Confirm Booking Modal Should Be Visible
    [Documentation]    Kiểm tra modal xác nhận hiển thị

    Wait Until Element Is Visible
    ...    css=.cd-modal
    ...    ${TIMEOUT}

    Page Should Contain
    ...    Xác nhận đặt sân

    Page Should Contain Element
    ...    css=.cd-btn--confirm

    Page Should Contain Element
    ...    css=.cd-btn--cancel
Confirm Booking In Modal
    [Documentation]    Nhấn nút xác nhận trong popup

    Wait Until Element Is Visible
    ...    css=.cd-modal
    ...    ${TIMEOUT}

    Click Element
    ...    css=.cd-btn--confirm

    Sleep    2s
Cancel Booking In Modal
    [Documentation]    Nhấn nút hủy trong popup

    Wait Until Element Is Visible
    ...    css=.cd-modal
    ...    ${TIMEOUT}

    Click Element
    ...    css=.cd-btn--cancel

    Wait Until Element Is Not Visible
    ...    css=.cd-modal
    ...    ${TIMEOUT}

Click Proceed To Booking
    [Documentation]    Chuyển từ chọn sân sang trang xác nhận đặt sân
    Wait Until Element Is Visible
    ...    ${SIDEBAR_PROCEED_BTN}
    ...    ${TIMEOUT}

    Scroll Element Into View
    ...    ${SIDEBAR_PROCEED_BTN}

    Click Element
    ...    ${SIDEBAR_PROCEED_BTN}

    Wait Until Page Contains
    ...    Xác nhận đặt sân
    ...    ${TIMEOUT}

Click Confirm Booking
    Wait Until Element Is Visible
    ...    ${BUTTON_CONFIRM_BOOKING}
    ...    ${TIMEOUT}

    Scroll Element Into View
    ...    ${BUTTON_CONFIRM_BOOKING}

    Click Element
    ...    ${BUTTON_CONFIRM_BOOKING}

Click Book Button
    Wait Until Element Is Visible
    ...    ${BUTTON_CONFIRM_BOOKING}
    ...    ${TIMEOUT}

    Scroll Element Into View
    ...    ${BUTTON_CONFIRM_BOOKING}

    Click Element
    ...    ${BUTTON_CONFIRM_BOOKING}

Confirm Booking

    Fill Booking Information

    Wait Until Element Is Visible
    ...    ${BUTTON_CONFIRM_BOOKING}
    ...    ${TIMEOUT}

    Click Element
    ...    ${BUTTON_CONFIRM_BOOKING}

    Sleep    3s

# Verification Keywords

Booking Should Be Successful
    Wait Until Page Contains
    ...    thành công
    ...    ${TIMEOUT}

Booking Should Fail With Error
    [Arguments]    ${error_message}

    Location Should Contain    /booking
    Page Should Contain Element    ${BUTTON_CONFIRM_BOOKING}

    IF    'điện thoại' in '${error_message}'
        ${phone}=    Get Value    ${FIELD_BOOKING_PHONE}
        ${valid_phone}=    Evaluate    len('''${phone}''') >= 10 and '''${phone}'''.startswith('0')
        Should Not Be True    ${valid_phone}
    ELSE
        ${field}=    Set Variable    ${FIELD_BOOKING_NAME}
        IF    'Email' in '${error_message}'
            ${field}=    Set Variable    ${FIELD_BOOKING_EMAIL}
        END

        ${element}=    Get WebElement    ${field}
        ${valid}=    Execute JavaScript
        ...    return arguments[0].checkValidity();
        ...    ARGUMENTS
        ...    ${element}
        Should Not Be True    ${valid}
    END

# Utility Keywords

Wait For Loading
    Wait Until Page Does Not Contain Element
    ...    xpath://div[@class='loading']
    ...    ${TIMEOUT}

Get Current Booking Status
    ${status}=    Get Text
    ...    xpath://div[@class='booking-status']

    RETURN    ${status}
