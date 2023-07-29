class EPUser {
  String? uuid;
  String? displayName;
  String? email;

  EPUser({
    this.uuid,
    this.displayName,
    this.email,
  });

  EPUser.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'displayName': displayName,
      'email': email,
    };
  }
}
