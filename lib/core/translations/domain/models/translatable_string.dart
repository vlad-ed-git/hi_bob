import 'package:equatable/equatable.dart';

/// Defines a String field that can have a value in multiple languages
abstract class TranslatableString extends Equatable {
  final String languageCode;
  final String content;

  /// Defines a field that can have a value in multiple languages
  ///
  /// [languageCode] language code for this particular value
  /// [content] the string value
  const TranslatableString({
    required this.languageCode,
    required this.content,
  });
}
