import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tasky/src/components/form/custom_dropdown_field.dart';
import 'package:tasky/src/components/form/custom_number_field.dart';
import 'package:tasky/src/components/form/custom_text_field.dart';
import 'package:tasky/src/components/form/form_fields.dart';
import 'package:tasky/src/components/form/phone_number_field.dart';
import 'package:tasky/src/pages/onboarding_page.dart';
import 'package:tasky/src/services/auth_service.dart';

import '../components/common/art_image.dart';
import '../components/form/validators.dart';
import '../constants/dropdown_options.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  String initialCountry = 'IQ';
  PhoneNumber number = PhoneNumber(isoCode: 'IQ');
  late String level = "senior";
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ArtImage(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    CustomTextField(
                      controller: nameController,
                      labelText: 'Name',
                      validator: requiredValidator,
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
                    CustomNumberField(
                      controller: experienceController,
                      labelText: 'Years of Experience',
                      keyboardType: TextInputType.number,
                      validator: requiredValidator,
                    ),
                    CustomDropdownFormField(
                      value: level,
                      options: profileLevel,
                      onChanged: (newValue) {
                        setState(() {
                          level = newValue!;
                        });
                      },
                      validator: requiredValidator,
                      labelText: 'Experience Level',
                    ),
                    CustomTextField(
                      controller: addressController,
                      labelText: 'Address',
                      validator: requiredValidator,
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
                      label: "Sign up",
                      formKey: formKey,
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          formKey.currentState?.save();

                          bool register = await AuthService.register(
                              phone: phoneNumber,
                              password: passwordController.text,
                              displayName: nameController.text,
                              experienceYears: experienceController.text,
                              address: addressController.text,
                              level: level);

                          if (register == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OnboardingPage()),
                            );
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    const Redirect(
                      text: "Already have an account?",
                      routeName: '/signin',
                      label: 'Sign In',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    experienceController.dispose();
    addressController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
