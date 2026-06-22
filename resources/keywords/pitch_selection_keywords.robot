*** Settings ***
Library    SeleniumLibrary
Resource   ../common_variables.robot
Variables    ../locators/FieldsPageLocators.py
Resource   ../page_objects/FieldsPage.resource
Resource   ../booking_keywords.robot

*** Keywords ***
# Pitch Selection Keywords

View Available Pitches
    [Documentation]    Xem danh sách các sân bóng có sẵn
    Navigate To Pitches Page
    Wait Until Page Contains    Danh sách sân bóng    ${TIMEOUT}
    Page Should Contain Element    xpath=//div[contains(@class,'fields-grid')]

    Capture Page Screenshot

Get Pitch Count
    [Documentation]    Lấy số lượng sân bóng
    ${count}=    Get Element Count    xpath=//div[contains(@class,'fields-grid')]/div
    RETURN    ${count}

Select Pitch By Index
    [Arguments]    ${index}
    [Documentation]    Chọn sân bóng theo vị trí
    Click Element    xpath=(//div[contains(@class,'fields-grid')]//a[contains(text(),'Xem chi tiết')])[${index}]
    Wait Until Location Contains    /fields/    ${TIMEOUT}

    Capture Page Screenshot

Select Pitch By Name
    [Arguments]    ${pitch_name}
    [Documentation]    Chọn sân bóng theo tên
    Click Element    xpath=//h5[contains(text(),'${pitch_name}')]/ancestor::div[contains(@class,'p-6')]//a[contains(text(),'Xem chi tiết')]
    Wait Until Location Contains    /fields/    ${TIMEOUT}

    Capture Page Screenshot

Get Pitch Name
    [Arguments]    ${index}
    [Documentation]    Lấy tên sân bóng theo vị trí
    ${name}=    Get Text    xpath=(//div[contains(@class,'fields-grid')]//h5)[${index}]
    RETURN    ${name}

Get Pitch Price
    [Arguments]    ${pitch_name}
    [Documentation]    Lấy giá sân bóng
    ${price}=    Get Text    xpath=//h5[contains(text(),'${pitch_name}')]/ancestor::div[contains(@class,'p-6')]//span[contains(@class,'text-primary')]
    RETURN    ${price}

Get Pitch Size
    [Arguments]    ${pitch_name}
    [Documentation]    Lấy loại sân (5vs5, 7vs7, 11vs11)
    ${size}=    Get Text    xpath=//h5[contains(text(),'${pitch_name}')]/ancestor::div[contains(@class,'bg-white')]//div[contains(text(),'vs')]
    RETURN    ${size}

Pitch Should Be Available
    [Arguments]    ${pitch_name}
    [Documentation]    Kiểm tra sân bóng tồn tại
    Page Should Contain Element    xpath=//h5[contains(text(),'${pitch_name}')]

Pitch Should Not Be Available
    [Arguments]    ${pitch_name}
    [Documentation]    Kiểm tra sân bóng không tồn tại
    Page Should Not Contain Element    xpath=//h5[contains(text(),'${pitch_name}')]

View Pitch Details
    [Arguments]    ${pitch_name}
    [Documentation]    Xem chi tiết sân bóng
    Click Element    xpath=//h5[contains(text(),'${pitch_name}')]/ancestor::div[contains(@class,'p-6')]//a[contains(text(),'Xem chi tiết')]
    Wait Until Location Contains    /fields/    ${TIMEOUT}

    Capture Page Screenshot

Filter Pitches By Size
    [Arguments]    ${size}
    [Documentation]    Lọc theo tab loại sân
    Click Element    xpath=//button[contains(@class,'fields-tab') and contains(text(),'${size}')]
    Sleep    1s

    Capture Page Screenshot

Sort Pitches By Price
    [Arguments]    ${sort_order}
    [Documentation]    Chưa tìm thấy control sort trong HTML hiện tại
    Log    Chức năng Sort Pitches By Price cần kiểm tra thêm HTML thực tế
