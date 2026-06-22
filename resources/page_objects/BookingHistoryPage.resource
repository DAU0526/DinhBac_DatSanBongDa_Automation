*** Settings ***
Library    SeleniumLibrary
Variables    ../locators/BookingHistoryPageLocators.py
Resource   ../common_variables.robot

*** Keywords ***
Open My Bookings Page
    Go To    ${URL}/my-bookings
    Wait Until Page Contains    Lịch sử đặt sân    ${TIMEOUT}
