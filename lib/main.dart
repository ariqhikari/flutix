import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bwa_flutix/services/services.dart';
import 'package:bwa_flutix/ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
