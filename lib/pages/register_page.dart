import 'package:flutter/material.dart';
import 'package:food_save/component/my_button.dart';
import 'package:food_save/component/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void register() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CREATE ACCOUNT', style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(height: 10),
                    MyTextfield(
                      hintText: "EMAIL",
                      icon: Icon(Icons.mail_outline),
                      controller: _emailController,
                      obsecureText: false,
                    ),
                    MyTextfield(
                      hintText: "PASSWORD",
                      icon: Icon(Icons.lock),
                      controller: _passwordController,
                      obsecureText: true,
                    ),
                    MyTextfield(
                      hintText: "CONFIRM PASSWORD",
                      icon: Icon(Icons.lock),
                      controller: _confirmpasswordController,
                      obsecureText: true,
                    ),
                    SizedBox(height: 25,),
                    MyButton(text: "REGISTER", onPressed: register),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        GestureDetector(
                          onTap: onTap,
                          child: Text("Login now", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
