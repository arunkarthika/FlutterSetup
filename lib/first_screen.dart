

import 'package:flutter/material.dart';
import 'package:sign_in_flutter/login_page.dart';
import 'package:sign_in_flutter/sign_in.dart';

class FirstScreen extends StatelessWidget {
  double screenWidth;
  double screenHeight;
  String image1 = 'assets/images/splash.png';
  bool _visible = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Visibility(
                  visible: _visible,
                  child: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                Container(
                  height: 200.0,
                ),
                Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(100.0),
                      bottomRight: const Radius.circular(100.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: _buildHeaderSection(),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.topLeft,
                    // child: _editbtn(),
                  ),
                ),
              ],
            ),
            _buildAuthSection(context),
          ],
        ),
      ),
    );
  }


    Widget _buildHeaderSection() {
    return Stack(
      children: <Widget>[
        Align(
          child: ClipOval(
            child: ClipOval(
                child: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: 
                      Image.network(
                          imageUrl,
                          fit: BoxFit.fill,
                        ),
                ),
            ),
          ),
        ),
      ],
    );
  }

 Widget _buildAuthSection(context) {
 
      return    Form(
      key: _formKey,
     child: Container(
  padding: EdgeInsets.all(12),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
                padding: EdgeInsets.only(top: 50.0),
        child: TextFormField(
           initialValue: name,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'NAME',
        ),
        
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some Name';
              }
              return null;
            },
          ),
          ),
          Padding(
                padding: EdgeInsets.only(top: 50.0),
               child:  TextFormField(
           initialValue: email,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'EMAIL',
        ),
        
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter EMAIL';
              }
              return null;
            },
          ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.pink,
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Create'),
            ),
          ),
        ],
      ),
     )
    );
  }

}
