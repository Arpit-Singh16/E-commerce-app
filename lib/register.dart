import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Bottom_navgation.dart';
<<<<<<< HEAD
=======
import 'homepage.dart';
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

<<<<<<< HEAD
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final String email = _emailController.text.trim();
        final String password = _passwordController.text.trim();
        final String name = usernameController.text.trim();

        // Create user with FirebaseAuth
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final uid = credential.user!.uid;

        // Save user info to Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'phonenumber': '',
        });

        // Save to SharedPreferences (excluding password for security)
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("email", email);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );

        // Navigate to BottomNavigation
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavgation()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
=======

  Future<void> _register() async {

    var username = _emailController.text.trim();
    var password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      // Here you would typically call your registration logic, e.g., Firebase Auth
      try{
        var instance = FirebaseAuth.instance;
        instance
        .createUserWithEmailAndPassword(email: username, password: password)
        .then((value) async {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavgation(email: _emailController.text)));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );

          var user = FirebaseFirestore.instance.collection('users').doc(_emailController.text);
          user.set({
            'username': usernameController.text,
            'email': _emailController.text,
            'password': _passwordController.text, // Note: Storing passwords like this is not secure!
          }).then((_) {
            print('User data saved successfully');
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("email", username);
          prefs.setString("password", password);

        });
        if(_passwordController.text == _confirmPasswordController.text) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavgation()));
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }

      // Simulate a network call
      await Future.delayed(const Duration(seconds: 2));
      print('Username: ${usernameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');

      setState(() {
        _isLoading = false;
      });
      // Optionally navigate after simulated success
      // Navigator.of(context).pop(); // Go back to login or previous screen
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
<<<<<<< HEAD
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
=======
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30.0),
<<<<<<< HEAD

                /// Name
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Choose a name',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
<<<<<<< HEAD
                    if (value == null || value.isEmpty) return 'Please enter your name';
                    if (value.length < 3) return 'Username must be at least 3 characters';
=======
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length < 3) {
                      return 'Username must be at least 3 characters';
                    }
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
<<<<<<< HEAD

                /// Email
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
<<<<<<< HEAD
                    if (value == null || value.isEmpty) return 'Please enter your email';
                    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
=======
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
<<<<<<< HEAD

                /// Password
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Create a password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
<<<<<<< HEAD
                    if (value == null || value.isEmpty) return 'Please enter a password';
                    if (value.length < 6) return 'Password must be at least 6 characters';
=======
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
<<<<<<< HEAD

                /// Confirm Password
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    prefixIcon: Icon(Icons.lock_open_outlined),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
<<<<<<< HEAD
                    if (value == null || value.isEmpty) return 'Please confirm your password';
                    if (value != _passwordController.text) return 'Passwords do not match';
=======
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
<<<<<<< HEAD

                /// Register Button or Loading
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                    backgroundColor: Colors.black,
=======
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    textStyle: const TextStyle(fontSize: 18.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
<<<<<<< HEAD
                  child: const Text('Register',style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(height: 20.0),

                /// Already have account?
=======
                  child: const Text('Register'),
                ),
                const SizedBox(height: 20.0),
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
<<<<<<< HEAD
                        Navigator.of(context).pop(); // Back to login
=======
                        // Navigate back to Login page
                        Navigator.of(context).pop();
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> bd00922827b5a97f04d8c66ddffd076714c318a6
