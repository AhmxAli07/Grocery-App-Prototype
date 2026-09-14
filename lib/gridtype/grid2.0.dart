import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LikeButtonDemo());
  }
}

class LikeButtonDemo extends StatefulWidget {
  const LikeButtonDemo({super.key});

  @override
  State<LikeButtonDemo> createState() => _LikeButtonDemoState();
}

class _LikeButtonDemoState extends State<LikeButtonDemo> {
  final Offset _position = Offset(100.0, 100.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movable Like Button')),
      body: Center(
        child: Stack(
          children: [
            // Background content goes here
            // ...

            // Draggable Like Button
            Positioned(
              left: _position.dx,
              top: _position.dy,
              child: Draggable(
                feedback: const LikeButton(),
                child: LikeButton(),
                onDraggableCanceled: (_, _) {
                  // Handle the drag end if needed
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle the like button tap event here
      },
      child: Icon(Icons.favorite, color: Colors.red, size: 30.0),
    );
  }
}
