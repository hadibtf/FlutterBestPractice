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
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.95;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        child: new Center(
          child: new SingleChildScrollView(
            child: Container(
              width: targetWidth,
              child: new Column(
                children: <Widget>[
                  _buildEmailTextField(),
                  new SizedBox(
                    height: 10.0,
                  ),
                  _buildPasswordTextField(),
                  _buildAcceptSwitch(),
                  new SizedBox(
                    height: 10.0,
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: new Text('LOGIN'),
                          onPressed: _submitForm,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DecorationImage _buildBackgroundImage() {
    return new DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
      image: new AssetImage('images/background.jpg'),
    );
  }

  TextField _buildEmailTextField() {
    return new TextField(
      decoration: new InputDecoration(
        labelText: 'E-Mail',
        filled: true,
        fillColor: Colors.white.withOpacity(0.6),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        setState(() {
          _emailValue = value;
        });
      },
    );
  }

  TextField _buildPasswordTextField() {
    return new TextField(
      decoration: new InputDecoration(
        labelText: 'Password',
        filled: true,
        fillColor: Colors.white.withOpacity(0.6),
      ),
      obscureText: true,
      onChanged: (String value) {
        setState(() {
          _passwordValue = value;
        });
      },
    );
  }

  SwitchListTile _buildAcceptSwitch() {
    return new SwitchListTile(
      value: _acceptTerms,
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
      title: new Text("Accept Terms"),
    );
  }

  void _submitForm() {
    print(_emailValue);
    print(_passwordValue);
    Navigator.pushReplacementNamed(context, '/products');
  }
}
