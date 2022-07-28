abstract class Dao<T> {

  String get tableName;
  String get columnId;
  //queries
  String get createTableQuery;

  //abstract mapping methods
  T fromMap(Map<String, dynamic> query);
  Map<String, dynamic> toMap(T object);

  List<T> fromList(List<Map<String,dynamic>> query) {
    List<T> objects = <T>[];
    for (var map in query) {
      objects.add(fromMap(map));
    }
    return objects;
  }
}