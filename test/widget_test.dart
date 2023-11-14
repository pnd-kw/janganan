// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:janganan/bloc/cubit/cubit/verification_cubit.dart';

import 'package:janganan/main.dart';
import 'package:janganan/repository/auth_repository.dart';
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:janganan/repository/firestore_repository.dart';
// import 'package:janganan/utils/otp_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(Janganan(
      authenticationRepository: AuthenticationRepository(
        prefs: prefs,
      ),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    // Ensure the login button is initially disabled.
    // expect(find.byType(ElevatedButton), findsOneWidget);
    // expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled,
    //     isFalse);

    // // Enter valid email and password.
    // await tester.enterText(
    //     find.byType(TextFormField).at(0), 'bloodyraven7@gmail.com');
    // await tester.enterText(find.byType(TextFormField).at(1), 'Pandu1992');

    // // Pump the widget again.
    // await tester.pump();

    // // Ensure the login button is enabled.
    // expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled,
    //     isTrue);

    // // Tap the login button.
    // await tester.tap(find.byType(ElevatedButton));
    // await tester.pump();
  });
}
