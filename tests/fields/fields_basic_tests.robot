*** Settings ***
Documentation    Smoke Tests - Kiểm tra Chọn Sân Bóng
Library          SeleniumLibrary
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/keywords/pitch_selection_keywords.robot
Resource         ../../resources/common_variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
TC_PITCH_SMOKE_01: Danh Sách Sân Bóng Hiển Thị
    [Documentation]    Kiểm tra danh sách sân bóng có hiển thị
    [Tags]    smoke    pitch
    Navigate To Pitches Page
    Page Should Contain    Danh sách sân bóng
    Wait Until Page Contains Element    ${PITCH_CARD_CONTAINER}    ${TIMEOUT}

TC_PITCH_SMOKE_02: Có Thể Xem Sân Bóng
    [Documentation]    Kiểm tra có thể xem danh sách sân bóng
    [Tags]    smoke    pitch
    Navigate To Pitches Page
    View Available Pitches
    ${count}=    Get Pitch Count
    Should Be True    ${count} > 0

TC_PITCH_SMOKE_03: Có Thể Chọn Sân Bóng
    [Documentation]    Kiểm tra có thể click vào sân bóng
    [Tags]    smoke    pitch
    Navigate To Pitches Page
    View Available Pitches
    ${pitch_name}=    Get Pitch Name    1
    Select Pitch By Name    ${pitch_name}

TC_PITCH_SMOKE_04: Sân Bóng Hiển Thị Giá
    [Documentation]    Kiểm tra sân bóng có hiển thị giá
    [Tags]    smoke    pitch
    Navigate To Pitches Page
    View Available Pitches
    ${pitch_name}=    Get Pitch Name    1
    ${price}=    Get Pitch Price    ${pitch_name}
    Should Not Be Empty    ${price}

TC_PITCH_SMOKE_05: Sân Bóng Hiển Thị Kích Thước
    [Documentation]    Kiểm tra sân bóng có hiển thị kích thước
    [Tags]    smoke    pitch
    Navigate To Pitches Page
    View Available Pitches
    ${pitch_name}=    Get Pitch Name    1
    ${size}=    Get Pitch Size    ${pitch_name}
    Should Not Be Empty    ${size}

TC_PITCH_SMOKE_06: Có Thể Lọc Sân Theo Kích Thước
    [Documentation]    Kiểm tra có thể lọc sân theo kích thước
    [Tags]    smoke    pitch
    Navigate To Pitches Page
    Filter Pitches By Size    Sân 5 người
    Wait Until Page Contains Element    ${PITCH_CARD_CONTAINER}    ${TIMEOUT}

# Tạm thời disable vì HTML hiện tại chưa có chức năng sắp xếp giá

# TC_PITCH_SMOKE_07: Có Thể Sắp Xếp Sân Theo Giá
#     [Documentation]    Kiểm tra có thể sắp xếp sân theo giá
#     [Tags]    smoke    pitch
#     Navigate To Pitches Page
#     Sort Pitches By Price    Từ thấp đến cao
#     Wait Until Page Contains Element    ${PITCH_CARD_CONTAINER}    ${TIMEOUT}
