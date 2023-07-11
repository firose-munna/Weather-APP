import 'package:flutter/material.dart';
import 'package:weatherapp/Home.dart';

class GetError extends StatelessWidget {
  const GetError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.6, 0.95],
                colors: [
                  Colors.deepPurple.shade700,
                  Colors.deepPurpleAccent.shade100,
                ],
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "Server Failed, Try Again...",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}