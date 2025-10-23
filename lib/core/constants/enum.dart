// enums.dart

enum UserRole {
  admin,
  manager,
  staff,
  guest,
}

enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded,
}

enum OrderType {
  online,
  offline,
}

enum ThemeModeType {
  light,
  dark,
  system,
}

enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
}

enum ButtonSize {
  xsmall, // 27
  small,  // 31
  medium, // 46
  large,  // custom or future
}
enum InputType { string, number, email, password }
