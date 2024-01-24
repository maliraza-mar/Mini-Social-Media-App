import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_socialmedia/pages/profile_page.dart';
import 'package:mini_socialmedia/pages/users_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // -- drawer header
              DrawerHeader(
                child: Icon(Icons.favorite, color: Theme.of(context).colorScheme.inversePrimary,),
              ),

              const SizedBox(height: 25,),

              // -- home tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.home, color: Theme.of(context).colorScheme.inversePrimary),
                  title: const Text('H O M E'),
                  onTap: (){
                    // this is already home screen so just pop drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(height: 10,),

              // -- profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.person, color: Theme.of(context).colorScheme.inversePrimary),
                  title: const Text('P R O F I L E'),
                  onTap: (){
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to profile page
                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),

              const SizedBox(height: 10,),

              // -- users tile
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(Icons.group, color: Theme.of(context).colorScheme.inversePrimary),
                  title: const Text('U S E R S'),
                  onTap: (){
                    // pop drawer
                    Navigator.pop(context);

                    // navigate to profile page
                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),
            ],
          ),

          // -- logout tile
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.inversePrimary),
              title: const Text('L O G O U T'),
              onTap: (){
                // pop drawer
                Navigator.pop(context);

                // logout user
                logout();   // 28:25 mint tk dekh li h video
              },
            ),
          ),
        ],
      ),
    );
  }

  // user logout
  void logout(){
    FirebaseAuth.instance.signOut();
  }

}
