import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
           Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          )),
      title: Image.asset(
        'wehealty.png',
        fit: BoxFit.contain,
        height: 170,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
