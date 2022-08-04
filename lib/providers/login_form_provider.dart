// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  String email = '';
  String password = '';

  bool isFormValid() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<void> doLogin(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();
    Navigator.pushReplacementNamed(context, 'home');
  }
}
