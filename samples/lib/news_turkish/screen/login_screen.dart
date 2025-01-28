import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(children: [
              Text('Gündem', style: Theme.of(context).textTheme.titleLarge,),
              Text('deyiz', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600
              ))
            ],),
            TextField(
              decoration: InputDecoration(
                disabledBorder: OutlineInputBorder(
                  
                )
              ),
            ),
            TextField()
          ],
        ),
      ),
    );
  }
}