import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    final user = auth.user;

    Widget tile({
      required IconData icon,
      required String title,
      VoidCallback? onTap,
    }) {
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
          onTap: onTap,
        ),
      );
    }

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

          Center(
            child: Text(
              user == null ? "Guest User" : "Welcome",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Center(
            child: Text(
              user?.email ?? "guest@spectoxr.com",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),

          const SizedBox(height: 35),

          tile(
            icon: Icons.person_outline,
            title: "Edit Profile",
          ),

          tile(
            icon: Icons.location_on_outlined,
            title: "Saved Addresses",
          ),

          tile(
            icon: Icons.favorite_border,
            title: "Favorites",
          ),

          tile(
            icon: Icons.settings_outlined,
            title: "Settings",
          ),

          tile(
            icon: Icons.help_outline,
            title: "Help & Support",
          ),

          tile(
            icon: Icons.logout,
            title: "Logout",
            onTap: () async {
              await context.read<AuthProvider>().logout();
            },
          ),
        ],
      ),
    );
  }
}