*** Settings ***
Library    SeleniumLibrary
Resource   ../config/environment.robot

*** Variables ***
${BOOKING_HISTORY_CONTAINER}    xpath=//div[contains(@class,'my-bookings') or contains(@class,'booking-history') or contains(@class,'booking-list')]
${BOOKING_HISTORY_ITEM}         xpath=//div[contains(@class,'booking-card') or contains(@class,'booking-item') or contains(@class,'order-card') or contains(@class,'history-item')]
${BOOKING_HISTORY_FIELD_NAME}   xpath=(//div[contains(@class,'booking-card') or contains(@class,'booking-item') or contains(@class,'order-card') or contains(@class,'history-item')])[1]//*[contains(@class,'field-name') or contains(@class,'pitch-name') or contains(@class,'san-name') or self::h3 or self::h4 or self::h5]
${BOOKING_HISTORY_DATE}         xpath=(//div[contains(@class,'booking-card') or contains(@class,'booking-item') or contains(@class,'order-card') or contains(@class,'history-item')])[1]//*[contains(@class,'booking-date') or contains(@class,'date') or contains(text(),'Ngày') or contains(text(),'ngày')]
${BOOKING_HISTORY_TIME_SLOT}    xpath=(//div[contains(@class,'booking-card') or contains(@class,'booking-item') or contains(@class,'order-card') or contains(@class,'history-item')])[1]//*[contains(@class,'time') or contains(@class,'slot') or contains(text(),':')]
${BOOKING_HISTORY_STATUS}       xpath=(//div[contains(@class,'booking-card') or contains(@class,'booking-item') or contains(@class,'order-card') or contains(@class,'history-item')])[1]//*[contains(@class,'status') or contains(@class,'badge') or contains(@class,'tag')]

*** Keywords ***
Open My Bookings Page
    Go To    ${URL}/my-bookings
    Wait Until Page Contains    Lịch sử đặt sân    ${TIMEOUT}
