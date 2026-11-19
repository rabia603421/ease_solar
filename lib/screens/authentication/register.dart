import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A2342),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Get.back())),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: const Color(0xFFFFB800), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.person_add, color: Color(0xFF0A2342), size: 28),
              ),
              const SizedBox(height: 20),
              const Text('Create account', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const Text('Sign up to get started', style: TextStyle(color: Colors.white70, fontSize: 15)),
              const SizedBox(height: 30),
              TextField(decoration: InputDecoration(filled: true, fillColor: Colors.white, hintText: 'Full Name', prefixIcon: const Icon(Icons.person, color: Color(0xFF0A2342)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
              const SizedBox(height: 16),
              TextField(decoration: InputDecoration(filled: true, fillColor: Colors.white, hintText: 'Email', prefixIcon: const Icon(Icons.email, color: Color(0xFF0A2342)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
              const SizedBox(height: 16),
              TextField(obscureText: true, decoration: InputDecoration(filled: true, fillColor: Colors.white, hintText: 'Password', prefixIcon: const Icon(Icons.lock, color: Color(0xFF0A2342)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFB800), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  child: const Text('Sign Up', style: TextStyle(color: Color(0xFF0A2342), fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? ', style: TextStyle(color: Colors.white70)),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Text('Login', style: TextStyle(color: Color(0xFFFFB800), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}