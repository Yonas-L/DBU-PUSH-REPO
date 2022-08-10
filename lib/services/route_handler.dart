import 'package:dbu_push/screens/main_screen.dart';

import 'package:dbu_push/screens/pages/page_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HandelAuthentication extends StatelessWidget {
  const HandelAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!.uid);
            //i will create a method that will handel access control

            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return PageNavigator();
            //     },
            //   ),
            // );

            return PageNavigator();
          } else {
            //instead of the auth pages i am return the OnBoardingScreen.
            return OnboardingScreen();
          }
        },
      ),
    );
  }
}
