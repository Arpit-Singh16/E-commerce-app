<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quotetowallpaper/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

<<<<<<< HEAD
import 'Admin/Adminpage.dart';
import 'Bottom_navgation.dart';
import 'Forgrtpassword.dart';
=======
import 'Bottom_navgation.dart';
import 'Product_page.dart';
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
<<<<<<< HEAD
    var username = usernameController.text.trim();
    var password = passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final auth = FirebaseAuth.instance;
        final result = await auth.signInWithEmailAndPassword(
          email: username,
          password: password,
        );

        final user = result.user;
        if (user != null) {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

          final userData = userDoc.data();

          // Save to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("email", username);
          prefs.setString("password", password);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successful!')),
          );

          final isAdmin = userData?['isAdmin'] ?? false;

          if (isAdmin) {
            // Show dialog for admin choice
            _showAdminChoiceDialog();
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BottomNavgation()),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }

      setState(() => _isLoading = false);
    }
  }

  void _showAdminChoiceDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Admin Access"),
        content: const Text("You are an admin. Where do you want to go?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const BottomNavgation()),
              );
            },
            child: const Text("User Home"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) =>  Adminpage()),
              );
            },
            child: const Text("Go to Admin Panel"),
          ),
        ],
      ),
    );
=======
    var username = usernameController.text;
    var password = passwordController.text;
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Proceed with Firebase authentication
      try {
        var instance = FirebaseAuth.instance;
        await instance.signInWithEmailAndPassword(
          email: username,
          password: password,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavgation()),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login successful!')));

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("email", username);
        prefs.setString("password", password);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
      }

      // Simulate a network call
      await Future.delayed(const Duration(seconds: 2));
      print('Username: ${usernameController.text}');
      print('Password: ${passwordController.text}');

      // For now, just print and maybe navigate or show a message

      setState(() {
        _isLoading = false;
      });
    }
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
<<<<<<< HEAD
=======
              mainAxisAlignment: MainAxisAlignment.center,
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
<<<<<<< HEAD
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Enter your email' : null,
                ),
=======
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),

>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
<<<<<<< HEAD
=======
                    hintText: 'Enter your password',
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
<<<<<<< HEAD
                  validator: (value) =>
                  value == null || value.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
=======
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                ),
                const SizedBox(height: 30.0),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
<<<<<<< HEAD
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    textStyle: const TextStyle(fontSize: 18.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Login',style: TextStyle(color: Colors.white),),
                ),
=======
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          textStyle: const TextStyle(fontSize: 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Login'),
                      ),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
<<<<<<< HEAD
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
=======
                        // TODO: Navigate to Sign Up page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                        print('Navigate to Sign Up');
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                      },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
<<<<<<< HEAD
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordPage()));
                  },
                  child: const Text('Forgot Password?'),
                ),
=======
                    // TODO: Implement Forgot Password functionality
                    print('Forgot Password?');
                  },
                  child: const Text('Forgot Password?'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavgation(),
                      ),
                    );
                  },
                  child: Text("home"),
                ),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
              ],
            ),
          ),
        ),
      ),
    );
  }
}
