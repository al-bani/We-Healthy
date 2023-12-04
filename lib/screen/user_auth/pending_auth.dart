import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_healthy/screen/home_screen.dart';

class PendingAuthPage extends StatefulWidget {
  final User user;
  const PendingAuthPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PendingAuthPage> createState() => _PendingAuthPageState();
}

class _PendingAuthPageState extends State<PendingAuthPage> {
  bool _isResendVerification = false;
  bool _visibleTimer = false;
  bool _isEmailVerified = false;
  late Timer _timerVerif;
  late User _currentUser;
  Timer? _timer;
  int _start = 120;

  void AutoDirect() {
    _timerVerif = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (widget.user.emailVerified) {
        timer.cancel();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _visibleTimer = false;
            _isResendVerification = false;
            _start = 120;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _sendEmailVerification();
    AutoDirect();
  }

  Future<void> _sendEmailVerification() async {
    _visibleTimer = !_visibleTimer;
    _isResendVerification = true;
    startTimer();
    try {
      await _currentUser.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) => _isEmailVerified
      ? HomePage()
      : Scaffold(
          backgroundColor: Color(0xffffffff),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xff3a57e8),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Text(
                          "Verification",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: NetworkImage(
                              "https://cdn3.iconfinder.com/data/icons/infinity-blue-office/48/005_084_email_mail_verification_tick-512.png"),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 30, 3),
                  child: Text(
                    "Kami Sudah mengirimkan link verifikasi ke alamat email",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${_currentUser.email}",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 16,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
                _isResendVerification
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          _sendEmailVerification();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          minimumSize: const Size(140.0, 45.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Kirim Ulang Link Verifikasi'),
                      ),
                const SizedBox(height: 20),
                Visibility(
                  visible: _visibleTimer,
                  child:
                      Text("Kirim Ulang link verifikasi dalam $_start detik"),
                ),
                const SizedBox(height: 32),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: const Color(0xffffffff),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "Back",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 16,
                      color: Color(0xff3a57e8),
                    ),
                  ),
                  height: 40,
                  minWidth: 0,
                ),
              ],
            ),
          ),
        );
}
