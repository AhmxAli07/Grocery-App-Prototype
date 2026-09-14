// import 'package:prototype/core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:intl_phone_field/phone_number.dart';

// class number extends StatefulWidget {
//   const number({Key? key}) : super(key: key);

//   @override
//   State<number> createState() => _numberState();
// }

// class _numberState extends State<number> {
//   @override
//   Widget build(BuildContext context) {
//     final _auth = FirebaseAuth.instance;
//     String phone = '';
//     String sms = '';
//     final TextEditingController numcontroller = TextEditingController();

//     _signInWithMobileNumber() async {
//       UserCredential _credential;

//       try {
//         await _auth.verifyPhoneNumber(
//           phoneNumber: '+92${numcontroller.text}',
//           verificationCompleted: (PhoneAuthCredential authCredential) async {
//             await _auth.signInWithCredential(authCredential).then((value) {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => GroceryHome()));
//             });
//           },
//           verificationFailed: (e) {
//             print(e);
//           },
//           codeSent: (String verificationId, [int? forceResendingToken]) {
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (context) => AlertDialog(
//                 title: Text('Enter'),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     TextField(
//                       controller: numcontroller,
//                     ),
//                   ],
//                 ),
//                 actions: [
//                   ElevatedButton(
//                     onPressed: () {
//                       sms = numcontroller.text;
//                       PhoneAuthCredential _credential =
//                           PhoneAuthProvider.credential(
//                               verificationId: verificationId, smsCode: sms);
//                       _auth.signInWithCredential(_credential).then((result) {
//                         if (result != null) {
//                           Navigator.pop(context);
//                           Navigator.push(context,
//                               MaterialPageRoute(builder: (context) => GroceryHome()));
//                         }
//                       });
//                     },
//                     child: Text('data'),
//                   ),
//                 ],
//               ),
//             );
//           },
//           codeAutoRetrievalTimeout: (String verificationId) {
//             // You can remove this assignment or make sure 'verificationId' is in scope.
//           },
//           timeout: Duration(seconds: 50),
//         );
//       } catch (e) {
//         print(e);
//       }
//     }

//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//             child: ElevatedButton(
//               onPressed: () {
//                 _signInWithMobileNumber();
//               },
//               child: Text('Check'),
//             ),
//           ),
//           SizedBox(height: 20), // Add spacing between the button and text field
//           Center(
//             child: TextFormField(
//               keyboardType: TextInputType.number,
//               controller: numcontroller,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
