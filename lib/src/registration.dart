import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:oscar_interview/models/constant.dart';
import 'package:oscar_interview/models/registrationdata.dart';
import 'package:oscar_interview/src/allusers.dart';
import 'package:page_transition/page_transition.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';

  @override
  State<StatefulWidget> createState() {
    return new _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _validate = false;
  bool _obscureText = true;
  bool _obscureText1 = true;
  File _image;

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  RegisterData _registerData = RegisterData();
  FocusNode _focusNode;
  String _email;
  String _phone;
  String _name;

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }

//This will change the color of the icon based upon the focus on the field
  Color getPrefixIconColor() {
    return _focusNode.hasFocus ? Colors.black : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        title: Text(
          "Info Page",
          style: GoogleFonts.muli(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: new Center(
        child: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: Center(
              child: new Form(
                key: _key,
                autovalidate: _validate,
                child: _getFormUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFormUI() {
    Future getImage() async {
      //var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      // setState(() {
      //   _image = image;
      //   print('Image Path $_image');
      // });
    }

    return new Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: kPrimaryColor,
                child: ClipOval(
                  child: new SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Image.asset(
                      'assets/images/user.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Name',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: kPrimaryColor),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
            validator: (value) {
              if (value.isEmpty) return 'name cannot be empty';

              return null;
            }),
        new SizedBox(height: 20.0),
        new TextFormField(
            keyboardType: TextInputType.numberWithOptions(),
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Phone Number',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: kPrimaryColor),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _phone = value;
              });
            },
            validator: (value) {
              if (value.isEmpty) return 'phone cannot be empty';
              if (value.length < 10) return 'phone must be more then 9 digits';
              return null;
            }),
        new SizedBox(height: 20.0),
        new TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Email Address',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                borderSide: BorderSide(width: 1, color: kPrimaryColor),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
            // onSaved: (String value) {
            //   setState(() {
            //     _email = value;
            //   });
            //   _registerData.email = value;
            // },
            validator: (value) {
              if (value.isEmpty) return 'email cannot be empty';

              return null;
            }),
        new SizedBox(height: 20.0),
        new Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              if (_key.currentState.validate()) {
                Firestore.instance.collection("users").document().setData({
                  'email': _email,
                  'name': _name,
                  'phone': _phone,
                  "createdAt": DateTime.now(),
                });

                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Allusers(),
                  ),
                ).then((_) => _key.currentState.reset());
              } else {
                setState(() {
                  _validate = true;
                });
              }
            },
            padding: EdgeInsets.all(12),
            color: kPrimaryColor,
            child: Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  _sendToLoginPage() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => LoginPage()),
    // );
  }
}
