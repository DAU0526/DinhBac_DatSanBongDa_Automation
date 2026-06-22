*** Settings ***
Documentation    Regression Tests - Kiểm tra Chọn Sân Bóng
Library          SeleniumLibrary
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/keywords/pitch_selection_keywords.robot
Resource         ../../resources/common_variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***

TC_PITCH_REG_01: Có Thể Xem Tất Cả Sân Bóng Có Sẵn
    [Documentation]    Kiểm tra danh sách sân bóng có ít nhất 1 sân
    [Tags]    regression    pitch

    Navigate To Pitches Page
    View Available Pitches

    ${count}=    Get Pitch Count
    Should Be True    ${count} >= 1

TC_PITCH_REG_02: Thông Tin Sân Bóng Đầy Đủ
    [Documentation]    Kiểm tra sân bóng hiển thị tên, giá, loại sân
    [Tags]    regression    pitch

    Navigate To Pitches Page
    View Available Pitches

    ${pitch_name}=    Get Pitch Name    1
    ${price}=         Get Pitch Price    ${pitch_name}
    ${size}=          Get Pitch Size     ${pitch_name}

    Should Not Be Empty    ${pitch_name}
    Should Not Be Empty    ${price}
    Should Not Be Empty    ${size}

TC_PITCH_REG_03: Có Thể Chọn Sân Cụ Thể
    [Documentation]    Kiểm tra chọn sân bóng cụ thể
    [Tags]    regression    pitch

    Navigate To Pitches Page
    View Available Pitches

    ${pitch_name}=    Get Pitch Name    1

    Select Pitch By Name    ${pitch_name}

TC_PITCH_REG_04: Lọc Sân Theo Kích Thước Hoạt Động
    [Documentation]    Kiểm tra lọc sân theo kích thước
    [Tags]    regression    pitch

    Navigate To Pitches Page

    Filter Pitches By Size    Sân 5 người

    ${count}=    Get Pitch Count
    Should Be True    ${count} > 0

TC_PITCH_REG_05: Có Thể Xem Chi Tiết Sân Bóng
    [Documentation]    Kiểm tra xem chi tiết sân bóng
    [Tags]    regression    pitch

    Navigate To Pitches Page
    View Available Pitches

    ${pitch_name}=    Get Pitch Name    1

    View Pitch Details    ${pitch_name}

    Location Should Contain    /fields/

TC_PITCH_REG_06: Phân Trang Hiển Thị
    [Documentation]    Kiểm tra nút phân trang tồn tại
    [Tags]    regression    pitch

    Navigate To Pitches Page

    Page Should Contain Element    ${PAGINATION_BTN_1}

TC_PITCH_REG_07: Tab Sân 7 Người Hoạt Động
    [Documentation]    Kiểm tra tab sân 7 người
    [Tags]    regression    pitch

    Navigate To Pitches Page

    Filter Pitches By Size    Sân 7 người

    Sleep    1s

TC_PITCH_REG_08: Tab Sân 11 Người Hoạt Động
    [Documentation]    Kiểm tra tab sân 11 người
    [Tags]    regression    pitch

    Navigate To Pitches Page

    Filter Pitches By Size    Sân 11 người

    Sleep    1s

# TẠM THỜI DISABLE
# HTML hiện tại chưa có chức năng sort giá

# TC_PITCH_REG_09: Sắp Xếp Sân Theo Giá Thấp Đến Cao
# TC_PITCH_REG_10: Sắp Xếp Sân Theo Giá Cao Đến Thấp
