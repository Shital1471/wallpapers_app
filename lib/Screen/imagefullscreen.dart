import 'package:flutter/material.dart';

class FullScreen extends StatefulWidget {
  String img;
  FullScreen({super.key ,required this.img});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:NetworkImage(widget.img),
              fit: BoxFit.cover )
          ),
        ),
      ),
    );
  }
}
