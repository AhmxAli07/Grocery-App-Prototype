// import 'package:prototype/Phone_Number/verify.dart';
// import 'package:prototype/gridtype/grid1.dart';
import 'package:prototype/Image/upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     IconButton(
      //         onPressed: () async {
      //           await _auth.signOut();
      //           Navigator.pushNamed(context, '/login');
      //         },
      //         icon: const Icon(Icons.logout))
      //   ],
      // ),
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Sign out',
            onPressed: () async {
              try {
                await _auth.signOut();
                if (!context.mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              } on FirebaseAuthException catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'Sign out failed.')),
                  );
                }
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Account',
                style: TextStyle(
                  color: Color.fromARGB(255, 135, 164, 214),
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          Card(
            color: const Color.fromARGB(255, 135, 164, 214),
            child: ListTile(
              title: const Text(
                'Photo upload experiment',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              leading: const Icon(
                Icons.person_2,
                size: 40,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhotoUploadScreen(),
                  ),
                );
                // await _auth.signOut();
                // ignore: use_build_context_synchronously
                // Navigator.pushNamed(context, '/login');
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const FruitGridDemo()));
              },
            ),
          ),
          const SizedBox(height: 30),
          Card(
            color: const Color.fromARGB(255, 135, 164, 214),
            child: ListTile(
              title: const Text(
                'Orders (not implemented)',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              leading: const Icon(
                Icons.shopping_basket,
                size: 40,
                color: Colors.black,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Order history is not implemented.'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          Card(
            color: const Color.fromARGB(255, 135, 164, 214),
            child: ListTile(
              title: const Text(
                'Payment',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              leading: const Icon(
                Icons.credit_card,
                size: 40,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/pay');
              },
            ),
          ),
          const SizedBox(height: 30),
          Card(
            color: const Color.fromARGB(255, 135, 164, 214),
            child: ListTile(
              title: const Text(
                'Address (not implemented)',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              leading: const Icon(
                Icons.location_on_sharp,
                size: 40,
                color: Colors.black,
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Address management is not implemented.'),
                  ),
                );
                // // ignore: use_build_context_synchronously
                // Navigator.pushNamed(context, '/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
