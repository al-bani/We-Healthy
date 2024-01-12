import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_healthy/screen/data_fisik.dart';

class PendingAuthPage extends StatefulWidget {
  final User user;
  const PendingAuthPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PendingAuthPage> createState() => _PendingAuthPageState();
}

class _PendingAuthPageState extends State<PendingAuthPage> {
  bool _visibilityText = false;
  bool _isSendVerification = false;
  late User _currentUser;
  late Timer _timeToAutoDirect;
  Timer? _timeToVerifAgain;
  int _startTimeVerification = 120;
  bool _notificationStop = false;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    autoDirect();
  }

  Future<void> sendVerificationEmail() async {
    _isSendVerification = true;
    _visibilityText = true;
    startTimer();
    try {
      await _currentUser.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  void autoDirect() {
    _timeToAutoDirect = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        FirebaseAuth.instance.currentUser?.reload();
        _currentUser = FirebaseAuth.instance.currentUser!;
        if (_currentUser.emailVerified) {
          setState(() {
            _notificationStop = true;
          });
          timer.cancel();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => DataFisik(
                user: _currentUser,
              ),
            ),
          );
        }
      } else {
        // Widget is no longer mounted, cancel the timer
        timer.cancel();
      }
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    _timeToVerifAgain = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_startTimeVerification == 0) {
          setState(() {
            timer.cancel();
            _visibilityText = false;
            _isSendVerification = false;
            _startTimeVerification = 120;
          });
        } else {
          setState(() {
            _startTimeVerification--;
            if (_notificationStop) {
              timer.cancel();
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timeToVerifAgain?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 111, 247),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 100),
            Image.asset(
              'assets/logo/logo_white.png',
              width: 170,
              height: 57,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 140),
            Text(
              "Verifikasi Email anda !",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 13),
            Text(
              "Klik tombol dibawah untuk mengirim link verifikasi ke alamat",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
            Text(
              "email ${_currentUser.email}",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Colors.white),
            ),
            SizedBox(height: 30),
            _isSendVerification
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isSendVerification = true;
                      });
                      sendVerificationEmail();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      minimumSize: const Size(140.0, 45.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Kirim Link Verifikasi'),
                  ),
            SizedBox(height: 10),
            Visibility(
              visible: _visibilityText,
              child: Text(
                  "Kirim Ulang link verifikasi dalam $_startTimeVerification detik",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  )),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _notificationStop = true;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                minimumSize: const Size(85.0, 45.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Icon(Icons.arrow_back),
            ),
          ],
        ),
      )),
    );
  }
}
