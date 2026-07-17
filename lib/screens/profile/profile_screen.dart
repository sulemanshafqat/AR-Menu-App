import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget tile(
    IconData icon,
    String title,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xff2563EB).withValues(alpha: 0.1),
          child: Icon(
            icon,
            color: const Color(0xff2563EB),
          ),
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),

          const CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xff2563EB),
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 18),

          const Center(
            child: Text(
              "Guest User",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: Text(
              "guest@spectoxr.com",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),

          const SizedBox(height: 35),

          tile(Icons.person_outline, "Edit Profile"),
          tile(Icons.location_on_outlined, "Saved Addresses"),
          tile(Icons.favorite_border, "Favorites"),
          tile(Icons.settings_outlined, "Settings"),
          tile(Icons.help_outline, "Help & Support"),
          tile(Icons.logout, "Logout"),
        ],
      ),
    );
  }
}