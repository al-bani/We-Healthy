import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      )),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
      borderRadius: BorderRadius.all(
        Radius.circular(15.0),
      )),
);

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Card(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              'Ramzi Mubarak',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              'ramzimubarak@gmai.com',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(2),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blueAccent,
                                      onPrimary: Colors.white),
                                  onPressed: () {},
                                  child: Text(
                                    'Lihat Profile',
                                  ))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Jenis Kelamin'),
                            SizedBox(height: 5),
                            DropdownButtonFormField(
                                decoration: kTextFieldDecoration,
                                onChanged: (String? newValue) {},
                                items: <String>[
                                  'Pria',
                                  'Wanita'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList())
                          ],
                        )),
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(right: 0, left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Umur'),
                            SizedBox(height: 5),
                            TextField(
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                onChanged: (value) {},
                                decoration: kTextFieldDecoration),
                          ],
                        )),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Berat Badan'),
                    SizedBox(height: 5),
                    TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {},
                        decoration: kTextFieldDecoration),
                  ],
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tinggi Badan'),
                    SizedBox(height: 5),
                    TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {},
                        decoration: kTextFieldDecoration),
                  ],
                )),
            Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kegiatan Sehari-hari'),
                    SizedBox(height: 5),
                    DropdownButtonFormField(
                        decoration: kTextFieldDecoration,
                        onChanged: (String? newValue) {},
                        items: <String>['data 1', 'data 2']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList())
                  ],
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                  ),
                  onPressed: () {},
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                ))
          ],
        ),
      ),
    );
  }
}
