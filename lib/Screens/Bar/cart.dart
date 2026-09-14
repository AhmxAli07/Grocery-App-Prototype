import 'package:flutter/material.dart';

class OrderConfirmationMock extends StatefulWidget {
  const OrderConfirmationMock({super.key});

  @override
  State<OrderConfirmationMock> createState() => _OrderConfirmationMockState();
}

class _OrderConfirmationMockState extends State<OrderConfirmationMock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(78.0),
              child: Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: Offset(0, 3), // changes position of shadow
                  //   ),
                  // ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Order confirmation mock',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 3),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'No order has been placed. This is an unfinished UI demo.',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(219, 255, 255, 255),
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 19),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/extra');
              },
              child: SingleChildScrollView(
                child: Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SizedBox(width: 110),
                        Text(
                          'Track your Order',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
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
    );
  }
}
