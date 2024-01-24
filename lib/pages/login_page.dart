import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_socialmedia/components/my_button.dart';
import 'package:mini_socialmedia/components/my_textfield.dart';
import 'package:mini_socialmedia/pages/register_page.dart';

import '../helper/helper_functions.dart';


class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.onTap});

  final void Function() onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // -- Text Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // -- logo
                Icon(Icons.person, size: 80, color: Theme.of(context).colorScheme.inversePrimary,),

                const SizedBox(height: 25,),

                // -- app name
                const Text('M I N I M A L', style: TextStyle(fontSize: 18),),

                const SizedBox(height: 50,),

                // -- email textfield
                MyTextField(
                  hinttext: 'Email',
                  obscureText: false,
                  controller: emailController
                ),

                const SizedBox(height: 10,),

                // -- password textfield
                MyTextField(
                    hinttext: 'Password',
                    obscureText: true,
                    controller: passwordController
                ),

                const SizedBox(height: 15,),

                // -- forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot Password?', style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
                  ],         // 8:10 tk dekhi h 50 mint wali video
                ),

                const SizedBox(height: 25,),

                // -- sign in button
                MyButton(
                    text: 'Login',
                    onTap: loginUser,
                ),

                const SizedBox(height: 25,),

                // -- don't have an account? Resgister here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(" Register here", style: TextStyle(fontWeight: FontWeight.bold),)
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

  // -- Login method
  void loginUser() async {
    // -- show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator(),)
    );

    // try login
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      // pop leading circle
      Navigator.pop(context);

      // display error message
      displayMessageToUser(e.code, context);
    }
  }
}
