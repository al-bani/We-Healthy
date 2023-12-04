class Validator {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }

    if (name.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Email tidak boleh kosong';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Masukkan email yang benar';
    }
    return null;
  }

  static String? validatePassword({required String? password}) {
    RegExp lowercaseRegExp = RegExp(r"^[^A-Z]*$");

    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Kata Sandi tidak boleh kosong';
    } else if (password.length < 8) {
      return 'Masukkan Kata sandi minimal 8 karakter';
    }

    if (lowercaseRegExp.hasMatch(password)) {
      return "Kata sandi tidak mengandung huruf kapital";
    }
    return null;
  }

  static String? validateConfirmPassword(
      {required String? password, String? confirmPassword}) {
    RegExp lowercaseRegExp = RegExp(r"^[^A-Z]*$");

    if (password != confirmPassword) {
      return 'Konfirmasi Kata sandi tidak sesuai';
    }

    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Kata Sandi tidak boleh kosong';
    } else if (password.length < 8) {
      return 'Masukkan Kata sandi minimal 8 karakter';
    }

    if (lowercaseRegExp.hasMatch(password)) {
      return "Kata sandi tidak mengandung huruf kapital";
    }
    return null;
  }
}
