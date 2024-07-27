/// Defines the contract for interacting with a SQL database.
abstract class SqlDao {
  /// Opens a connection to the SQL database.
  ///
  ///* This method should return a future that resolves to an object representing the database connection.
  Future<dynamic> getDb();
}
