import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Login'),
        ),
        body: new Container(
          margin: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                onChanged: (String value) {
                  setState(() {
                    _emailValue = value;
                  });
                },
              ),
              new TextField(
                decoration: new InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    _passwordValue = value;
                  });
                },
              ),
              new SwitchListTile(
                value: _acceptTerms,
                onChanged: (bool value) {
                  setState(() {
                    _acceptTerms = value;
                  });
                },
                title: new Text("Accept Terms"),
              ),
              new SizedBox(
                height: 10.0,
              ),
              new RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: new Text('LOGIN'),
                onPressed: () {
                  print(_emailValue);
                  print(_passwordValue);
                  Navigator.pushReplacementNamed(context, '/products');
                },
              ),
            ],
          ),
        ));
  }
}
