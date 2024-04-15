import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../../db/shared_pref.dart';
import 'user_registrattion_screen.dart';
import '../physcian/phy_home.dart';
import '../user/user_root_screen.dart';
import '../../utils/constants.dart';
import '../../utils/validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../staff/staff_root_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: Colors.white),
  );

  String? emailError;
  String? passwordError;

  bool loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                hintText: 'Enter Email',
                controller: _emailController,
                errorText: emailError,
                borderColor: Colors.grey.shade300,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Enter password',
                controller: _passwordController,
                errorText: passwordError,
                obscureText: _obscureText,
                borderColor: Colors.grey.shade300,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //     onPressed: () {},
              //     child: const Text(
              //       'Forget password',
              //       style: TextStyle(color: Colors.black),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              loading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: KButtonColor,
                    ))
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: CustomButton(
                        text: 'LOG IN',
                        color: KButtonColor,
                        onPressed: () {
                          _loginHandler();
                        },
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont have an account?',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserRegistrationScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: KButtonColor, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _loginHandler() async {
    setState(() {
      emailError = validateEmail(_emailController.text);
      passwordError = validatePassword(_passwordController.text);
    });
    if (emailError == null && passwordError == null) {
      try {
        setState(() {
          loading = true;
        });
        final url = Uri.parse('$baseUrl/api/login');
        final response = await http.post(
          url,
          body: {
            'email': _emailController.text.trim(),
            'password': _passwordController.text.trim(),
          },
        );
        print(response.body);

        var responseData = jsonDecode(response.body);

        if (response.statusCode == 200) {
          DbService.setLoginId(responseData['login_id']);

          if (responseData['role'] == 2) {
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserRootScreen()),
                  (route) => false);


                customSnackBar(context: context, messsage: responseData['message']);


            }
          }

          if (responseData['role'] == 3) {
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StaffRootScreen()),
                  (route) => false);
                  customSnackBar(context: context, messsage: responseData['message']);
            }
          }

          

          if (responseData['role'] == 4) {
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PhyHomeViewScreen()),
                  (route) => false);
              customSnackBar(context: context, messsage: responseData['message']);

            }
          }

          setState(() {
            loading = false;
          });
        } else {
          setState(() {
            loading = false;
          });

          if (context.mounted) {
            customSnackBar(context: context, messsage: responseData['message']);
          }
        }
      } catch (e) {
        setState(() {
          loading = false;
        });

        if (context.mounted) {
          customSnackBar(context: context, messsage: 'Somthing went wrong');
        }
      }
    }
  }
}
