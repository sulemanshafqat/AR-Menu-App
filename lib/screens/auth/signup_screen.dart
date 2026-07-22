import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (nameController.text.trim().isEmpty) {
      showMessage("Please enter your full name");
      return;
    }

    if (emailController.text.trim().isEmpty) {
      showMessage("Please enter your email");
      return;
    }

    if (phoneController.text.trim().isEmpty) {
      showMessage("Please enter your phone number");
      return;
    }

    if (passwordController.text.length < 6) {
      showMessage("Password must be at least 6 characters");
      return;
    }

    final auth = context.read<AuthProvider>();

    final error = await auth.register(
      fullName: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      phone: phoneController.text.trim(),
    );

    if (!mounted) return;

    if (error != null) {
      showMessage(error);
      return;
    }

    Navigator.pop(context);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.person_add_alt_1,
                size: 90,
                color: Color(0xff2563EB),
              ),

              const SizedBox(height: 30),

              CustomTextField(
                controller: nameController,
                hint: "Full Name",
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: emailController,
                hint: "Email",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: phoneController,
                hint: "Phone Number",
                icon: Icons.phone_outlined,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: passwordController,
                hint: "Password",
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 35),

              PrimaryButton(
                text: "Create Account",
                loading: auth.isLoading,
                onPressed: register,
              ),
            ],
          ),
        ),
      ),
    );
  }
}