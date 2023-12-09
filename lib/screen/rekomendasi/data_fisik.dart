import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_healthy/screen/user_auth/login_page.dart';
import 'package:we_healthy/utils/validator.dart';

class DataFisik extends StatefulWidget {
  const DataFisik({super.key});

  @override
  State<DataFisik> createState() => _DataFisikState();
}

class _DataFisikState extends State<DataFisik> {
  final _registerFormKey = GlobalKey<FormState>();
  final _firstNameTextController = TextEditingController();
  final _lastNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool isChecked = false;

  late String itemName;
  late List<PanelItem> _data;
  int currentIndex = 0;
  List<String> items = ["first", "second", "third"];

  @override
  void initState() {
    super.initState();

    _data = generateItems(items.length);
    itemName = _data.first.itemName;
  }

  List<PanelItem> generateItems(int numberOfItems) {
    return List<PanelItem>.generate(numberOfItems, (int index) {
      return PanelItem(
        itemName: items[index],
      );
    });
  }

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
    return Scaffold(
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
                  'Data Fisik',
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
                          validator: (value) => Validator.validateName(
                            name: value,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            labelText: 'Jenis Kelamin',
                            hintText: 'Laki-laki',
                            prefixIcon: const Icon(
                                Icons.person), // Icon before the input

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
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameTextController,
                          validator: (value) => Validator.validateName(
                            name: value,
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            labelText: 'Umur', // Icon be

                            hintText: '20',
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailTextController,
                    validator: (value) => Validator.validateEmail(
                      email: value,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      labelText: 'Berat Badan',
                      hintText: '90 Kg',
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

                    keyboardType:
                        TextInputType.number, // Hanya menerima input angka
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Tinggi Badan tidak boleh kosong'; // Validasi jika field kosong
                      }
                      // Implementasi validasi lainnya sesuai kebutuhan
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      labelText: 'Tinggi Badan',
                      hintText: '180 Cm',
                      prefixIcon: const Icon(Icons.height),
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
                  ExpansionTile(
                    title: const Text('Kegiatan Sehari-hari'),
                    children: <Widget>[
                      Builder(
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(24),
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              child: const Text('Collapse This Tile'),
                              onPressed: () {
                                return ExpansionTileController.of(context)
                                    .collapse();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add your button click action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PanelItem {
  PanelItem({
    required this.itemName,
    this.isExpanded = false,
  });

  String itemName;
  bool isExpanded;
}
