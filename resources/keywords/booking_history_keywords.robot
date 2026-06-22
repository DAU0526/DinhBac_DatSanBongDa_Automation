*** Settings ***
Library    SeleniumLibrary
Library    ../locators/BasePageLocators.py    WITH NAME    base_locators
Library    ../locators/AuthPageLocators.py    WITH NAME    auth_locators
Library    ../locators/BookingHistoryPageLocators.py    WITH NAME    booking_history_locators
Resource   ../common_variables.robot
Resource   ../common_variables.robot
Resource   ../page_objects/BasePage.resource
Resource   ../page_objects/AuthPage.resource
Resource   ../page_objects/BookingHistoryPage.resource

*** Keywords ***

# ========================= NAVIGATION =========================
Navigate To My Bookings Page
    [Documentation]    Điều hướng tới trang Lịch sử đặt sân (yêu cầu đã đăng nhập)
    Go To    ${URL}/my-bookings
    Sleep    2s
    Wait Until Page Contains    Lịch sử đặt sân    ${TIMEOUT}

Navigate To My Bookings Via Nav
    [Documentation]    Điều hướng tới trang Lịch sử đặt sân qua menu điều hướng
    Wait Until Element Is Visible    ${base_locators.NAV_MY_BOOKINGS}    ${TIMEOUT}
    Click Element    ${base_locators.NAV_MY_BOOKINGS}
    Sleep    2s
    Wait Until Page Contains    Lịch sử đặt sân    ${TIMEOUT}

# ========================= LOGIN FOR BOOKING HISTORY =========================
Login As Booking User
    [Documentation]    Đăng nhập bằng tài khoản có lịch sử đặt sân
    Go To    ${URL}/login
    Wait Until Page Contains    Đăng nhập    ${TIMEOUT}
    Wait Until Element Is Visible    ${auth_locators.FIELD_LOGIN_EMAIL}    ${TIMEOUT}
    Input Text    ${auth_locators.FIELD_LOGIN_EMAIL}    ${BOOKING_HISTORY_PHONE}
    Input Text    ${auth_locators.FIELD_LOGIN_PASSWORD}    ${BOOKING_HISTORY_PASSWORD}
    Click Element    ${auth_locators.BUTTON_LOGIN}
    Sleep    3s

Login Should Succeed And Redirect
    [Documentation]    Kiểm tra đăng nhập thành công và chuyển trang
    ${current_url}=    Get Location
    Should Not Contain    ${current_url}    /login

# ========================= BOOKING HISTORY PAGE VERIFICATION =========================
Booking History Page Should Be Displayed
    [Documentation]    Kiểm tra trang Lịch sử đặt sân hiển thị đúng
    Location Should Contain    my-bookings
    Page Should Contain    Lịch sử đặt sân

Booking Orders Should Be Visible
    [Documentation]    Kiểm tra có ít nhất 1 đơn đặt sân hiển thị
    Wait Until Element Is Visible
    ...    ${booking_history_locators.BOOKING_HISTORY_ITEM}
    ...    ${TIMEOUT}
    ${count}=    Get Element Count    ${booking_history_locators.BOOKING_HISTORY_ITEM}
    Should Be True    ${count} > 0
    ...    msg=Không tìm thấy đơn đặt sân nào trong lịch sử

Booking History Should Have Items
    [Documentation]    Kiểm tra danh sách lịch sử đặt sân không trống
    ${items}=    Get WebElements    ${booking_history_locators.BOOKING_HISTORY_ITEM}
    ${count}=    Get Length    ${items}
    Should Be True    ${count} > 0
    ...    msg=Danh sách lịch sử đặt sân trống
    Log    Tìm thấy ${count} đơn đặt sân trong lịch sử

# ========================= FIELD NAME VERIFICATION =========================
Booking History Should Show Field Name
    [Documentation]    Kiểm tra tên sân hiển thị trong đơn đặt sân
    Wait Until Element Is Visible
    ...    ${booking_history_locators.BOOKING_HISTORY_FIELD_NAME}
    ...    ${TIMEOUT}
    ${field_name}=    Get Text    ${booking_history_locators.BOOKING_HISTORY_FIELD_NAME}
    Should Not Be Empty    ${field_name}
    ...    msg=Tên sân không được hiển thị
    Log    Tên sân: ${field_name}

All Booking Items Should Have Field Name
    [Documentation]    Kiểm tra tất cả đơn đặt sân đều có tên sân
    ${items}=    Get WebElements    ${booking_history_locators.BOOKING_HISTORY_FIELD_NAME}
    FOR    ${item}    IN    @{items}
        ${text}=    Get Text    ${item}
        Should Not Be Empty    ${text}
        ...    msg=Có đơn đặt sân không hiển thị tên sân
    END

# ========================= BOOKING DATE VERIFICATION =========================
Booking History Should Show Booking Date
    [Documentation]    Kiểm tra ngày đặt hiển thị trong đơn đặt sân
    Wait Until Element Is Visible
    ...    ${booking_history_locators.BOOKING_HISTORY_DATE}
    ...    ${TIMEOUT}
    ${date_text}=    Get Text    ${booking_history_locators.BOOKING_HISTORY_DATE}
    Should Not Be Empty    ${date_text}
    ...    msg=Ngày đặt không được hiển thị
    Log    Ngày đặt: ${date_text}

All Booking Items Should Have Date
    [Documentation]    Kiểm tra tất cả đơn đặt sân đều có ngày đặt
    ${items}=    Get WebElements    ${booking_history_locators.BOOKING_HISTORY_DATE}
    FOR    ${item}    IN    @{items}
        ${text}=    Get Text    ${item}
        Should Not Be Empty    ${text}
        ...    msg=Có đơn đặt sân không hiển thị ngày đặt
    END

# ========================= TIME SLOT VERIFICATION =========================
Booking History Should Show Time Slot
    [Documentation]    Kiểm tra khung giờ hiển thị trong đơn đặt sân
    Wait Until Element Is Visible
    ...    ${booking_history_locators.BOOKING_HISTORY_TIME_SLOT}
    ...    ${TIMEOUT}
    ${time_text}=    Get Text    ${booking_history_locators.BOOKING_HISTORY_TIME_SLOT}
    Should Not Be Empty    ${time_text}
    ...    msg=Khung giờ không được hiển thị
    Log    Khung giờ: ${time_text}

All Booking Items Should Have Time Slot
    [Documentation]    Kiểm tra tất cả đơn đặt sân đều có khung giờ
    ${items}=    Get WebElements    ${booking_history_locators.BOOKING_HISTORY_TIME_SLOT}
    FOR    ${item}    IN    @{items}
        ${text}=    Get Text    ${item}
        Should Not Be Empty    ${text}
        ...    msg=Có đơn đặt sân không hiển thị khung giờ
    END

# ========================= STATUS VERIFICATION =========================
Booking History Should Show Status
    [Documentation]    Kiểm tra trạng thái hiển thị trong đơn đặt sân
    Wait Until Element Is Visible
    ...    ${booking_history_locators.BOOKING_HISTORY_STATUS}
    ...    ${TIMEOUT}
    ${status_text}=    Get Text    ${booking_history_locators.BOOKING_HISTORY_STATUS}
    Should Not Be Empty    ${status_text}
    ...    msg=Trạng thái không được hiển thị
    Log    Trạng thái: ${status_text}

All Booking Items Should Have Status
    [Documentation]    Kiểm tra tất cả đơn đặt sân đều có trạng thái
    ${items}=    Get WebElements    ${booking_history_locators.BOOKING_HISTORY_STATUS}
    FOR    ${item}    IN    @{items}
        ${text}=    Get Text    ${item}
        Should Not Be Empty    ${text}
        ...    msg=Có đơn đặt sân không hiển thị trạng thái
    END

Status Should Be Valid
    [Documentation]    Kiểm tra trạng thái thuộc danh sách hợp lệ
    ${status_text}=    Get Text    ${booking_history_locators.BOOKING_HISTORY_STATUS}
    ${valid_statuses}=    Create List    Chờ xác nhận    Đã xác nhận    Đã hủy    Hoàn thành    Pending    Confirmed    Cancelled    Completed
    Should Contain Any    ${status_text}    @{valid_statuses}
    ...    msg=Trạng thái '${status_text}' không hợp lệ

# ========================= COMPLETE BOOKING INFO VERIFICATION =========================
First Booking Should Have Complete Info
    [Documentation]    Kiểm tra đơn đặt sân đầu tiên có đầy đủ thông tin
    ${field_name}=    Get Text    ${booking_history_locators.BOOKING_HISTORY_FIELD_NAME}
    ${date}=          Get Text    ${booking_history_locators.BOOKING_HISTORY_DATE}
    ${time_slot}=     Get Text    ${booking_history_locators.BOOKING_HISTORY_TIME_SLOT}
    ${status}=        Get Text    ${booking_history_locators.BOOKING_HISTORY_STATUS}

    Should Not Be Empty    ${field_name}    msg=Thiếu tên sân
    Should Not Be Empty    ${date}          msg=Thiếu ngày đặt
    Should Not Be Empty    ${time_slot}     msg=Thiếu khung giờ
    Should Not Be Empty    ${status}        msg=Thiếu trạng thái

    Log    ============ THÔNG TIN ĐƠN ĐẶT SÂN ============
    Log    Tên sân   : ${field_name}
    Log    Ngày đặt  : ${date}
    Log    Khung giờ : ${time_slot}
    Log    Trạng thái: ${status}
    Log    ================================================

Get All Booking Info And Log
    [Documentation]    Lấy và log toàn bộ thông tin lịch sử đặt sân
    ${field_names}=    Get WebElements    ${booking_history_locators.BOOKING_HISTORY_FIELD_NAME}
    ${dates}=          Get WebElements    ${booking_history_locators.BOOKING_HISTORY_DATE}
    ${time_slots}=     Get WebElements    ${booking_history_locators.BOOKING_HISTORY_TIME_SLOT}
    ${statuses}=       Get WebElements    ${booking_history_locators.BOOKING_HISTORY_STATUS}

    ${count}=    Get Length    ${field_names}
    Log    ========== TOÀN BỘ LỊCH SỬ ĐẶT SÂN (${count} đơn) ==========
    FOR    ${i}    IN RANGE    ${count}
        ${name}=    Get Text    ${field_names}[${i}]
        ${date}=    Get Text    ${dates}[${i}]
        ${slot}=    Get Text    ${time_slots}[${i}]
        ${status}=  Get Text    ${statuses}[${i}]
        Log    Đơn ${i+1}: Sân=${name} | Ngày=${date} | Giờ=${slot} | TT=${status}
    END
