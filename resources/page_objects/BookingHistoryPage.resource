*** Settings ***
Library    SeleniumLibrary
Library    ../locators/BookingHistoryPageLocators.py    WITH NAME    booking_history_locators
Resource   ../common_variables.robot

*** Keywords ***
Open My Bookings Page
    Go To    ${URL}/my-bookings
    Wait Until Page Contains    Lịch sử đặt sân    ${TIMEOUT}
