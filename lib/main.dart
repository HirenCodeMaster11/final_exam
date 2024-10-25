import 'package:final_exam/View/home%20page.dart';
import 'package:final_exam/View/sign_in.dart';
import 'package:final_exam/View/sign_up.dart';
import 'package:final_exam/provider/contact_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          // '/' : (context) => SignIn(),
          // '/' : (context) => SignUp(),
          '/' : (context) => HomePage(),
        },
      ),
    );
  }
}
