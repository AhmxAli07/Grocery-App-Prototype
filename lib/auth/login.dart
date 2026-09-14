// import 'package:prototype/utils/utils.dart';

import 'package:prototype/Phone_Number/you.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// ignore: camel_case_types
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool _isHidden = true;
  bool _loading = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 6, 93, 243),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: email,
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return ('Enter Email');
                        }
                        String pattern = r'^[^\s@]+@[^\s@]+\.[^\s@]+$';
                        if (!RegExp(pattern).hasMatch(value.trim())) {
                          return 'Please Enter Valid Email Format';
                        }
                        return null;
                      }),
                      onSaved: (value) {
                        email.text = value!;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 253, 253),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      controller: password,
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return ('Enter Password');
                        }

                        return null;
                      }),
                      onSaved: (value) {
                        password.text = value!;
                      },
                      obscureText: _isHidden,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),

                        // helperText: 'forget password',
                        // helperStyle: const TextStyle(color: Colors.amber),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 253, 253),
                        suffixIcon: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forget');
                            },
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 0, 94, 255),
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      if (_loading || !formKey.currentState!.validate()) return;
                      setState(() => _loading = true);
                      try {
                        await auth.signInWithEmailAndPassword(
                          email: email.text.trim(),
                          password: password.text,
                        );
                        if (!context.mounted) return;
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/BottomNavBar',
                          (route) => false,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message ?? 'Sign in failed.'),
                            ),
                          );
                        }
                      } finally {
                        if (mounted) setState(() => _loading = false);
                      }
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 89, 87, 87),
                            width: 5,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New User?',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color.fromARGB(255, 6, 93, 243),
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => You()),
                        );
                      },
                      child: Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 89, 87, 87),
                            width: 3,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              SizedBox(width: 15),
                              Text(
                                'Sign in with Phone Number',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87,
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
          ],
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
