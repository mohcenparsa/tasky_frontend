import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'decorations.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController phoneController;
  final PhoneNumber number;
  final String initialCountry;
  final String? Function(String?)? validator;
  final void Function(PhoneNumber?)? onSaved;

  const PhoneNumberField({
    super.key,
    required this.phoneController,
    required this.number,
    required this.initialCountry,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: containerDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {},
            onInputValidated: (bool value) {},
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              useBottomSheetSafeArea: true,
            ),
            ignoreBlank: false,
            // autoValidateMode: AutovalidateMode.onUserInteraction,
            autoValidateMode: AutovalidateMode.disabled,
            selectorTextStyle: const TextStyle(color: Colors.black),
            initialValue: number,
            textFieldController: phoneController,
            formatInput: false,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            inputDecoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.black12),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
              hintText: '123 456-7890',
            ),
            validator: validator,
            onSaved: (PhoneNumber number) {
              onSaved!(number);
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
