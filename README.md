# Football Booking System - Test Automation

Dự án Test Automation cho hệ thống Đặt sân bóng đá, được xây dựng dựa trên **Robot Framework** và **SeleniumLibrary**. Dự án áp dụng kiến trúc **Page Object Model (POM)** để tối ưu hoá khả năng tái sử dụng mã nguồn, dễ dàng bảo trì và mở rộng.

## Cấu Trúc Dự Án (Page Object Model)

Toàn bộ project được chia thành các tầng (layers) phân tách rõ ràng vai trò, giúp tổ chức mã nguồn khoa học:

```text
TestRobotFrameWork POM/
├── docs/                      # Tài liệu hướng dẫn chi tiết
├── results/                   # Thư mục chứa báo cáo test (HTML/XML) sau khi chạy
├── resources/                 # Nơi chứa các thành phần dùng chung (POM Layers)
│   ├── config/                # Chứa thiết lập môi trường
│   │   └── environment.robot  # Base URL, browser, timeout, delay...
│   ├── testdata/              # Chứa dữ liệu test (Test Data)
│   │   └── booking_data.robot # Các account, dữ liệu mẫu...
│   ├── pages/                 # Tầng Page Object: Chứa các Locators và hàm tương tác cơ bản UI
│   │   ├── base_page.robot          # Browser setup và điều hướng chung
│   │   ├── auth_page.robot          # Trang Đăng nhập/Đăng ký
│   │   ├── fields_page.robot        # Trang Danh sách sân
│   │   ├── field_detail_page.robot  # Trang Chi tiết sân (Khung giờ, dịch vụ)
│   │   ├── booking_page.robot       # Trang Thanh toán/Xác nhận đặt sân
│   │   ├── lookup_page.robot        # Trang Tra cứu đơn đặt sân
│   │   └── booking_history_page.robot # Trang Lịch sử đặt sân
│   ├── keywords/              # Tầng Business Logic: Kết hợp các Page Objects thành luồng nghiệp vụ
│   │   ├── authentication_keywords.robot
│   │   ├── booking_keywords.robot
│   │   └── ...
│   └── variables/             # (Legacy) Biến toàn cục, đang dịch chuyển dần sang POM
├── tests/                     # Tầng Test Suites: Chứa các kịch bản test (Test Cases)
│   ├── authentication/        # Tests cho Đăng nhập, Đăng ký
│   ├── booking/               # Tests cho Form đặt sân, xác nhận
│   ├── booking_history/       # Tests cho Lịch sử đặt sân của user
│   ├── fields/                # Tests cho Hiển thị và lọc danh sách sân
│   ├── field_detail/          # Tests cho Khung giờ và dịch vụ đi kèm
│   ├── lookup/                # Tests cho Tra cứu đơn đặt sân bằng mã code
│   ├── integration/           # End-to-end flows nối nhiều chức năng
│   └── examples/              # Ví dụ học tập/cấu trúc cơ bản
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
python -m robot --outputdir results/auth tests/authentication/

# Chạy chức năng Tìm kiếm & Chọn sân (Pitch Selection)
python -m robot --outputdir results/pitch tests/fields/

# Chạy chức năng chọn khung giờ & dịch vụ đi kèm (Time Slot & Services)
python -m robot --outputdir results/field_detail tests/field_detail/

# Chạy chức năng Đặt sân (Booking)
python -m robot --outputdir results/booking tests/booking/

# Chạy chức năng Tra cứu đơn đặt sân / Lịch sử đặt sân (Lookup & Booking History)
python -m robot --outputdir results/lookup tests/lookup/
python -m robot --outputdir results/history tests/booking_history/

# Chạy tất cả các test trong project
python -m robot --outputdir results tests
```

### 2. Chạy theo Tags (Phân loại Test)
Các test case được đánh dấu bằng tag (`smoke`, `regression`, `auth`, `booking`...).

```powershell
# Chỉ chạy smoke tests (Kiểm tra luồng chính)
python -m robot --include smoke --outputdir results/smoke tests

# Chỉ chạy regression tests (Kiểm thử hồi quy chi tiết)
python -m robot --include regression --outputdir results/regression tests
```

### 3. Cấu hình Môi Trường (Ghi đè biến)
Rất hữu ích khi cần chạy đa trình duyệt hoặc đa môi trường:

```powershell
# Chạy trên Firefox (thay vì Chrome mặc định)
python -m robot --variable BROWSER:firefox --outputdir results tests

# Chạy với Base URL khác (Staging/Production)
python -m robot --variable URL:https://staging.example.com/ --outputdir results tests
```

##  Best Practices khi viết Test mới

Dựa trên cấu trúc POM, tuân thủ các quy tắc sau:

1. **Test Suites ở `tests/<feature>/`**: Không đặt file test trong các thư mục kiểu `smoke` hay `regression`. Dùng tag để phân loại.
2. **Không chứa Locators trong Tests/Keywords**: Mọi CSS Selectors / XPaths phải được định nghĩa tại `resources/pages/*_page.robot`.
3. **Phân biệt rạch ròi Page và Keyword**: 
   - `pages`: Chứa các tương tác đơn lẻ như `Click Button`, `Input Text`.
   - `keywords`: Chứa logic nghiệp vụ gọi nhiều hành động từ Page Objects, ví dụ `Login Với Tài Khoản Hợp Lệ`.
4. **Environment / Data tách biệt**: Để cấu hình vào `config/` và dữ liệu như user accounts vào `testdata/`.

*Ví dụ import cho file test mới:*
```robot
*** Settings ***
Library      SeleniumLibrary
Resource     ../../resources/config/environment.robot
Resource     ../../resources/keywords/booking_keywords.robot
Resource     ../../resources/testdata/booking_data.robot
```
