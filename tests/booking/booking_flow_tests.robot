*** Settings ***
Documentation    Regression Test - Booking
Resource         ../../resources/keywords/booking_keywords.robot

Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***

TC_BOOKING_REG_01
    Navigate To Pitches Page

    Wait Until Page Contains Element    xpath=//a[contains(@href,'/fields')]    10s

    Click Element    xpath=//a[contains(.,'Xem chi tiết')]

    Wait Until Page Contains    Lịch đặt sân    10s

    Click Element    xpath=//div[contains(@class,'fd-slot--available') and .//span[text()='06:00']]

    Click Element    xpath=//a[contains(.,'Tiến hành đặt sân')]

    Wait Until Page Contains    Xác nhận đặt sân    10s

    Click Element    xpath=//button[contains(.,'XÁC NHẬN ĐẶT SÂN')]

    Wait Until Page Contains    thành công    10s


TC_BOOKING_REG_02
    Navigate To Pitches Page

    Click Element    xpath=//a[contains(.,'Xem chi tiết')]

    Click Element    xpath=//a[contains(.,'Tiến hành đặt sân')]

    Page Should Contain    Xác nhận đặt sân
    Page Should Contain    Thông tin khách hàng


TC_BOOKING_REG_03
    Navigate To Pitches Page

    Click Element    xpath=//a[contains(.,'Xem chi tiết')]

    Page Should Contain    Lịch đặt sân
    Page Should Contain    Thông tin đặt sân


TC_BOOKING_REG_04
    Navigate To Pitches Page

    Click Element    xpath=//a[contains(.,'Xem chi tiết')]

    Page Should Contain Element    xpath=//a[contains(.,'Tiến hành đặt sân')]
