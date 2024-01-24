import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_socialmedia/components/my_button.dart';
import 'package:mini_socialmedia/components/my_textfield.dart';
import 'package:mini_socialmedia/pages/login_page.dart';

import '../helper/helper_functions.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({super.key, required this.onTap});

  final void Function() onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // -- Text Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

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

                // -- username textfield
                MyTextField(
                    hinttext: 'Username',
                    obscureText: false,
                    controller: usernameController
                ),

                const SizedBox(height: 10,),

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

                const SizedBox(height: 10,),

                // -- confirm password textfield
                MyTextField(
                    hinttext: 'Confirm Password',
                    obscureText: true,
                    controller: confirmPasswordController
                ),

                const SizedBox(height: 45,),

                // -- sign in button
                MyButton(
                  text: 'Register',
                  onTap: registerUser,
                ),

                const SizedBox(height: 25,),

                // -- don't have an account? Resgister here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(" Login here", style: TextStyle(fontWeight: FontWeight.bold),)
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

  // -- Register method
  void registerUser() async{
    // -- show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator(),)
    );

    // -- make sure passwords match
    if(passwordController.text != confirmPasswordController.text){
      // -- pop leading circle
      Navigator.pop(context);

      // -- show error message to user
      displayMessageToUser("Password don't match", context);
    }

    // -- If the password do match
    else {
      // -- try creating the user
      try{
        // create the user
        UserCredential? userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );

        // create a user document and add to firestore
        createUserDocument(userCredential);

        // pop leading circle
        if(context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e){
        // pop leading circle
        Navigator.pop(context);

        // display error message
        displayMessageToUser(e.code, context);
      }
    }
  }

  // -- create a user document and store them in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async{
    if(userCredential != null && userCredential.user != null ){
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
            'email' : userCredential.user!.email,
            'username' : usernameController.text
          });
    }
  }
}
