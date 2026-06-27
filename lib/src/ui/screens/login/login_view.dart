import 'package:flutter/material.dart';
import 'package:habit_tracker/src/ui/core/theme/text_levels.dart';
import 'package:habit_tracker/src/ui/core/theme/theme.dart';

//TODO: import from theme.dart or the export file not the actual file
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    padding: EdgeInsetsGeometry.only(
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
              padding: EdgeInsetsGeometry.only(left: 20, right: 20),
              child: Card(
                margin: EdgeInsets.only(top: 30),
                color: Color.lerp(ColorPalette.primary, Colors.white, .85),
                child: Padding(
                  padding: EdgeInsetsGeometry.only(
                    left: 20,
                    right: 20,
                    top: 30,
                    bottom: 10,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                          FilledButton(
                            onPressed: () => {},
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Text("Create account >").bodyText(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
