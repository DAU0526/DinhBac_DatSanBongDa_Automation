"""Locators for Lookup Page"""
class LookupPageLocators:
    LOOKUP_INPUT = "css=input.input-field"
    LOOKUP_BUTTON = "css=button.btn-lookup-now"
    LOOKUP_RESULT_SUCCESS = "xpath=//*[contains(@class,'lookup-result') or contains(@class,'result-card') or contains(@class,'booking-result') or contains(@class,'order-detail')]"
    LOOKUP_RESULT_NOT_FOUND = "xpath=//*[contains(text(),'không tìm thấy') or contains(text(),'Không tìm thấy') or contains(text(),'không tồn tại') or contains(@class,'not-found') or contains(@class,'error-msg')]"

lookup_locators = LookupPageLocators()
