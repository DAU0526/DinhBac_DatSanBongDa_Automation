*** Settings ***
Library    SeleniumLibrary
Library    ../locators/FieldDetailPageLocators.py    WITH NAME    field_detail_locators
Resource   ../common_variables.robot

*** Keywords ***
Open Time Slot Picker
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${field_detail_locators.TIMESLOT_GRID}
    Run Keyword If    not ${is_visible}    Click Element    ${field_detail_locators.SIDEBAR_TIMESLOT_DISPLAY}
    Wait Until Element Is Visible    ${field_detail_locators.TIMESLOT_GRID}    ${TIMEOUT}

Choose First Available Time Slot
    Open Time Slot Picker
    Wait Until Element Is Visible    ${field_detail_locators.TIMESLOT_AVAILABLE}    ${TIMEOUT}
    Click Element    ${field_detail_locators.TIMESLOT_AVAILABLE}

Proceed From Field Detail To Booking
    Wait Until Element Is Visible    ${field_detail_locators.SIDEBAR_PROCEED_BTN}    ${TIMEOUT}
    Scroll Element Into View    ${field_detail_locators.SIDEBAR_PROCEED_BTN}
    Click Element    ${field_detail_locators.SIDEBAR_PROCEED_BTN}
    Wait Until Page Contains    Xác nhận đặt sân    ${TIMEOUT}
