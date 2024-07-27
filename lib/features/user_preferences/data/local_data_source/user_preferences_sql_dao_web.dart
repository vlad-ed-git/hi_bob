import 'dart:async';

import 'package:hi_bob/core/caching/domain/sql_dao.dart';

class UserPreferencesSqlDaoWeb extends SqlDao {
  static const int _dbVersion = 1;
  static const String _dbName = 'com_hi_bob_user_preferences_sql_web.db';

  @override
  Future<dynamic> getDb() {
    throw UnsupportedError('SqlDao Not Supported In Web');
  }

 
}
