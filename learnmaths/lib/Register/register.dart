import 'package:flutter/material.dart';
import 'package:learnmaths/Login/login_page.dart';
import 'package:provider/provider.dart';
import 'register_controller.dart';
import 'package:learnmaths/device_service.dart';

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SignUpPage(),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<RegisterController>(context);
    return FutureBuilder<String?>(
      future: DeviceService.getDeviceId(),
      builder: (context, snapshot) {
        final deviceId = snapshot.data;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Top Pink Background
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color:Color(0xFF2A2D93),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              // Registration Form Card
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                'assets/images/logo.jpg',
                                width: 150,
                                height:80,
                                fit: BoxFit.contain,
                              ),
                            ),
                            
                          ],
                        ),
                        const SizedBox(height: 18),
                        // Align English language and REGISTER NOW to left
                        Row(
                          children: [
                            const Icon(Icons.language, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            const Text(
                              "English (US)",
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "REGISTER NOW",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Sign Up For Free.",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D1C3F),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                              },
                              child: const Text(
                                "Sign In.",
                                style: TextStyle(color: Color(0xFF2A2D93)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          label: 'Name',
                          icon: Icons.person_outline,
                          hint: 'your name',
                          controller: controller.usernameController,
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          label: 'Mobile Number',
                          icon: Icons.phone_outlined,
                          hint: 'your number',
                          controller: controller.mobileController,
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          label: 'Password',
                          icon: Icons.lock_outline,
                          hint: '********',
                          obscure: controller.obscurePassword,
                          controller: controller.passwordController,
                          suffixIcon: IconButton(
                            icon: Icon(controller.obscurePassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.isLoading ||
                                controller.usernameController.text.trim().isEmpty ||
                                controller.mobileController.text.trim().isEmpty ||
                                controller.passwordController.text.isEmpty ||
                                !_isValidIndianMobile(controller.mobileController.text.trim())
                              ? null
                              : () async {
                                  // Prevent multiple clicks by using a local flag
                                  if (controller.isLoading) return;
                                  try {
                                    final success = await controller.registerUser();
                                    if (!context.mounted) return;
                                    if (success) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Registration Completed.')),
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Registration failed.')),
                                      );
                                    }
                                  } on MobileAlreadyRegisteredException catch (_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Mobile number already registered.')),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Registration failed.')),
                                    );
                                  }
                                },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2A2D93),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: controller.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "SIGN UP",
                                    style: TextStyle(letterSpacing: 1.2, color: Colors.white),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "By clicking the Sign Up button, you agree to the Privacy Policy.",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
             ],
          ),
        );
      },
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hint;
  final bool obscure;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const InputField({
    super.key,
    required this.label,
    required this.icon,
    required this.hint,
    this.obscure = false,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.grey),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

// Add this helper function to the file (outside the widget classes):
bool _isValidIndianMobile(String mobile) {
  final regex = RegExp(r'^[6-9]\d{9}$');
  return regex.hasMatch(mobile);
}