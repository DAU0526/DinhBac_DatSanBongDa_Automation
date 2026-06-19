*** Settings ***
Documentation    Compatibility resource. New tests should import config, testdata, and page objects directly.
Resource         ../config/environment.robot
Resource         ../testdata/booking_data.robot
Resource         ../pages/base_page.robot
Resource         ../pages/home_page.robot
Resource         ../pages/auth_page.robot
Resource         ../pages/fields_page.robot
Resource         ../pages/field_detail_page.robot
Resource         ../pages/booking_page.robot
Resource         ../pages/lookup_page.robot
Resource         ../pages/booking_history_page.robot
