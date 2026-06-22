"""Locators for Home Page"""
class HomePageLocators:
    BTN_BOOK_NOW_HERO = "xpath://a[contains(., 'Đặt sân ngay')] | xpath://link[contains(@href, '/booking')]"
    BTN_VIEW_ALL_FIELDS = "xpath://a[contains(text(), 'Xem danh sách sân')] | xpath://a[contains(text(), 'Xem tất cả')]"
    HOME_LOCATION_SELECT = "xpath://select | xpath://combobox[contains(text(), 'Tất cả')]"
    HOME_TYPE_SELECT = "xpath://select[2] | xpath://combobox[contains(text(), 'Loại sân')]"
    HOME_DATE_INPUT = "xpath://input[@type='date' or @type='text'][contains(@placeholder, 'date' or 'ngày')]"
    HOME_SEARCH_BTN = "xpath://button[contains(text(), 'Tìm sân')]"

home_locators = HomePageLocators()
