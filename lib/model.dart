class BookModel{
  String id;
  String name;
  String auth;

  static String collectionName='books';

  BookModel({
    this.id = "",
    required this.name,
    required this.auth

});
  // obj -> json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'auth': auth,
    };
  }

  // json -> obj
  factory BookModel.fromFireStore(Map<String, dynamic> data) {
    return BookModel(
    id: data['id'] ?? "",

    name: data['name'],
      auth: data['auth'],
    );
  }
}