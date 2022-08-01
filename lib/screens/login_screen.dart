import 'package:flutter/material.dart';
import 'package:productos_app_flutter/providers/login_form_provider.dart';
import 'package:productos_app_flutter/widgets/input_decoration.dart';
import 'package:productos_app_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                  Text('Ingreso', style: Theme.of(context).textTheme.headline4),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm())
                ]),
              ),
              const SizedBox(height: 50),
              const TextButton(
                  onPressed: null,
                  child: Text(
                    'Crear una cuenta',
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
                      FocusScope.of(context).unfocus();
                      if (loginFormProvider.isFormValid()) {
                        loginFormProvider.doLogin(context);
                      }
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
