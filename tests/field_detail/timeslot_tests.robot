*** Settings ***
Documentation    Regression Tests - Kiểm tra Chi Tiết Khung Giờ Trên Trang Chi Tiết Sân
Library          SeleniumLibrary
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/keywords/timeslot_keywords.robot
Resource         ../../resources/variables/variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
TC_TIME_REG_01: Trang Chi Tiết Sân Hiển Thị Đầy Đủ Lịch Đặt Sân
    [Documentation]    Kiểm tra trang chi tiết sân có đủ các thành phần:
    ...                fd-slots, slot-time, slot-price, tiêu đề "Lịch đặt sân", ngày hiển thị
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    Page Should Contain    Lịch đặt sân
    Wait Until Page Contains Element    ${TIMESLOT_LIST}    ${TIMEOUT}
    Page Should Contain Element    ${SLOT_TIME_LABEL}
    Page Should Contain Element    ${SLOT_PRICE_LABEL}
    Page Should Contain Element    ${SCHEDULE_DATE_LABEL}

TC_TIME_REG_02: Số Lượng Khung Giờ Trống Lớn Hơn 0
    [Documentation]    Kiểm tra sân có ít nhất 1 fd-slot--available khi vào trang
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    ${count}=    Get Timeslot Count
    Should Be True    ${count} > 0    Phải có ít nhất 1 khung giờ còn trống

TC_TIME_REG_03: Chọn Khung Giờ Thay Đổi Trạng Thái Slot Thành Selected
    [Documentation]    Kiểm tra slot chuyển từ class fd-slot--available sang fd-slot--selected khi click
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    Select First Available Time Slot
    Open Time Slot Selection
    Page Should Contain Element    ${TIMESLOT_SELECTED}
    Page Should Not Contain Element
    ...    xpath://div[contains(@class,'fd-slot--selected') and contains(@class,'fd-slot--available')]

TC_TIME_REG_04: Chọn Slot Cụ Thể 14:00 Và Xác Nhận Được Chọn
    [Documentation]    Kiểm tra chọn slot 14:00 → class fd-slot--selected có span 14:00
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    Time Slot Should Be Available    14:00
    Select Time Slot By Time    14:00
    Open Time Slot Selection
    Time Slot Should Be Selected    14:00

TC_TIME_REG_05: Chọn Slot Cụ Thể 19:00 Và Xác Nhận Được Chọn
    [Documentation]    Kiểm tra chọn slot giờ cao điểm 19:00 → xác nhận selected
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    Time Slot Should Be Available    19:00
    Select Time Slot By Time    19:00
    Open Time Slot Selection
    Time Slot Should Be Selected    19:00

TC_TIME_REG_06: Giá Khung Giờ 14:00 Không Rỗng
    [Documentation]    Kiểm tra span.slot-price của slot 14:00 có nội dung
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    ${price}=    Get Time Slot Price    14:00
    Should Not Be Empty    ${price}

TC_TIME_REG_07: Giá Khung Giờ 19:00 Không Rỗng
    [Documentation]    Kiểm tra span.slot-price của slot giờ cao điểm 19:00 có nội dung
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    ${price}=    Get Time Slot Price    19:00
    Should Not Be Empty    ${price}

TC_TIME_REG_08: Sidebar Hiển Thị Thông Tin Sau Khi Chọn Slot
    [Documentation]    Kiểm tra sidebar "Thông tin đặt sân" thay đổi từ "Chưa chọn" sang thông tin giờ thực tế
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    # Trước khi chọn: sidebar hiển thị "Chưa chọn"
    Element Should Contain    ${SIDEBAR_TIMESLOT_DISPLAY}    Chưa chọn
    # Sau khi chọn: sidebar phải cập nhật, không còn "Chưa chọn"
    Select First Available Time Slot
    Sidebar Should Show Selected Time

TC_TIME_REG_09: Nút Đặt Sân Disabled Khi Chưa Chọn Khung Giờ
    [Documentation]    Kiểm tra nút "Tiến hành đặt sân" có class cursor-not-allowed khi chưa chọn slot
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    Proceed Button Should Be Inactive

TC_TIME_REG_10: Nút Đặt Sân Active Sau Khi Chọn Khung Giờ
    [Documentation]    Kiểm tra nút "Tiến hành đặt sân" mất class cursor-not-allowed sau khi chọn slot
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    Select First Available Time Slot
    Proceed Button Should Be Active

TC_TIME_REG_11: Slot Đã Booked Không Thể Chọn
    [Documentation]    Kiểm tra slot mang class fd-slot--booked không thể click thành selected
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    ${booked_count}=    Get Element Count    ${TIMESLOT_BOOKED}
    IF    ${booked_count} > 0
        ${booked_time}=    Get Text
        ...    xpath:(//div[contains(@class,'fd-slot--booked')]//span[@class='slot-time'])[1]
        Time Slot Should Be Booked    ${booked_time}
        Time Slot Should Not Be Available    ${booked_time}
    ELSE
        Log    Không có slot đã đặt trên sân này — bỏ qua kiểm tra    WARN
    END

TC_TIME_REG_12: Chọn Slot Theo Vị Trí Index 0 Thành Công
    [Documentation]    Kiểm tra chọn slot bằng index (dành cho automation chọn ngẫu nhiên)
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    Select Time Slot By Index    0
    Open Time Slot Selection
    Page Should Contain Element    ${TIMESLOT_SELECTED}

TC_TIME_REG_13: Thông Tin Giá Tổng Cộng Cập Nhật Sau Khi Chọn Slot
    [Documentation]    Kiểm tra tổng tiền trong sidebar không còn hiển thị "—" sau khi chọn slot
    [Tags]    regression    timeslot
    Navigate To Field Detail Page
    Select First Available Time Slot
    ${total}=    Get Booking Total Price
    Should Not Be Empty    ${total}
