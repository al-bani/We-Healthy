import 'package:flutter/material.dart';
import 'package:we_healthy/screen/user_auth/login_page.dart';
import 'package:we_healthy/screen/user_auth/pending_auth.dart';
import 'package:we_healthy/utils/validator.dart';
import 'package:we_healthy/utils/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  final _focusFirstName = FocusNode();
  final _focusLastName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isProcessing = false;
  bool _isUserhasRegister = false;

  @override
  void dispose() {
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusFirstName.unfocus();
        _focusLastName.unfocus();
        _focusConfirmPassword.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Center(
                  child: Text(
                    'Daftar Akun',
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              Form(
                key: _registerFormKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameTextController,
                            focusNode: _focusFirstName,
                            validator: (value) => Validator.validateName(
                              name: value,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              labelText: 'Nama Depan',
                              hintText: 'John',
                              prefixIcon: const Icon(
                                  Icons.person), // Icon before the input

                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameTextController,
                            focusNode: _focusLastName,
                            validator: (value) => Validator.validateName(
                              name: value,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              labelText: 'Nama Belakang', // Icon be

                              hintText: 'Doe',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _emailTextController,
                      focusNode: _focusEmail,
                      validator: (value) => Validator.validateEmail(
                        email: value,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        labelText: 'Email',
                        hintText: 'Masukkan email',
                        prefixIcon: const Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordTextController,
                      focusNode: _focusPassword,
                      obscureText: !_isPasswordVisible,
                      validator: (value) => Validator.validatePassword(
                        password: value,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        labelText: 'Katasandi',
                        hintText: 'Masukkan Katasandi',
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),

                        filled: true, // Add a background color
                        fillColor: Colors.grey[200], // Background color
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _confirmPasswordTextController,
                      focusNode: _focusConfirmPassword,
                      obscureText: !_isConfirmPasswordVisible,
                      validator: (value) => Validator.validateConfirmPassword(
                        password: value,
                        confirmPassword: _passwordTextController.text,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        labelText: 'Konfirmasi Katasandi',
                        hintText: 'Ulangi Katasandi',
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _toggleConfirmPasswordVisibility,
                        ),

                        filled: true, // Add a background color
                        fillColor: Colors.grey[200], // Background color
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "Kata Sandi harus memiliki panjang 8 karakter\nKata Sandi harus mengandung Angka"),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    _isProcessing
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isProcessing = true;
                              });

                              if (_registerFormKey.currentState!.validate()) {
                                User? user =
                                    await FireAuth.registerUsingEmailPassword(
                                  name: _firstNameTextController.text +
                                      _lastNameTextController.text,
                                  email: _emailTextController.text,
                                  password: _confirmPasswordTextController.text,
                                );

                                setState(() {
                                  _isProcessing = false;
                                });

                                if (user != null) {
                                  if (user.emailVerified) {
                                    setState(() {
                                      _isUserhasRegister = true;
                                    });
                                  } else {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PendingAuthPage(user: user),
                                        ),
                                        ModalRoute.withName('/'));
                                  }
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PendingAuthPage(user: user),
                                      ),
                                      ModalRoute.withName('/'));
                                } else {
                                  setState(() {
                                    _isUserhasRegister = true;
                                  });
                                }
                              } else {
                                setState(() {
                                  _isProcessing = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey, //blue[600]
                              foregroundColor: Colors.white,
                              minimumSize: const Size(140.0, 45.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the border radius as needed
                              ),
                            ),
                            child: const Text('Daftar'),
                          ),
                    const SizedBox(height: 15.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: const Text(
                        'Sudah memiliki Akun? Masuk Disini',
                        style: TextStyle(
                          color: Color.fromARGB(255, 139, 80, 80),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Visibility(
                      visible: _isUserhasRegister,
                      child: Text("Email sudah terdaftar"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
