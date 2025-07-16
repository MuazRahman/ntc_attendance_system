import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'admin_panel_screen.dart';
import 'package:ntc_sas/common/widgets/show_snack_bar_message.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: SizedBox(
                width: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 180,),
                    Center(child: Text('Admin Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),),
                    const SizedBox(height: 64,),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.grey,),
                      ),
                      validator: (String? value) {
                        if(value?.trim().isEmpty ?? true) {
                          return 'Enter a valid email address.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey, ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.grey,),
                      ),
                      obscureText: true,
                      validator: (String? value) {
                        if(value?.trim().isEmpty ?? true) {
                          return 'Enter your valid password.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 36),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // TODO: Move to admin panel;
                          Get.off(AdminPanelScreen());
                        }
                        else if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {

                        }
                        else {
                          // TODO: if auth fail due to invalid data show this.
                          showSnackBarMessage(subtitle: 'Invalid username & password!', isErrorMessage: true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'Log in',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                        child: Text("Login is required only for admins, Teachers don’t need to Login!", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
