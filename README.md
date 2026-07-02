# Student Attendance Management System - Database Assignment

Dự án thiết kế và triển khai Cơ sở dữ liệu cho Hệ thống quản lý điểm danh sinh viên. Dự án này bao gồm việc thiết kế mô hình thực thể liên kết (ER Model), khởi tạo cấu trúc dữ liệu vật lý và xây dựng các câu lệnh truy vấn phục vụ nghiệp vụ thực tế.

---

## 📂 Cấu trúc thư mục (Physical Settings)

Dự án bao gồm các tập tin chính sau:

*   **[`Setup.sql`](#)**: Script dùng để khởi tạo cơ sở dữ liệu (`AttendanceDB`), tạo các bảng (Tables) kèm ràng buộc (Khóa chính, Khóa ngoại) và chèn dữ liệu mẫu (Dummy Data).
*   **[`Query.sql`](#)**: Tập hợp các câu lệnh SQL truy vấn dữ liệu từ cơ bản đến nâng cao (Xem danh sách lớp, thống kê sĩ số, lịch sử điểm danh, báo cáo vắng mặt...).
*   *(Thêm link hoặc tên file Sơ đồ ER của bạn vào đây, ví dụ: `ER_Diagram.drawio.png`)*

> 🔗 **Lưu ý:** Thay thế dấu `#` ở trên bằng đường dẫn (Link) thực tế tới các file của bạn trên GitHub hoặc Google Drive.

---

## 🚀 Hướng dẫn cài đặt và sử dụng

1. **Chuẩn bị môi trường:** Đảm bảo bạn đã cài đặt một hệ quản trị cơ sở dữ liệu như MySQL (XAMPP, MySQL Workbench, DBeaver,...).
2. **Khởi tạo dữ liệu:** 
   * Mở file `Setup.sql`.
   * Chạy (Execute) toàn bộ script để tạo Database `AttendanceDB` và nạp dữ liệu mẫu.
3. **Thực thi truy vấn:**
   * Mở file `Query.sql`.
   * Bôi đen và chạy từng khối lệnh truy vấn tương ứng với từng nghiệp vụ để xem kết quả đầu ra.

---

## 📊 Cấu trúc Cơ sở dữ liệu (Database Schema)

Hệ thống được thiết kế với 8 bảng chính:
1. `Semester`: Quản lý thông tin học kỳ.
2. `Course`: Quản lý thông tin môn học.
3. `Student`: Hồ sơ sinh viên.
4. `Teacher`: Hồ sơ giảng viên.
5. `Class`: Các lớp học được mở theo môn và học kỳ.
6. `Enrollment`: Bảng trung gian lưu trữ việc sinh viên đăng ký lớp.
7. `ClassSession`: Lịch học chi tiết của từng buổi học.
8. `Attendance`: Ghi nhận điểm danh sinh viên cho từng buổi học cụ thể.

---

## 📝 Báo cáo tổng kết (Conclusion)

### 🌟 Kết quả đạt được (Achievements)
* **Làm việc nhóm hiệu quả:** Các thành viên phối hợp nhịp nhàng trong việc phân tích và thiết kế dữ liệu.
* **Ứng dụng thực tiễn:** Áp dụng thành công các kiến thức lý thuyết về cơ sở dữ liệu vào một dự án thực tế.
* **Tạo nền tảng cho tương lai:** Tạo ra nền tảng vững chắc cho các dự án nhóm sắp tới, tiêu biểu là dự án *Website quản lý sinh viên* cho khách hàng.
* **Nâng cao chuyên môn:** Củng cố và mở rộng kiến thức về SQL, chuẩn hóa dữ liệu và tư duy logic.

### 🚧 Những điểm cần cải thiện (Areas for Improvement)
* Các tính năng trong mô hình dự án hiện tại vẫn chưa được hoàn thiện và bao quát hết các trường hợp ngoại lệ (Edge cases).

### 💌 Lời kết
Mặc dù nhóm còn vướng mắc một số hạn chế trong bước đầu áp dụng kiến thức vào dự án thực tế, nhưng báo cáo này đã nhìn nhận rõ những thiếu sót đó. Chúng tôi rất mong nhận được những ý kiến đóng góp quý báu của giảng viên và các bạn để dự án được cải thiện và hoàn thiện hơn. Nguyện vọng lớn nhất của nhóm là dự án nhỏ này sẽ sớm phát triển thành một sản phẩm phần mềm hoàn chỉnh trong tương lai.
