// import 'package:flutter/material.dart';

// class Roundedbutton extends StatelessWidget {
//   final final String title;

//   const Roundedbutton({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       // width: 450,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Center(
//         child: Text(
//           (title),
//           style: const TextStyle(
//               fontSize: 30, color: Colors.black, fontWeight: FontWeight.w700),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Roundbutton extends StatelessWidget {
  final String title;
  final VoidCallback onpressed;
  final bool loading;
  const Roundbutton({
    super.key,
    required this.title,
    required this.onpressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onpressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator()
              : Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
        ),
      ),
    );
  }
}
