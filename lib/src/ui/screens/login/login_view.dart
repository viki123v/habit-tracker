import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_tracker/src/ui/core/theme.dart';
import 'package:habit_tracker/src/ui/screens/login/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  @override
  void dispose() {
    widget._emailController.dispose();
    widget._passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!widget._formKey.currentState!.validate()) return;

    final didLogin = await context.read<LoginViewModel>().login(
      email: widget._emailController.text,
      password: widget._passwordController.text,
    );

    if (didLogin && mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 2,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(brandLogo, fit: BoxFit.contain),
              ),
              Text("Habitly").title(),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Text("Welcome").subheading(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 2,
                      ),
                      child: Text(
                        "Cultivate and sustain healthy habits with ease and rewards.",
                        textAlign: TextAlign.center,
                      ).caption(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Card(
                  margin: const EdgeInsets.only(top: 30),
                  color: Color.lerp(ColorPalette.primary, Colors.white, .85),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 30,
                      bottom: 10,
                    ),
                    child: Form(
                      key: widget._formKey,
                      child: Column(
                        spacing: 18,
                        children: [
                          TextFormField(
                            controller: widget._emailController,
                            enabled: !viewModel.isLoading,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.email],
                            validator: (value) {
                              final email = value?.trim() ?? '';
                              if (email.isEmpty) return 'Enter your email';
                              if (!RegExp(
                                r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                              ).hasMatch(email)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                          TextFormField(
                            controller: widget._passwordController,
                            enabled: !viewModel.isLoading,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            onFieldSubmitted: (_) => _login(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must have at least 6 characters';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                          if (viewModel.errorMessage != null)
                            Text(
                              viewModel.errorMessage!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          FilledButton(
                            onPressed: viewModel.isLoading ? null : _login,
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: viewModel.isLoading
                                    ? const SizedBox.square(
                                        dimension: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text("Log in >").bodyText(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
