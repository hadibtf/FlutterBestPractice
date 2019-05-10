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
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: new EdgeInsets.all(10.0),
        child: new Center(
          child: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                _buildEmailTextField(),
                new SizedBox(
                  height: 10.0,
                ),
                _buildPasswordTextField(),
                _buildAcceptSwich(),
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

  Widget _buildEmailTextField() {
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

  Widget _buildPasswordTextField() {
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

  Widget _buildAcceptSwich() {
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
