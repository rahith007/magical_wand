import 'package:flutter/material.dart';
import 'package:magical_wand/models/profile_model.dart';

import '../service/proflie_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: FutureBuilder<ProfileModel>(
          future: ProfileService().getProfile(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white10,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              final data=snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 20),

                  Text("Full Name"),
                  SizedBox(height: 5),
                  Text(data.fullName),

                  SizedBox(height: 15),

                  Text("User Name"),
                  SizedBox(height: 5),
                  Text(data.username),

                  Text("Email"),
                  SizedBox(height: 5),
                  Text(data.email),

                  SizedBox(height: 15),

                  Text("Contact Number"),
                  SizedBox(height: 5),
                  Text(data.contact.toString()),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
