import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tasky/src/components/form/form_fields.dart';
import 'package:tasky/src/components/form/phone_number_field.dart';
import 'package:tasky/src/services/auth_service.dart';

import '../components/common/art_image.dart';
import '../components/form/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  String initialCountry = 'IQ';
  PhoneNumber number = PhoneNumber(isoCode: 'IQ');
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ArtImage(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  PhoneNumberField(
                    phoneController: phoneController,
                    number: number,
                    initialCountry: initialCountry,
                    validator: phoneValidator,
                    onSaved: (newValue) {
                      setState(() {
                        phoneNumber = newValue?.phoneNumber;
                      });
                    },
                  ),
                  PasswordField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    toggleObscureText: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    validator: requiredValidator,
                  ),
                  SignUpButton(
                    label: "Sign in",
                    formKey: formKey,
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        formKey.currentState?.save();
                        // Perform sign up action
                        bool successLogin = await AuthService.login(
                          '$phoneNumber',
                          passwordController.text,
                        );

                        if (successLogin) {
                          Navigator.pushReplacementNamed(context, '/tasks');
                        } else {
                          // Show error message if login fails
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login failed. Please try again.'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  const Redirect(
                    text: "Dont have account? ",
                    routeName: '/register',
                    label: 'Sing up',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
