import 'package:flutter/material.dart';

// Định nghĩa các loại thiết bị để phân biệt layout
enum DeviceType { mobile, tablet, desktop }

// Các ngưỡng chiều rộng màn hình để phân loại thiết bị
class ResponsiveBreakpoints {
  static const double mobileMax = 600; // Dưới 600px là mobile
  static const double tabletMax = 900; // 600-900px là tablet
}

// Lớp hỗ trợ các hàm responsive tiện lợi
class ResponsiveHelper {
  // Lấy loại thiết bị hiện tại dựa vào chiều rộng màn hình
  static DeviceType getDeviceType(BuildContext context) {
    double width = MediaQuery.of(context).size.width; // Lấy chiều rộng màn hình
    if (width <= ResponsiveBreakpoints.mobileMax) {
      return DeviceType.mobile; // Mobile nếu <= 600
    } else if (width <= ResponsiveBreakpoints.tabletMax) {
      return DeviceType.tablet; // Tablet nếu 601 - 900
    } else {
      return DeviceType.desktop; // Desktop nếu > 900
    }
  }

  // Kiểm tra xem thiết bị có phải mobile không
  static bool isMobile(BuildContext context) {
    return getDeviceType(context) == DeviceType.mobile;
  }

  // Kiểm tra xem thiết bị có phải tablet không
  static bool isTablet(BuildContext context) {
    return getDeviceType(context) == DeviceType.tablet;
  }

  // Kiểm tra xem thiết bị có phải desktop không
  static bool isDesktop(BuildContext context) {
    return getDeviceType(context) == DeviceType.desktop;
  }

  // Lấy chiều rộng card dựa trên thiết bị
  static double getCardWidth(BuildContext context) {
    DeviceType deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        // Card chiếm 42% chiều rộng màn hình trên mobile
        return MediaQuery.of(context).size.width * 0.42;
      case DeviceType.tablet:
        // Card cố định 180px trên tablet
        return 180;
      case DeviceType.desktop:
        // Card cố định 220px trên desktop
        return 220;
    }
  }

  // Lấy chiều cao card dựa trên thiết bị (giống chiều rộng)
  static double getCardHeight(BuildContext context) {
    DeviceType deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return MediaQuery.of(context).size.width * 0.42;
      case DeviceType.tablet:
        return 180;
      case DeviceType.desktop:
        return 220;
    }
  }

  // Lấy kích thước font dựa trên thiết bị, điều chỉnh từ baseFontSize
  static double getFontSize(BuildContext context, double baseFontSize) {
    DeviceType deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return baseFontSize; // Giữ nguyên cho mobile
      case DeviceType.tablet:
        return baseFontSize * 1.1; // Tăng 10% cho tablet
      case DeviceType.desktop:
        return baseFontSize * 1.2; // Tăng 20% cho desktop
    }
  }

  // Lấy padding phù hợp với thiết bị, dùng EdgeInsets.all để padding đều
  static EdgeInsets getPadding(BuildContext context) {
    DeviceType deviceType = getDeviceType(context);
    switch (deviceType) {
      case DeviceType.mobile:
        return const EdgeInsets.all(16.0); // Padding 16 cho mobile
      case DeviceType.tablet:
        return const EdgeInsets.all(24.0); // Padding 24 cho tablet
      case DeviceType.desktop:
        return const EdgeInsets.all(32.0); // Padding 32 cho desktop
    }
  }

  // Xây dựng GridView responsive với số cột khác nhau tùy thiết bị
  static Widget buildResponsiveGridView({
    required BuildContext context,
    required List<Widget> children,
    double spacing = 16.0, // Khoảng cách giữa các item mặc định 16
  }) {
    DeviceType deviceType = getDeviceType(context);
    int crossAxisCount;

    // Xác định số cột trên grid theo loại thiết bị
    switch (deviceType) {
      case DeviceType.mobile:
        crossAxisCount = 2; // 2 cột trên mobile
        break;
      case DeviceType.tablet:
        crossAxisCount = 3; // 3 cột trên tablet
        break;
      case DeviceType.desktop:
        crossAxisCount = 4; // 4 cột trên desktop
        break;
    }

    // Trả về GridView.builder với số cột, khoảng cách được định nghĩa
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio:
            1.0, // Tỉ lệ chiều rộng và chiều cao của item là 1:1 (vuông)
        crossAxisSpacing: spacing, // Khoảng cách ngang giữa các item
        mainAxisSpacing: spacing, // Khoảng cách dọc giữa các item
      ),
      itemCount: children.length,
      shrinkWrap: true, // GridView sẽ chiếm đúng kích thước nội dung
      physics:
          const NeverScrollableScrollPhysics(), // Không cho GridView tự cuộn
      itemBuilder: (context, index) => children[index], // Tạo từng item
    );
  }
}
