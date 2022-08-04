// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:productos_app_flutter/providers/login_form_provider.dart';
import 'package:productos_app_flutter/providers/notification_services.dart';
import 'package:productos_app_flutter/services/services.dart';
import 'package:productos_app_flutter/widgets/input_decoration.dart';
import 'package:productos_app_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 200),
              CardContainer(
                child: Column(children: [
                  const SizedBox(height: 10),
                  Text('Crear cuenta',
                      style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm())
                ]),
              ),
              const SizedBox(height: 50),
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  child: const Text(
                    '¿Ya tienes una cuenta? Ir a login',
                    style: TextStyle(fontSize: 18),
                  )),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginFormProvider = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'mail@example.com',
                prefixIcon: Icons.email_rounded),
            onChanged: (value) => loginFormProvider.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El correo no es válido';
            },
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                labelText: 'Contraseña',
                hintText: 'Contraseña',
                prefixIcon: Icons.lock),
            onChanged: (value) => loginFormProvider.password = value,
            validator: (value) {
              return value != null && value.length >= 6
                  ? null
                  : 'La contraseña no es válida';
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  minimumSize: const Size(double.maxFinite, 50)),
              onPressed: loginFormProvider.isLoading
                  ? null
                  : () async {
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      FocusScope.of(context).unfocus();

                      loginFormProvider.isLoading = true;
                      if (loginFormProvider.isFormValid()) {
                        final errorMessage = await authService.createUser(
                            email: loginFormProvider.email,
                            password: loginFormProvider.password);
                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          NotificationService.showSnackbar(
                              message: errorMessage);
                        }
                      }
                      loginFormProvider.isLoading = false;
                    },
              child:
                  Text(loginFormProvider.isLoading ? 'Espere...' : 'Ingresar'),
            ),
          )
        ],
      ),
    );
  }
}
