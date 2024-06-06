import 'package:flutter/material.dart';
import 'package:myapp/home.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late Color myColor;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isPressed = false;

  void _login() {
    String username = emailController.text;
    String password = passwordController.text;
    if (username == 'ash' && password == 'C@Nchela123%') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
      emailController.clear();
      passwordController.clear();
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Oops'),
        content: const Text('Wrong credentials meowy.an \nPlease Try Again.'),
        // backgroundColor: Colors.indigo,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColorDark;
    return Container(
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: _buildForm(),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hi meowy.an",
          style: TextStyle(
            color: Color.fromARGB(255, 55, 162, 26),
            fontSize: 30,
            fontWeight: FontWeight.w500,
            shadows: [
               Shadow(
                color: Colors.black,
                offset: Offset(2, 2),
                blurRadius: 1,
              ),
            ],
          ),
        ),
        const Text(
          "Please log in with your credentials",
          style: TextStyle(
            color: Color.fromARGB(255, 55, 162, 26),
            fontWeight: FontWeight.w500,
            shadows: [
               Shadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildText("User Name"),
        _buildInputField(emailController),
        const SizedBox(height: 20),
        _buildText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        shadows: [
               Shadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 1,
              ),
            ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10),
        //    borderSide:const  BorderSide(
        //     color: Colors.white, // Border color
        //     width: 10, // Border thickness
        //   ),
        // ),
        
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildLoginButton() {
    return Center(
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
          _login();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: _isPressed ? 90 : 100,
          height: 50,
          decoration: BoxDecoration(
            color:const  Color.fromARGB(255, 55, 162, 26),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color:const  Color.fromARGB(255, 55, 162, 26).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            'Log In',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
