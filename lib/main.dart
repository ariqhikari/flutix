import 'package:bwa_flutix/services/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Sign Up'),
                onPressed: () async {
                  SignInSignUpResult result = await AuthServices.signUp(
                    'ahidayatbia@gmail.com',
                    'ariq2101',
                    'Ariq H.',
                    ['Action', 'Horror', 'Music', 'Drama'],
                    'Indonesia',
                  );

                  if (result.user == null) {
                    print(result.message);
                  } else {
                    print(result.user.toString());
                  }
                },
              ),
              RaisedButton(
                child: Text('Sign In'),
                onPressed: () async {
                  SignInSignUpResult result = await AuthServices.signIn(
                    'ahidayatbia@gmail.com',
                    'ariq2101',
                  );

                  if (result.user == null) {
                    print(result.message);
                  } else {
                    print(result.user.toString());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
