class EPValidators {
  static isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  static isStrongPassword(String password) {
    return password.length >= 8;
  }
}
