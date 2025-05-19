import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context; // Context để lấy thông tin màn hình hiện tại
  late final double width; // Chiều rộng màn hình
  late final double height; // Chiều cao màn hình
  late final double
      diagonal; // Đường chéo màn hình (dùng để tính kích thước vật lý)
  late final bool isMobile; // Có phải thiết bị mobile không?
  late final bool isTablet; // Có phải thiết bị tablet không?
  late final bool isDesktop; // Có phải thiết bị desktop không?

  static const double mobileBreakpoint =
      600; // Ngưỡng phân loại mobile: chiều rộng < 600px
  static const double tabletBreakpoint =
      900; // Ngưỡng phân loại tablet: 600px <= chiều rộng < 900px

  Responsive(this.context) {
    final size =
        MediaQuery.of(context).size; // Lấy kích thước màn hình qua MediaQuery
    width = size.width; // Gán chiều rộng màn hình
    height = size.height; // Gán chiều cao màn hình
    diagonal = size.width * size.width +
        size.height * size.height; // Tính đường chéo (Pythagoras)

    // Xác định thiết bị dựa trên chiều rộng
    isMobile = width < mobileBreakpoint; // Nếu width < 600, là mobile
    isTablet = width >= mobileBreakpoint &&
        width < tabletBreakpoint; // Nếu 600 <= width < 900, là tablet
    isDesktop = width >= tabletBreakpoint; // Nếu width >= 900, là desktop
  }

  // Trả về chiều rộng tính theo % của màn hình
  double widthPercentage(double percentage) {
    return width * (percentage / 100);
  }

  // Trả về chiều cao tính theo % của màn hình
  double heightPercentage(double percentage) {
    return height * (percentage / 100);
  }

  // Tính scale kích thước theo chiều rộng màn hình so với baseWidth (ví dụ: 375 là width của iPhone 11)
  double scaleWidth(double size, {double baseWidth = 375}) {
    return (size / baseWidth) * width;
  }

  // Tính scale kích thước theo chiều cao màn hình so với baseHeight (ví dụ: 812 là height của iPhone 11)
  double scaleHeight(double size, {double baseHeight = 812}) {
    return (size / baseHeight) * height;
  }

  // Tính padding động với các tham số linh hoạt (all, horizontal, vertical, left, right, top, bottom)
  EdgeInsets padding({
    double all = 0,
    double horizontal = 0,
    double vertical = 0,
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      // Nếu left không được truyền thì dùng all hoặc horizontal; scale theo chiều rộng
      left: scaleWidth(left == 0 ? (all == 0 ? horizontal : all) : left),
      right: scaleWidth(right == 0 ? (all == 0 ? horizontal : all) : right),
      // Nếu top không được truyền thì dùng all hoặc vertical; scale theo chiều cao
      top: scaleHeight(top == 0 ? (all == 0 ? vertical : all) : top),
      bottom: scaleHeight(bottom == 0 ? (all == 0 ? vertical : all) : bottom),
    );
  }

  // Scale font size theo chiều rộng màn hình
  double fontSize(double size) {
    return scaleWidth(size);
  }

  // Trả về giá trị phù hợp dựa trên thiết bị: mobile, tablet hay desktop
  T adaptiveValue<T>({
    required T mobile,
    required T tablet,
    required T desktop,
  }) {
    if (isDesktop) return desktop;
    if (isTablet) return tablet;
    return mobile;
  }

  // Tạo instance Responsive đơn giản bằng cách gọi Responsive.of(context)
  static Responsive of(BuildContext context) => Responsive(context);
}
