import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prototype/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

// ignore: camel_case_types
class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController user = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usercol = FirebaseFirestore.instance.collection('user');
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _isHidden = true;
  @override
  void dispose() {
    email.dispose();
    user.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromARGB(255, 6, 93, 243),
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.black,
          title: const Center(
            child: Row(
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 6, 93, 243),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          controller: user,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: 'Username',
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
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
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: password,
                          validator: ((value) {
                            RegExp regex = RegExp(
                              r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
                            );
                            if (value!.isEmpty) {
                              return ('Enter Password');
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Password Contain Digits & Lowercase ");
                            }

                            return null;
                          }),
                          onSaved: (value) {
                            password.text = value!;
                          },
                          maxLength: 8,
                          obscureText: _isHidden,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
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
                                _isHidden
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Roundbutton(
                          onpressed: () async {
                            if (loading || !formKey.currentState!.validate()) {
                              return;
                            }
                            setState(() => loading = true);
                            try {
                              final result = await auth
                                  .createUserWithEmailAndPassword(
                                    email: email.text.trim(),
                                    password: password.text,
                                  );
                              try {
                                await usercol.doc(result.user!.uid).set({
                                  'username': user.text.trim(),
                                  'email': email.text.trim(),
                                  'uid': result.user!.uid,
                                });
                              } on FirebaseException {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Account created, but profile details could not be saved.',
                                      ),
                                    ),
                                  );
                                }
                              }
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
                                    content: Text(
                                      e.message ?? 'Sign up failed.',
                                    ),
                                  ),
                                );
                              }
                            } finally {
                              if (mounted) setState(() => loading = false);
                            }
                          },
                          title: 'Sign up',
                          loading: loading,
                        ),
                      ),
                      GestureDetector(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an Account?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 2),
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Color.fromARGB(255, 6, 93, 243),
                                fontSize: 19,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Center Appbartext() {
    return const Center(
      child: Text(
        'Signup ',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900,
          color: Color.fromARGB(255, 36, 147, 237),
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
