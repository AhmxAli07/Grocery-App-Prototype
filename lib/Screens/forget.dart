import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

// ignore: camel_case_types
class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController email = TextEditingController();
  // final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    // password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await auth.signOut();
                if (!context.mounted) return;
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, '/login');
              },
              icon: const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 0, 94, 255),
              ),
            ),
          ],
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
                  'Forget',
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
        body: ListView(
          children: [
            const SizedBox(height: 30),
            const SizedBox(height: 60),
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
                  const SizedBox(height: 20),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () async {
                      if (_loading || !formKey.currentState!.validate()) return;
                      setState(() => _loading = true);
                      try {
                        await auth.sendPasswordResetEmail(
                          email: email.text.trim(),
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'If the account exists, a reset email has been sent.',
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                e.message ?? 'Could not request a reset email.',
                              ),
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
                                'Forget',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
