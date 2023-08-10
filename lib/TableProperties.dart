class TableProperties {
  static final String TABLENAME = "Laptops";
  static final String CREATETABLE = "CREATE TABLE " +
      TABLENAME +
      "(Id INTEGER PRIMARY KEY AUTOINCREMENT,Model TEXT,Price INTEGER)";

  static final String IdColumn = "Id";
  static final String ModelColumn = "Model";
  static final String PriceColumn = "Price";
}
