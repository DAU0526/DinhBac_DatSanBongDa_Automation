*** Settings ***
Documentation       Regression Tests - Tra cứu đơn đặt sân
...                 Kiểm tra chi tiết toàn bộ chức năng Tra cứu:
...                 UI elements, nhập liệu, nhấn nút, kết quả trả về, mã hợp lệ/không hợp lệ
...                 Luồng cơ bản: Đăng nhập (04858758475/12345) → /lookup → Nhập mã → Tra cứu ngay
Library             SeleniumLibrary
Resource            ../../resources/keywords/lookup_keywords.robot
Resource            ../../resources/keywords/booking_keywords.robot
Resource            ../../resources/common_variables.robot

Suite Setup         Open Browser To Application
Suite Teardown      Close Browser Application

*** Test Cases ***

# ============================================================
#  NHÓM 1: ĐĂNG NHẬP VÀ ĐIỀU HƯỚNG
# ============================================================

TC_LOOKUP_REG_01: Đăng Nhập Với Tài Khoản 04858758475 Thành Công
    [Documentation]    Đăng nhập bằng SĐT 04858758475 / pass 12345 và xác nhận thành công
    [Tags]    regression    lookup    login
    Wait Until Page Contains    Football Booking    ${TIMEOUT}
    Login For Lookup Test
    ${url}=    Get Location
    Should Not Contain    ${url}    /login
    Capture Page Screenshot

TC_LOOKUP_REG_02: Điều Hướng Tới Trang Tra Cứu Qua URL
    [Documentation]    Vào /lookup trực tiếp và kiểm tra trang hiển thị đúng
    [Tags]    regression    lookup    navigation
    Navigate To Lookup Page
    Lookup Page Should Be Displayed
    Location Should Contain    lookup
    Capture Page Screenshot

TC_LOOKUP_REG_03: Điều Hướng Tới Trang Tra Cứu Qua Menu Navbar
    [Documentation]    Click vào link /lookup trên thanh điều hướng
    [Tags]    regression    lookup    navigation    navbar
    Go To    ${URL}
    Wait Until Page Contains    Football Booking    ${TIMEOUT}
    Navigate To Lookup Via Nav
    Lookup Page Should Be Displayed
    Capture Page Screenshot

# ============================================================
#  NHÓM 2: KIỂM TRA UI ELEMENTS
# ============================================================

TC_LOOKUP_REG_04: Ô Nhập Mã Có Class "input-field" Hiển Thị
    [Documentation]    Xác nhận element css=input.input-field có mặt và visible
    [Tags]    regression    lookup    ui    input
    Navigate To Lookup Page
    Input Field Should Be Visible And Enabled

TC_LOOKUP_REG_05: Placeholder Ô Nhập Mã Là "VD: BK123456"
    [Documentation]    Kiểm tra thuộc tính placeholder chính xác
    [Tags]    regression    lookup    ui    input
    Navigate To Lookup Page
    Input Field Placeholder Should Be Correct

TC_LOOKUP_REG_06: Nút Tra Cứu Ngay Có Class "btn-lookup-now" Hiển Thị
    [Documentation]    Xác nhận element css=button.btn-lookup-now có mặt và enabled
    [Tags]    regression    lookup    ui    button
    Navigate To Lookup Page
    Lookup Button Should Be Visible And Enabled

TC_LOOKUP_REG_07: Nút Tra Cứu Ngay Có Icon Search
    [Documentation]    Kiểm tra icon material-symbols-outlined có trong nút tra cứu
    [Tags]    regression    lookup    ui    button
    Navigate To Lookup Page
    Lookup Button Should Have Search Icon

TC_LOOKUP_REG_08: Nút Tra Cứu Có Text "Tra cứu ngay"
    [Documentation]    Kiểm tra nội dung text của nút tra cứu
    [Tags]    regression    lookup    ui    button
    Navigate To Lookup Page
    ${btn_text}=    Get Text    ${LOOKUP_BUTTON}
    Should Contain    ${btn_text}    Tra cứu ngay

# ============================================================
#  NHÓM 3: KIỂM TRA NHẬP LIỆU VÀO Ô MÃ
# ============================================================

TC_LOOKUP_REG_09: Có Thể Nhập Mã Đặt Sân Vào Ô Input
    [Documentation]    Nhập BK123456 và xác nhận giá trị được ghi đúng
    [Tags]    regression    lookup    input
    Navigate To Lookup Page
    Can Input Booking Code    BK123456

TC_LOOKUP_REG_10: Có Thể Xóa Nội Dung Ô Input
    [Documentation]    Nhập mã rồi xóa, xác nhận ô trở về trống
    [Tags]    regression    lookup    input
    Navigate To Lookup Page
    Enter Booking Code    BK123456
    Clear Booking Code Input

TC_LOOKUP_REG_11: Có Thể Ghi Đè Mã Cũ Bằng Mã Mới
    [Documentation]    Nhập mã thứ nhất, xóa rồi nhập mã thứ hai
    [Tags]    regression    lookup    input
    Navigate To Lookup Page
    Enter Booking Code    BK111111
    Clear Booking Code Input
    Enter Booking Code    BK999999
    Input Field Value Should Be    BK999999

TC_LOOKUP_REG_12: Ô Input Chấp Nhận Ký Tự Chữ Và Số
    [Documentation]    Kiểm tra ô có thể nhận cả chữ và số (định dạng BKxxxxxx)
    [Tags]    regression    lookup    input
    Navigate To Lookup Page
    Can Input Booking Code    BK123456

# ============================================================
#  NHÓM 4: NHẤN NÚT TRA CỨU VÀ KIỂM TRA KẾT QUẢ
# ============================================================

TC_LOOKUP_REG_13: Nhấn Nút Tra Cứu Sau Khi Nhập Mã BK123456
    [Documentation]    Nhập BK123456 rồi click "Tra cứu ngay" - kiểm tra có phản hồi
    [Tags]    regression    lookup    action    result
    Navigate To Lookup Page
    Lookup Booking Code    BK123456
    Lookup Should Show Result
    Capture Page Screenshot

TC_LOOKUP_REG_14: Tra Cứu Mã Không Tồn Tại Hiển Thị Thông Báo Lỗi
    [Documentation]    Nhập mã INVALID999 và kiểm tra thông báo không tìm thấy
    [Tags]    regression    lookup    action    result    negative
    Navigate To Lookup Page
    Lookup With Invalid Code Should Show Not Found    INVALID999

TC_LOOKUP_REG_15: Có Thể Nhấn Enter Thay Vì Click Nút Để Tra Cứu
    [Documentation]    Nhập mã rồi nhấn Enter - kiểm tra chức năng search được kích hoạt
    [Tags]    regression    lookup    action    keyboard
    Navigate To Lookup Page
    Enter Booking Code    BK123456
    Press Enter To Lookup
    Capture Page Screenshot

TC_LOOKUP_REG_16: Tra Cứu Nhiều Lần Liên Tiếp Với Mã Khác Nhau
    [Documentation]    Tra cứu lần 1 rồi tra cứu lần 2 với mã khác - kiểm tra hoạt động liên tục
    [Tags]    regression    lookup    action    repeated
    Navigate To Lookup Page
    Lookup Booking Code    BK123456
    Sleep    1s
    Navigate To Lookup Page
    Lookup Booking Code    INVALID999
    Capture Page Screenshot
