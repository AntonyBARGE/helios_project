import 'package:flutter/material.dart';

import '../data/model/user.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.pictureUrl),
            ),
            const SizedBox(height: 20),
            Text('Email: ${user.email}'),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
