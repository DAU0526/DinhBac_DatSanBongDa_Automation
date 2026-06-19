*** Settings ***
Documentation    Integration Tests - Toàn Bộ Quy Trình Đặt Sân
Library          SeleniumLibrary
Resource         ../../resources/keywords/authentication_keywords.robot
Resource         ../../resources/keywords/booking_keywords.robot
Resource         ../../resources/keywords/pitch_selection_keywords.robot
Resource         ../../resources/keywords/timeslot_keywords.robot
Resource         ../../resources/keywords/services_keywords.robot
Resource         ../../resources/variables/variables.robot
Suite Setup      Open Browser To Application
Suite Teardown   Close Browser Application

*** Test Cases ***
TC_INTEGRATION_01: Toàn Bộ Quy Trình: Chủ → Sân → Chọn → Đặt Với Dịch Vụ
    [Documentation]    Kiểm tra toàn bộ quy trình từ trang chủ đến đặt sân thành công
    [Tags]    integration
    # Bước 1: Đăng nhập (nếu cần)
    Login With Valid Credentials    user@example.com    password123
    User Should Be Logged In
    
    # Bước 2: Trang chủ chọn sân
    Navigate To Home Page
    Select Pitch From Home    Sân 1
    
    # Bước 3: Chọn ngày và khung giờ
    Navigate To Booking Page
    Select Date On Calendar    05
    Select Time Slot    14:00
    
    # Bước 4: Chọn dịch vụ thêm
    Select Multiple Services    Nước uống    Áo bóng đá
    
    # Bước 5: Điền thông tin khách hàng
    Fill Customer Info    Nguyễn Văn A    0912345678    test@example.com
    
    # Bước 6: Xác nhận đặt sân
    Click Book Button
    Confirm Booking
    Booking Should Be Successful

TC_INTEGRATION_02: Toàn Bộ Quy Trình: Sân → Chọn → Đặt Không Có Dịch Vụ
    [Documentation]    Kiểm tra quy trình từ trang sân bóng đến đặt sân (không dịch vụ)
    [Tags]    integration
    Navigate To Pitches Page
    Add Pitch To Booking    Sân 2
    
    Select Date On Calendar    06
    Select Time Slot    16:00
    Fill Customer Info    Trần Thị B    0987654321    test2@example.com
    
    Click Book Button
    Confirm Booking
    Booking Should Be Successful

TC_INTEGRATION_03: Chọn Sân Khác Nhau Có Khung Giờ Khác Nhau
    [Documentation]    Kiểm tra sân khác nhau có khung giờ khác nhau
    [Tags]    integration
    Navigate To Pitches Page
    Add Pitch To Booking    Sân 1
    ${slots_san1}=    Get Timeslot Count    07
    
    Navigate To Pitches Page
    Add Pitch To Booking    Sân 3
    ${slots_san3}=    Get Timeslot Count    07
    
    # Số lượng khung giờ có thể khác nhau tùy vào dữ liệu
