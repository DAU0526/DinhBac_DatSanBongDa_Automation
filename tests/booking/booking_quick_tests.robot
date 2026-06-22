*** Settings ***
Documentation    Smoke Test - Đặt sân bóng
Library          SeleniumLibrary
Resource         ../../resources/keywords/booking_keywords.robot

Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
TC_SMOKE_BOOKING_01
    Navigate To Pitches Page

    Click Element
    ...    xpath=(//a[contains(.,'Xem chi tiết')])[1]

    Wait Until Page Contains
    ...    Lịch đặt sân
    ...    20s
    Select First Time Slot And Proceed To Booking

    Click Button
    ...    xpath=//button[contains(@class,'bk-submit-btn')]

    Sleep    3s

    Capture Page Screenshot
