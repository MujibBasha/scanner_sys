class UserFields {
  static final String id = "id";
  static final String name = "name";
  static final String email = "email";
  static final String cardID = "cardID";

  static List<String> getFields() => [id, name, email, cardID];
}

class User {
  final String id;
  final String name;
  final String email;
  final String cardID;
//TODO add required parameter
  User({
    this.id,
    this.name,
    this.email,
    this.cardID,
  });

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.cardID: cardID,
      };
}
