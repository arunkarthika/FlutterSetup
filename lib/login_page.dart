import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_flutter/bloc/bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    var _termsAndCondition =
        'Login means you agree to Terms of Use, Broadcaster  Agreement &\n      Privacy Policy. (You have to be Minimum Age to use UGOlive ) \n  ';
    return buildBlocListener(context, _termsAndCondition);
  }

  // bloc listener
  BlocListener<LoginBloc, LoginState> buildBlocListener(
      BuildContext context, String _termsAndCondition) {
    return BlocListener(
        bloc: BlocProvider.of<LoginBloc>(context),
        listener: (context, LoginState state) {
          if (state is LoginSuccess) {
          } else if (state is LoginFailure) {
            Fluttertoast.showToast(msg: 'Login Failed');
          } else if (state is GoogleLoginSuccess) {

            print('statedata' + state.response.body.message.toString());
          } else if (state is FBLoginSuccess) {}
        },
        child: buildBlocBuilder(context, _termsAndCondition));
  }

  // bloc builder
  BlocBuilder<LoginBloc, LoginState> buildBlocBuilder(
      BuildContext context, String _termsAndCondition) {
    return BlocBuilder<LoginBloc, LoginState>(
        bloc: BlocProvider.of<LoginBloc>(context),
        builder: (context, state) {
          return buildLoginWidget(state, context, _termsAndCondition);
        });
  }

  Widget buildLoginWidget(
      LoginState state, BuildContext context, String _termsAndCondition) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login/BG.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                state is UserNameEmtpy ? Text('User') : Container(),
                Positioned(
                  bottom: 225,
                  left: 75,
                  right: 75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(GoogleLogin());
                        },
                        child: Image(
                          image: AssetImage(
                            'assets/images/login/Gmail.png',
                          ),
                          width: 35,
                          height: 35,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<LoginBloc>(context).add(FBLogin());
                        },
                        child: Image(
                          image: AssetImage(
                            'assets/images/login/Facebook.png',
                          ),
                          width: 35,
                          height: 35,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<LoginBloc>(context).add(TwitterLogin());

                        },
                        child: Image(
                          image: AssetImage(
                            'assets/images/login/Twitter.png',
                          ),
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 200,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      '__________ OR __________',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 150,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<LoginBloc>(context).add(MobilenumberLogin());
                    },
                    child: Icon(
                      Icons.phone_android,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  // top:200,
                  child: GestureDetector(
                    onTap: () {
                      // var textToSend =
                      //     'https://phalcon.sjhinfotech.com/UGOliveWeb/Terms/V1/aboutus.php';
                      // Navigator.of(context).push(MaterialPageRoute<Null>(
                      //     builder: (BuildContext context) {
                      //   return WebViewDisplay(
                      //     text: textToSend,
                      //     webViewTitle: 'UGOlive Terms',
                      //   );
                      // }));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        _termsAndCondition,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Visibility(
                    visible: _visible,
                    child: Container(
                      color: Colors.white54,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _signInButton() {
  //   return OutlineButton(
  //     splashColor: Colors.grey,
  //     onPressed: () {

  //     },
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     highlightElevation: 0,
  //     borderSide: BorderSide(color: Colors.grey),
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 10),
  //             child: Text(
  //               'Sign in with Google',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
