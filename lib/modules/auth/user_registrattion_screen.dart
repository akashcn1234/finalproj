import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../utils/constants.dart';
import '../../utils/validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  String? emailError;
  String? passwordError;

  bool _obscureText = true;

  final _nameControllers = TextEditingController();
  final _phoneControllers = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    _nameControllers.dispose();
    _phoneControllers.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'SignUp',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              CustomTextField(
                  hintText: 'Enter name',
                  controller: _nameControllers,
                  borderColor: Colors.grey.shade300),
              const SizedBox(height: 30),
              CustomTextField(
                  hintText: 'Enter phone',
                  controller: _phoneControllers,
                  input: TextInputType.number,
                  borderColor: Colors.grey.shade300),
              const SizedBox(height: 30),
              CustomTextField(
                  hintText: 'Enter email',
                  controller: _emailController,
                  errorText: emailError,
                  input: TextInputType.text,
                  borderColor: Colors.grey.shade300),
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
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Confirm password',
                controller: _confirmPasswordController,
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
              const SizedBox(height: 30),
              loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: KButtonColor,
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CustomButton(
                        text: 'SIGN UP',
                        onPressed: () {
                          _signUpHandler(context);
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  _signUpHandler(BuildContext context) async {
    setState(() {
      emailError = validateEmail(_emailController.text);
      passwordError = validatePassword(_passwordController.text);
    });
    if (emailError == null &&
        passwordError == null &&
        _nameControllers.text.isNotEmpty &&
        _phoneControllers.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      if (_passwordController.text == _confirmPasswordController.text) {
        setState(() {
          loading = true;
        });
        try {
          final url = Uri.parse('$baseUrl/api/register/user');
          final response = await http.post(url, body: <String, String>{
            'name': _nameControllers.text,
            'email': _emailController.text,
            'phone': _phoneControllers.text,
            'password': _passwordController.text,
          });

          print(response.body);

          if (response.statusCode == 200) {

            loading = false;
            
            if(context.mounted){

              customSnackBar(context: context, messsage: 'Sucess');
              Navigator.pop(context);
            }
          } else {
            setState(() {
              loading = false;
            });
          }
        } catch (e) {
          setState(() {
            loading = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All fields are required')));
      setState(() {});
    }
  }
}
