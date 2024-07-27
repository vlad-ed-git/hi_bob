import 'package:equatable/equatable.dart';
import 'package:hi_bob/core/translations/domain/models/supported_languages.dart';

class UserPreferences extends Equatable {
  final SupportedLanguages language;
  final bool prefersDarkMode;

  UserPreferences({
    this.language = SupportedLanguages.chinese,
    this.prefersDarkMode = false,
  });

  @override
  List<Object> get props => [
        language,
        prefersDarkMode,
      ];

  UserPreferences toggleDarkMode() {
    return UserPreferences(
      prefersDarkMode: !prefersDarkMode,
      language: language,
    );
  }
}
