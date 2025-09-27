import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../viewmodels/auth_view_model.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/new_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // CircleAvatar(
                    //   radius: 30,
                    //   backgroundColor: Colors.grey,
                    // ),
                    const SizedBox(height: 20),
                    _buildTextField(_emailController, 'Phone number or email address'),
                    _buildTextField(_passwordController, 'Password', obscureText: true),
                    _buildTextField(_confirmPasswordController, 'Confirm Password', obscureText: true),
                    _buildTextField(_fullNameController, 'Full Name'),
                    _buildTextField(_usernameController, 'Username'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool? userExists = await authViewModel.checkUserExists(_usernameController.text);
                          if (userExists == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Username already exists')),
                            );
                            return;
                          }
                          bool success = await authViewModel.signUp(
                            User(
                              fullName: _fullNameController.text,
                              userName: _usernameController.text,
                              email: _emailController.text,
                              phoneNumber: '2345673443', token: '',
                            ),
                            _passwordController.text,
                          );
                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Signup failed')),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: const Text('Sign up', style: TextStyle(color: Colors.white,   fontWeight: FontWeight.bold,fontSize: 20)),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'By signing up, you agree to our Terms, Privacy Policy and Cookies Policy.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold,),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child:RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                          children: [
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.black), // 👈 black input text
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field cannot be empty';
          }
          if (hintText == 'Password' && value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          if (hintText == 'Confirm Password' && value != _passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/user.dart';
// import '../viewmodels/auth_view_model.dart';
// import 'login_screen.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final authViewModel = Provider.of<AuthViewModel>(context);
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Knowreel',
//                   style: TextStyle(fontSize: 36, fontFamily: 'Billabong'),
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(hintText: 'Mobile Number or Email'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Enter a valid email or mobile number';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(hintText: 'Password'),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: _confirmPasswordController,
//                   decoration: InputDecoration(hintText: 'Confirm Password'),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value != _passwordController.text) {
//                       return 'Passwords do not match';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: _fullNameController,
//                   decoration: InputDecoration(hintText: 'Full Name'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Full name is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(hintText: 'Username'),
//                   validator: (value) {
//                     if (value == null || value.length < 3) {
//                       return 'Username must be at least 3 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       bool? userExists =
//                       await authViewModel.checkUserExists(_usernameController.text);
//                       if (userExists == true) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Username already exists')),
//                         );
//                         return;
//                       }
//                       bool success = await authViewModel.signUp(
//                         User(
//                           fullName: _fullNameController.text,
//                           userName: _usernameController.text,
//                           email: _emailController.text,
//                           phoneNumber: '2345673443', token: '',
//                         ),
//                         _passwordController.text,
//                       );
//                       if (success) {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => LoginScreen()),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Signup failed')),
//                         );
//                       }
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(double.infinity, 50),
//                   ),
//                   child: Text('Sign up'),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'By signing up, you agree to our Terms, Privacy Policy and Cookies Policy.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey, fontSize: 12),
//                 ),
//                 SizedBox(height: 20),
//                 Divider(),
//                 SizedBox(height: 10),
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       border: Border.all(color: Colors.grey[300]!)),
//                   child: Center(
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => LoginScreen()),
//                         );
//                       },
//                       child: RichText(
//                         text: TextSpan(
//                           text: 'Have an account? ',
//                           style: TextStyle(color: Colors.black),
//                           children: [
//                             TextSpan(
//                               text: 'Log in',
//                               style: TextStyle(
//                                 color: Colors.blue,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }