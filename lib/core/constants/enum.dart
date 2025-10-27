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
  danger,
  success,
  warning,
  info,
  disabled,
  icon,
  fab,
  link,
}


enum ButtonSize {
  xsmall, // 27
  small,  // 31
  medium, // 46
  large,  // custom or future
}
enum InputType { string, number, email, password,phone,url,date,multiline }
/// Defines all text style variants that align with your app's TextTheme.
enum TextVariant {
  // 🔹 Display levels (large titles)
  displayExtraLarge,
  displayLarge,
  displayMedium,
  displaySmall,

  // 🔹 Headline levels (section headers)
  headlineLarge,
  headlineMedium,
  headlineSmall,

  // 🔹 Titles (buttons / small headers)
  titleLarge,
  titleMedium,
  titleSmall,


  // 🔹 Body (paragraphs, labels)
  bodyLarge,
  bodyMedium,
  bodySmall,

  // 🔹 Labels (captions, chips, meta text)
  labelLarge,
  labelMedium,
  labelSmall,
}
