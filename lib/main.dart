import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_flutter/bloc/bloc.dart';
import 'package:sign_in_flutter/splash.dart';

import 'bloc/delegate/simple_bloc_delegate.dart';
import 'package:bloc/bloc.dart';
import './utils/router/router.dart';

// void main() => runApp(MyApp());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final Router _router;
  MyApp() : _router = Router();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: _multiBlocProviders(), child: _buildMaterialApp());
  }

  List<BlocProvider<Bloc>> _multiBlocProviders() {
    return [
      BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
      BlocProvider<SignUpBloc>(create: (context) => SignUpBloc()),
    ];
  }

  MaterialApp _buildMaterialApp() {
    return MaterialApp(
      builder: (context, child) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            top: false,
            child: MediaQuery(
              child: child,
              data: MediaQuery.of(context).copyWith(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor > 1.0
                      ? 1.0
                      : MediaQuery.of(context).textScaleFactor),
            ),
          ),
        );
      },
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [
        _router.routeObserver,
        // firebase analytics observer
      ],
    );
  }
}
