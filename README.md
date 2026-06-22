# Football Booking System - Test Automation

Dự án Test Automation cho hệ thống Đặt sân bóng đá, được xây dựng dựa trên **Robot Framework** và **SeleniumLibrary**. Dự án áp dụng kiến trúc **Page Object Model (POM)** để tối ưu hoá khả năng tái sử dụng mã nguồn, dễ dàng bảo trì và mở rộng.

## Cấu Trúc Dự Án (Page Object Model)

Toàn bộ project được chia thành các tầng (layers) phân tách rõ ràng vai trò, giúp tổ chức mã nguồn khoa học:

```text
TestRobotFrameWork POM/
├── results/                   # Thư mục chứa báo cáo test (HTML/XML) sau khi chạy
├── resources/                 # Nơi chứa các thành phần dùng chung (POM Layers)
│   ├── common_variables.robot # Biến môi trường + Test data
│   ├── keywords/              # Tầng Business Logic: Kết hợp Page Objects thành luồng nghiệp vụ
│   │   ├── authentication_keywords.robot
│   │   ├── booking_keywords.robot
│   │   ├── booking_history_keywords.robot
│   │   ├── lookup_keywords.robot
│   │   ├── pitch_selection_keywords.robot
│   │   ├── services_keywords.robot
│   │   └── timeslot_keywords.robot
│   ├── locators/              # Tầng Locators: Python classes chứa CSS/XPath selectors
│   │   ├── AuthPageLocators.py
│   │   ├── BasePageLocators.py
│   │   ├── BookingPageLocators.py
│   │   ├── FieldDetailPageLocators.py
│   │   ├── FieldsPageLocators.py
│   │   ├── HomePageLocators.py
│   │   ├── LookupPageLocators.py
│   │   └── BookingHistoryPageLocators.py
│   └── page_objects/          # Tầng Page Object: Robot Framework resource files
│       ├── AuthPage.resource
│       ├── BasePage.resource
│       ├── BookingPage.resource
│       ├── FieldDetailPage.resource
│       ├── FieldsPage.resource
│       ├── HomePage.resource
│       ├── LookupPage.resource
│       └── BookingHistoryPage.resource
├── tests/                     # Tầng Test Suites
│   ├── authentication/        # Tests cho Đăng nhập, Đăng ký
│   ├── booking/               # Tests cho Form đặt sân, xác nhận
│   ├── booking_history/       # Tests cho Lịch sử đặt sân của user
│   ├── fields/                # Tests cho Hiển thị và lọc danh sách sân
│   ├── field_detail/          # Tests cho Khung giờ và dịch vụ đi kèm
│   ├── lookup/                # Tests cho Tra cứu đơn đặt sân bằng mã code
│   ├── integration/           # End-to-end flows nối nhiều chức năng
│   ├── debug/                 # Debug tests
│   └── examples/              # Ví dụ học tập/cấu trúc cơ bản
├── requirements.txt           # Danh sách dependencies Python
└── README.md                  # Hướng dẫn chính
```

##  Chức Năng Được Tự Động Hoá (Features)

1. **Authentication:** Đăng nhập, Đăng ký, Đăng xuất, Phân quyền.
2. **Pitch Selection:** Xem danh sách, Lọc theo loại sân (5, 7, 11 người), Sắp xếp theo giá.
3. **Time Slot & Services:** Chọn ngày giờ trống, Thêm/Bớt dịch vụ đi kèm (nước, bóng, trọng tài).
4. **Booking:** Xác nhận đơn đặt sân, Xử lý validation form thông tin người đặt.
5. **Booking History:** Kiểm tra các đơn đặt sân của khách hàng ở trang My Bookings.
6. **Lookup:** Tra cứu trạng thái đơn sân qua mã Booking Code cho khách vãng lai.

##  Cài Đặt Môi Trường

### Yêu cầu hệ thống
- Python 3.8+
- Trình duyệt Chrome / Firefox / Edge bản mới nhất

### Cài đặt thư viện
Chạy các lệnh sau trong terminal tại thư mục gốc của dự án:
```bash
# Cài đặt Robot Framework & thư viện liên quan
pip install robotframework
pip install robotframework-seleniumlibrary
pip install webdrivermanager

# Tải Webdriver (Ví dụ cho Chrome)
python -m webdrivermanager chrome
```

##  Hướng Dẫn Chạy Tests

Bạn nên mở Terminal/Powershell ở thư mục gốc của project (ngang hàng `README.md`) để chạy lệnh.

### 1. Chạy theo nhóm Chức Năng (Features) - Recommended
Theo kiến trúc mới, tests được gom theo chức năng. Bạn có thể chạy từng folder riêng biệt:

```powershell
# Chạy nhóm Đăng nhập / Đăng ký (Authentication)
robot --outputdir results/auth tests/authentication/

# Chạy chức năng Tìm kiếm & Chọn sân (Pitch Selection)
robot --outputdir results/fields tests/fields/

# Chạy chức năng chọn khung giờ & dịch vụ đi kèm (Time Slot & Services)
robot --outputdir results/field_detail tests/field_detail/

# Chạy chức năng Đặt sân (Booking)
robot --outputdir results/booking tests/booking/

# Chạy chức năng Lịch sử đặt sân (Booking History)
robot --outputdir results/booking_history tests/booking_history/

# Chạy chức năng Tra cứu đơn đặt sân (Lookup)
robot --outputdir results/lookup tests/lookup/

# Chạy các luồng end-to-end (Integration)
robot --outputdir results/integration tests/integration/

# Chạy tất cả các test trong project
robot --outputdir results tests
```

### 2. Chạy theo Tags (Phân loại Test)
Các test case được đánh dấu bằng tag (`smoke`, `regression`, `auth`, `booking`...).

```powershell
# Chỉ chạy smoke tests (Kiểm tra luồng chính)
robot --include smoke --outputdir results/smoke tests

# Chỉ chạy regression tests (Kiểm thử hồi quy chi tiết)
robot --include regression --outputdir results/regression tests
```

### 3. Cấu hình Môi Trường (Ghi đè biến)
Rất hữu ích khi cần chạy đa trình duyệt hoặc đa môi trường:

```powershell
# Chạy trên Firefox (thay vì Chrome mặc định)
robot --variable BROWSER:firefox --outputdir results tests

# Chạy với Base URL khác (Staging/Production)
robot --variable URL:https://staging.example.com/ --outputdir results tests
```

