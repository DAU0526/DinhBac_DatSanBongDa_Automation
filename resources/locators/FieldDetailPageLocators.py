"""Locators for Field Detail Page"""
class FieldDetailPageLocators:
    # Time Slots
    TIMESLOT_LIST = "xpath://div[contains(@class,'fd-slots')]"
    TIMESLOT_ITEM = "xpath://div[contains(@class,'fd-slot')]"
    TIMESLOT_AVAILABLE = "xpath://button[contains(@class,'bf-slot-btn') and not(contains(@class,'booked'))]"
    TIMESLOT_BOOKED = "xpath://button[contains(@class,'bf-slot-btn') and contains(@class,'booked')]"
    TIMESLOT_SELECTED = "xpath://button[contains(@class,'bf-slot-btn') and contains(@class,'selected')]"
    TIMESLOT_GRID = "xpath://div[contains(@class,'bf-slots-grid')]"
    SLOT_TIME_LABEL = "xpath://span[@class='slot-time']"
    SLOT_PRICE_LABEL = "xpath://span[@class='slot-price']"
    SCHEDULE_DATE_LABEL = "xpath://p[contains(@class,'fd-schedule-date')]"
    
    # Sidebar
    SIDEBAR_TIMESLOT_DISPLAY = "xpath://*[contains(@class,'fd-sidebar')]//span[contains(@class,'text-slate-900') and contains(@class,'font-semibold')]"
    SIDEBAR_TOTAL_PRICE = "xpath://aside[contains(@class,'fd-sidebar')]//div[contains(@class,'font-bold')]//span[contains(@class,'text-primary')]"
    SIDEBAR_PROCEED_BTN = "xpath://*[contains(@class,'fd-sidebar')]//a[contains(@href, '/booking')]"
    SIDEBAR_SERVICE_PRICE = "xpath://aside[contains(@class,'fd-sidebar')]//*[contains(text(),'Dịch vụ thêm')]/following-sibling::span"
    
    # Services
    SERVICES_SECTION = "xpath://div[contains(@class,'service-section')]"
    SERVICES_LIST = "xpath://div[contains(@class,'ss-grid')]"
    SERVICE_CARD = "xpath://div[contains(@class,'ss-card')]"
    SERVICE_NAME_LABEL = "xpath://p[contains(@class,'ss-name')]"
    SERVICE_PRICE_LABEL = "xpath://p[contains(@class,'ss-price')]"
    SERVICE_QTY_LABEL = "xpath://span[contains(@class,'ss-qty')]"
    SERVICE_BTN_PLUS = "xpath://button[contains(@class,'ss-btn-plus')]"
    SERVICE_BTN_MINUS = "xpath://button[contains(@class,'ss-btn-minus')]"
    
    # Service Names
    SERVICE_NAME_GIAY = "Giày"
    SERVICE_NAME_NUOC = "Nước"
