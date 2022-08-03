import 'package:fallfirebaseauth/page/homepage.dart';
import 'package:fallfirebaseauth/signin/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Logic ketika masih menunggu bener apa tidak data yg di masukkan sudah sesuai apa blm
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // Logic ketika data yg di masukan salah atau error yg lain
          else if (snapshot.hasError) {
            return const Center(child: Text('Opps Somethink whent wrong'));
          }
          // Logic Ketika data yg di butuh kan sama atau ada
          else if (snapshot.hasData) {
            return const HomePage();
          }
          return const SignIn();
        },
      )),
    );
  }
}
