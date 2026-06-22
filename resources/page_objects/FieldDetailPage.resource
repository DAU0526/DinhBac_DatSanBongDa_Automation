*** Settings ***
Library    SeleniumLibrary
Variables    ../locators/FieldDetailPageLocators.py
Resource   ../common_variables.robot

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
