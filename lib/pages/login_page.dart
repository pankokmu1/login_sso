import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            Hero(
              tag: 'hero',
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 48.0,
                child: Image.asset('assets/logo.png'),
              ),
            ),
            SizedBox(height: 48.0),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              initialValue: 'alucard@gmail.com',
              decoration: InputDecoration(
                hintText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              autofocus: false,
              initialValue: 'some password',
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  )),
                ),
                onPressed: ssoLogin,
                child: Text('Log In', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ssoLogin() async {
    final appAuth = FlutterAppAuth();
    try {
      final result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          '1b62d181-b4f9-4b44-87ad-38a2e29066b6',
          'com.example.loginsso://oauth2',
          issuer: 'http://10.0.7.155:9011',
          scopes: [
            'openid',
            'offline_access',
            'email',
          ],
          promptValues: [
            'login',
          ],
          loginHint: 'bob',
          allowInsecureConnections: true,
          additionalParameters: {'idp_hint': '18ca0ac2-b7c4-4f18-8201-5352a3eac2d4'},
        ),
      );
      print(result.idToken);
      Navigator.of(context).pushNamed(HomePage.tag);
    } on PlatformException catch (e) {
      String message = e.message;
      print(message);
    } catch (e) {
      print(e);
    }
  }
}
