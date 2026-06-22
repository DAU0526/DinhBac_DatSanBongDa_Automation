"""Locators for Fields Page"""
class FieldsPageLocators:
    # Pitch Cards
    PITCH_CARD_CONTAINER = "xpath=//div[contains(@class,'fields-grid')]/div"
    PITCH_CARD_TITLE = "xpath=//h5"
    PITCH_VIEW_DETAIL_BTN = "xpath://a[contains(text(), 'Xem chi tiết')]"
    PITCH_CARD_PRICE = "xpath=//span[contains(text(),'đ/giờ')]"
    PITCH_CARD_LOCATION = "xpath=//span[contains(text(),'location_on')]"
    PITCH_CARD_RATING = "xpath=//*[contains(text(),'/5')]"
    
    # Filters
    FILTER_LOCATION_BTN = "xpath://button[contains(text(), 'Khu vực')]"
    FILTER_TYPE_BTN = "xpath://button[contains(text(), 'Loại sân')]"
    FILTER_PRICE_BTN = "xpath://button[contains(text(), 'Khoảng giá')]"
    FILTER_ADVANCED_BTN = "xpath://button[contains(text(), 'Lọc nâng cao')]"
    
    # Type Filter Buttons
    BTN_TYPE_ALL = "xpath://button[contains(text(), 'Tất cả')]"
    BTN_TYPE_5V5 = "xpath://button[contains(text(), 'Sân 5 người')]"
    BTN_TYPE_7V7 = "xpath://button[contains(text(), 'Sân 7 người')]"
    BTN_TYPE_11V11 = "xpath://button[contains(text(), 'Sân 11 người')]"
    
    # Pagination
    PAGINATION_BTN_1 = "xpath://button[contains(text(), '1')]"
    PAGINATION_BTN_2 = "xpath://button[contains(text(), '2')]"
    PAGINATION_BTN_NEXT = "xpath://button[contains(text(), '›')]"
    PAGINATION_BTN_PREV = "xpath://button[contains(text(), '‹')]"

fields_locators = FieldsPageLocators()
