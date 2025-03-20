import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mam/feature/login/model/login_model.dart';
import 'package:mam/feature/login/presentation/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginModel _loginModel = LoginModel();

  bool _isLoading = false;

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Username dan password tidak boleh kosong!')),
        );
      }
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final result = await _loginModel.login(username, password);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login berhasil!')),
      );
      // TODO: Navigate to HomePage or save token
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Login gagal')),
      );
    }

    if (kDebugMode) {
      print('Login result: $result');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png', // Pastikan path benar
                height: 140,
              ),
              const SizedBox(height: 10),
              LoginForm(
                usernameController: _usernameController,
                passwordController: _passwordController,
                onLogin: _handleLogin,
              ),
              if (_isLoading) const CircularProgressIndicator(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
