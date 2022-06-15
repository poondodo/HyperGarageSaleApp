import 'package:flutter/material.dart';
import 'package:hyper_garage_sale_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Signup Page"),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, '/signinPage', (route) => false);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child:
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "password",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: (){
                    context.read<AuthenticationService>()
                        .signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()
                    )
                        .then((result) {
                      if (result == "signed up") {
                          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      } else {
                        print("bug log from signup page: $result");
                        Navigator.pushNamedAndRemoveUntil(context, '/signupPage', (route) => false);
                      }
                    });

                  },
                  child: const Text("sign up"),
                ),
              ),
            ],
          ),
        )
    );
  }
}
