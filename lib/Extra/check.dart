import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductListDemo extends StatefulWidget {
  const ProductListDemo({super.key});

  @override
  State<ProductListDemo> createState() => _ProductListDemoState();
}

class _ProductListDemoState extends State<ProductListDemo> {
  final design = FirebaseFirestore.instance.collection('products').snapshots();

  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _imageController = TextEditingController();
  // final TextEditingController _taskupdateController = TextEditingController();
  // final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/now');
        },
      ),
      appBar: AppBar(title: const Text('Home')),
      body: StreamBuilder<QuerySnapshot>(
        stream: design,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        snapshot.data!.docs[index]['name'].toString(),
                      ),
                      // trailing: snapshot.data!.docs[index]['image'],
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

//                   onLongPress: () {
//                     // ================================== Update Function ===========================================
//                     showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: const Text('Update Task'),
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 TextFormField(
//                                   controller: _taskupdateController,
//                                   decoration: const InputDecoration(
//                                       hintText: 'Enter your task here'),
//                                 )
//                               ],
//                             ),
//                             actions: [
//                               ElevatedButton(
//                                   onPressed: () async {
//                                     // await design
//                                     // .doc(snapshot
//                                     //     .data!.docs[index]['name'].id.toString())
//                                     //     .update({
//                                     //   'date':
//                                     //       '${DateTime.ProductEntryDemo().day}/${DateTime.ProductEntryDemo().month}/${DateTime.ProductEntryDemo().year}',
//                                     //   'name': _nameController.text,
//                                     //   'image': _imageController.text,
//                                     //   'price': _priceController.text
//                                     // });

//                                     Navigator.pop(context);
//                                   },
//                                   child: const Text('Update'))
//                             ],
//                           );
//                         });
//                   },
//                   // ================================== Read Function ===========================================

//                   leading: Image.network(
//                       snapshot.data!.docs[index]['image']),
//                   title: Text(snapshot.data!.docs[index]['name']),
//                   subtitle:
//                       Text('\$ ${snapshot.data!.docs[index]['price']}'),
//                   trailing: IconButton(
//                       onPressed: () {
//                         // ================================== delete Function ===========================================

//                         // design
//                         //     .doc(snapshot.data!.docs[index].id)
//                         //     .delete();
//                       },
//                       icon: const Icon(Icons.close)),
//                 );
//               })
//           : const Center(
//               child: CircularProgressIndicator(),
//             );
//     }),
// floatingActionButton: FloatingActionButton(
//   onPressed: () {
//     // ================================== Add task Function ===========================================
//     showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text(''),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: const InputDecoration(
//                       hintText: 'Enter your name here'),
//                 ),
//                 TextFormField(
//                   controller: _imageController,
//                   decoration: const InputDecoration(
//                       hintText: 'Enter your image here'),
//                 ),
//                 TextFormField(
//                   controller: _priceController,
//                   decoration: const InputDecoration(
//                       hintText: 'Enter your price here'),
//                 )
//               ],
//             ),
// actions: [
//   ElevatedButton(
//       onPressed: () async {
//         String id = DateTime.ProductEntryDemo().millisecondsSinceEpoch.toString();
//         await design
//             .doc(id)
//             .set({
//               'name': _nameController.text.toString(),
//             'id' :id
//             });

// add({
//   'date':
//       '${DateTime.ProductEntryDemo().day}/${DateTime.ProductEntryDemo().month}/${DateTime.ProductEntryDemo().year}',
//   'name': _nameController.text,
//   'image': _imageController.text,
//   'price': _priceController.text
// });
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Add'))
//           ],
//         );
//       });
// },
// child: const Icon(Icons.add),
