"""Locators for Authentication Page"""
class AuthPageLocators:
    # Login Form
    FIELD_LOGIN_EMAIL = "xpath://input[@placeholder='name@example.com']"
    FIELD_LOGIN_PASSWORD = "xpath://input[@placeholder='Nhập mật khẩu']"
    BUTTON_LOGIN = "xpath://button[contains(@class, 'login-button')]"
    BUTTON_GOOGLE_LOGIN = "xpath://button[contains(@class, 'google-login')]"
    BUTTON_FACEBOOK_LOGIN = "xpath://button[contains(@class, 'facebook-login')]"
    LINK_REGISTER = "xpath://a[@href='/register']"
    
    # Register Form
    FIELD_REGISTER_NAME = "xpath://input[@id='fullname']"
    FIELD_REGISTER_USERNAME = "xpath://input[@id='fullname']"
    FIELD_REGISTER_EMAIL = "xpath://input[@id='email']"
    FIELD_REGISTER_PHONE = "xpath://input[@id='phone']"
    FIELD_REGISTER_PASSWORD = "xpath://input[@id='password']"
    FIELD_REGISTER_PASSWORD_CONFIRM = "xpath://input[@id='confirmPassword']"
    BUTTON_REGISTER = "xpath://button[@type='submit']"
    LINK_LOGIN = "xpath://a[@href='/login']"
