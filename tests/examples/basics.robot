*** Settings ***
Documentation    Hướng Dẫn Cơ Bản - Ôn Lại Python/Robot Framework
Library          SeleniumLibrary
Resource         ./keywords/booking_keywords.robot
Resource         ../resources/common_variables.robot

*** Keywords ***
# Keyword ví dụ: Học cách làm việc với biến
My First Keyword
    [Documentation]    Keyword đầu tiên - ví dụ cơ bản
    Log    Hello from my first keyword!

# Keyword ví dụ: Sử dụng arguments
Calculate Sum
    [Arguments]    ${number1}    ${number2}
    [Documentation]    Tính tổng của 2 số
    ${result}=    Evaluate    ${number1} + ${number2}
    Log    ${number1} + ${number2} = ${result}
    RETURN    ${result}

# Keyword ví dụ: Loop trong Robot Framework
Log Numbers From 1 To N
    [Arguments]    ${n}
    [Documentation]    In ra các số từ 1 đến N
    FOR    ${i}    IN RANGE    1    ${n}+1
        Log    Number: ${i}
    END

# Keyword ví dụ: If/Else trong Robot Framework
Check Number Is Positive Or Negative
    [Arguments]    ${number}
    [Documentation]    Kiểm tra số dương hay âm
    IF    ${number} > 0
        Log    ${number} là số dương
    ELSE IF    ${number} < 0
        Log    ${number} là số âm
    ELSE
        Log    ${number} bằng 0
    END

*** Test Cases ***
TC_EXAMPLE_01: Ví Dụ Keyword Cơ Bản
    [Documentation]    Ví dụ gọi keyword đơn giản
    [Tags]    example
    My First Keyword

TC_EXAMPLE_02: Ví Dụ Tính Tổng
    [Documentation]    Ví dụ sử dụng keyword có arguments
    [Tags]    example
    ${sum}=    Calculate Sum    5    3
    Log    Kết quả: ${sum}

TC_EXAMPLE_03: Ví Dụ Loop
    [Documentation]    Ví dụ sử dụng vòng lặp
    [Tags]    example
    Log Numbers From 1 To N    5

TC_EXAMPLE_04: Ví Dụ If/Else
    [Documentation]    Ví dụ sử dụng điều kiện
    [Tags]    example
    Check Number Is Positive Or Negative    10
    Check Number Is Positive Or Negative    -5
    Check Number Is Positive Or Negative    0

TC_EXAMPLE_05: Làm Việc Với String
    [Documentation]    Ví dụ xử lý string
    [Tags]    example
    ${name}=    Set Variable    Nguyễn Văn A
    ${email}=    Set Variable    ${name}@example.com
    ${email}=    Evaluate    '${email}'.lower().replace(' ', '.')
    Log    Email: ${email}

TC_EXAMPLE_06: Làm Việc Với List
    [Documentation]    Ví dụ làm việc với list
    [Tags]    example
    @{pitches}=    Create List    Sân 1    Sân 2    Sân 3    Sân 4
    FOR    ${pitch}    IN    @{pitches}
        Log    Sân bóng: ${pitch}
    END

TC_EXAMPLE_07: Làm Việc Với Dictionary
    [Documentation]    Ví dụ làm việc với dictionary
    [Tags]    example
    &{booking}=    Create Dictionary    name=Nguyễn Văn A    phone=0912345678    date=2024-06-05
    Log    Tên khách: ${booking}[name]
    Log    SĐT: ${booking}[phone]
    Log    Ngày đặt: ${booking}[date]
