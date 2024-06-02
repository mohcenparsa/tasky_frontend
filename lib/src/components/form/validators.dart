String? requiredValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}

String? lengthValidator(String? value, int length) {
  if (value == null || value.isEmpty || value.length < length) {
    return 'This field need to be at least 8 chars';
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a valid phone number';
  }
  return null;
}
