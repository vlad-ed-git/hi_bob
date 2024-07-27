import 'package:hi_bob/core/error_handling/domain/models/failure.dart';
import 'package:hi_bob/features/user_preferences/domain/errors/user_preferences_errors.dart';

class UserPreferencesFailure extends Failure {
  final UserPreferencesErrors userPreferencesError;

  UserPreferencesFailure(this.userPreferencesError);

  @override
  List<Object?> get props => [userPreferencesError];
}
