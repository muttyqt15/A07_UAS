import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:uas/screens/authentication/login.dart';
import 'package:uas/screens/authentication/register.dart';
import 'package:uas/services/auth.dart'; // Assuming you have AuthService for login management
import 'package:uas/screens/profile.dart'; // Assuming you have ProfilePage for displaying user profile

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthService _authService = AuthService();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Check if user is logged in
  Future<void> _checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();
    setState(() {
      _isLoggedIn = loggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Mangan Solo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: request.loggedIn ? _buildLoggedInContent() : _buildLoggedOutContent(),
      ),
    );
  }

  // Content for logged-in users
  Widget _buildLoggedInContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Welcome Back!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'You are successfully logged in.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _handleLogout,
            child: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
          ),
        ],
      ),
    );
  }

  // Content for non-logged-in users
  Widget _buildLoggedOutContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Welcome to Mangan Solo!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Please log in to continue.',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
            },
            child: const Text('Login'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
            },
            child: const Text('Sign Up'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
            },
            child: const Text('Profile Page'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            ),
          ),

        ],
      ),
    );
  }

  // Handle Login button press
  Future<void> _handleLogin() async {
    // Replace this with your login functionality
    Navigator.pushNamed(context, '/login'); // Navigate to your login page
  }

  // Handle Sign Up button press
  Future<void> _handleSignUp() async {
    // Replace this with your sign up functionality
    Navigator.pushNamed(context, '/signup'); // Navigate to your signup page
  }

  // Handle Logout button press
  Future<void> _handleLogout() async {
    await _authService.logout();
    setState(() {
      _isLoggedIn = false;
    });
  }
}