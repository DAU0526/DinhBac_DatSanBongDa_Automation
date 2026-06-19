*** Settings ***
Library    SeleniumLibrary
Resource   ../config/environment.robot

*** Variables ***
${TIMESLOT_LIST}                xpath://div[contains(@class,'fd-slots')]
${TIMESLOT_ITEM}                xpath://div[contains(@class,'fd-slot')]
${TIMESLOT_AVAILABLE}           xpath://button[contains(@class,'bf-slot-btn') and not(contains(@class,'booked'))]
${TIMESLOT_BOOKED}              xpath://button[contains(@class,'bf-slot-btn') and contains(@class,'booked')]
${TIMESLOT_SELECTED}            xpath://button[contains(@class,'bf-slot-btn') and contains(@class,'selected')]
${TIMESLOT_GRID}                xpath://div[contains(@class,'bf-slots-grid')]
${SLOT_TIME_LABEL}              xpath://span[@class='slot-time']
${SLOT_PRICE_LABEL}             xpath://span[@class='slot-price']
${SCHEDULE_DATE_LABEL}          xpath://p[contains(@class,'fd-schedule-date')]
${SIDEBAR_TIMESLOT_DISPLAY}     xpath://*[contains(@class,'fd-sidebar')]//span[contains(@class,'text-slate-900') and contains(@class,'font-semibold')]
${SIDEBAR_TOTAL_PRICE}          xpath://aside[contains(@class,'fd-sidebar')]//div[contains(@class,'font-bold')]//span[contains(@class,'text-primary')]
${SIDEBAR_PROCEED_BTN}          xpath://*[contains(@class,'fd-sidebar')]//a[contains(@href, '/booking')]
${SIDEBAR_SERVICE_PRICE}        xpath://aside[contains(@class,'fd-sidebar')]//*[contains(text(),'Dịch vụ thêm')]/following-sibling::span
${SERVICES_SECTION}             xpath://div[contains(@class,'service-section')]
${SERVICES_LIST}                xpath://div[contains(@class,'ss-grid')]
${SERVICE_CARD}                 xpath://div[contains(@class,'ss-card')]
${SERVICE_NAME_LABEL}           xpath://p[contains(@class,'ss-name')]
${SERVICE_PRICE_LABEL}          xpath://p[contains(@class,'ss-price')]
${SERVICE_QTY_LABEL}            xpath://span[contains(@class,'ss-qty')]
${SERVICE_BTN_PLUS}             xpath://button[contains(@class,'ss-btn-plus')]
${SERVICE_BTN_MINUS}            xpath://button[contains(@class,'ss-btn-minus')]
${SERVICE_NAME_GIAY}            Giày
${SERVICE_NAME_NUOC}            Nước

*** Keywords ***
Open Time Slot Picker
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${TIMESLOT_GRID}
    Run Keyword If    not ${is_visible}    Click Element    ${SIDEBAR_TIMESLOT_DISPLAY}
    Wait Until Element Is Visible    ${TIMESLOT_GRID}    ${TIMEOUT}

Choose First Available Time Slot
    Open Time Slot Picker
    Wait Until Element Is Visible    ${TIMESLOT_AVAILABLE}    ${TIMEOUT}
    Click Element    ${TIMESLOT_AVAILABLE}

Proceed From Field Detail To Booking
    Wait Until Element Is Visible    ${SIDEBAR_PROCEED_BTN}    ${TIMEOUT}
    Scroll Element Into View    ${SIDEBAR_PROCEED_BTN}
    Click Element    ${SIDEBAR_PROCEED_BTN}
    Wait Until Page Contains    Xác nhận đặt sân    ${TIMEOUT}
