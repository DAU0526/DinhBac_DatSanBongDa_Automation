*** Settings ***
Library    SeleniumLibrary
Library    ../locators/FieldsPageLocators.py    WITH NAME    fields_locators
Resource   ../common_variables.robot

*** Keywords ***
Open Fields Page
    Go To    ${URL}/fields
    Wait Until Element Is Visible    xpath=(//a[contains(text(),'Xem chi tiết')])[1]    20s
    Scroll Element Into View    xpath=(//a[contains(text(),'Xem chi tiết')])[1]

Open First Field Detail
    Wait Until Element Is Visible    xpath=(//a[contains(text(),'Xem chi tiết')])[1]    ${TIMEOUT}
    Click Element    xpath=(//a[contains(text(),'Xem chi tiết')])[1]
    Wait Until Location Contains    /fields/    ${TIMEOUT}
