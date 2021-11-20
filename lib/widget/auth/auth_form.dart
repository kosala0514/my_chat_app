import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String name,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool isloading;
  const AuthForm({Key? key, required this.submitFn, required this.isloading})
      : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _islogin = true;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName.trim(),
          _islogin, context);
      // print(_userEmail);
      // print(_userName);
      // print(_userPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                      key: ValueKey("email"),
                      validator: (value) {
                        if (value!.isEmpty || value.contains("@")) {
                          return "Please enter valid email";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Address"),
                      onSaved: (value) {
                        _userEmail = value!;
                      }),
                  !_islogin
                      ? TextFormField(
                          key: ValueKey("username"),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 4) {
                              return "Enter at Least 4 characters";
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: "Username"),
                          onSaved: (value) {
                            _userName = value!;
                          },
                        )
                      : Text(""),
                  TextFormField(
                    key: ValueKey("password"),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return "Password must be at least 7 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  widget.isloading
                      ? CircularProgressIndicator()
                      : RaisedButton(
                          onPressed: _trySubmit,
                          child: Text(_islogin ? "Login" : "Sign Up"),
                        ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _islogin = !_islogin;
                      });
                    },
                    child: Text(_islogin
                        ? "Create new account ?"
                        : "I have an account"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
