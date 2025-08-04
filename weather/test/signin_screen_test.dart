import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/features/login/signin_screen.dart';
import 'package:weather/features/login/register/signup_screen.dart';
import 'package:weather/features/reset_password.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SignInScreen Widget Tests', () {
    testWidgets('Renders all fields and buttons', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignInScreen()));

      expect(find.text('Enter UserName'), findsOneWidget);
      expect(find.text('Enter Password'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text("Don't have account?"), findsOneWidget);
      expect(find.text("Sign Up"), findsOneWidget);
      expect(find.text("Forgot Password?"), findsOneWidget);
    });

    testWidgets('Navigates to SignUpScreen on SignUp tap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: SignInScreen()));
      await tester.tap(find.text("Sign Up"));
      await tester.pumpAndSettle();

      expect(find.byType(SignUpScreen), findsOneWidget);
    });

    testWidgets('Navigates to ResetPassword on Forgot Password tap', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: SignInScreen()));
      await tester.tap(find.text("Forgot Password?"));
      await tester.pumpAndSettle();

      expect(find.byType(ResetPassword), findsOneWidget);
    });

    testWidgets('Fills input and taps Sign In (no navigation)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: SignInScreen()));

      await tester.enterText(find.byType(TextField).first, 'test@email.com');
      await tester.enterText(find.byType(TextField).last, 'password123');
      await tester.tap(find.text('Sign In'));

      // Wait for async operation
      await tester.pumpAndSettle();

      // Since Firebase is not mocked here, we do not expect navigation.
      expect(find.byType(SignInScreen), findsOneWidget);
    });
  });
}
