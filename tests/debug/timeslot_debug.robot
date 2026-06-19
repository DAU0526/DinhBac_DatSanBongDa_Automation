*** Settings ***
Library          SeleniumLibrary
Library          OperatingSystem
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/keywords/timeslot_keywords.robot
Resource         ../../resources/variables/variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
Debug Timeslot Selection
    Navigate To Field Detail Page
    Wait Until Element Is Visible    ${SIDEBAR_TIMESLOT_DISPLAY}    ${TIMEOUT}
    Click Element    ${SIDEBAR_TIMESLOT_DISPLAY}
    Sleep    2s
    Capture Page Screenshot    ${OUTPUT DIR}${/}after_sidebar_click.png
    ${html}=    Get Source
    Create File    ${OUTPUT DIR}${/}after_sidebar_click.html    ${html}
