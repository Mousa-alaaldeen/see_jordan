import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class LoginPage11 extends StatelessWidget {
  static const routeName = '/LoginPage11';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Link(
          target: LinkTarget.blank,
          uri: Uri.parse('https://maps.app.goo.gl/vPfDFGqJWeJWZ9G96?g_st=iw'),
          builder:
              (BuildContext context, Future<void> Function()? followLink) =>
                  TextButton(
            onPressed: followLink,
            child: Text('Go to the map'),
          ),
        ),
      ),
    );
  }
}
