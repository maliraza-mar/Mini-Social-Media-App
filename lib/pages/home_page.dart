import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_socialmedia/components/my_list_tile.dart';
import 'package:mini_socialmedia/components/my_post_button.dart';
import 'package:mini_socialmedia/components/my_textfield.dart';
import 'package:mini_socialmedia/database/firestore.dart';

import '../components/my_drawer.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  // firestore access
  final FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  // -- text controller
  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    // only post if there is something in the text field
    if (newPostController.text.isNotEmpty){
      String message = newPostController.text;
      firestoreDatabase.addPost(message);
    }

    // clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('W A L L'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // TextField Box for user to type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                // text field
                Expanded(
                  child: MyTextField(
                    hinttext: 'Say Something..',
                    obscureText: false,
                    controller: newPostController
                  ),
                ),

                // post button
                PostButton(onTap: postMessage)
              ],
            ),
          ),

          // Posts
          StreamBuilder(
            stream: firestoreDatabase.getPostsStream(),
            builder: (context, snapshot){
              // show loading circle
              if (snapshot.connectionState == ConnectionState.waiting){
                const Center(child: CircularProgressIndicator());
              }

              // get all posts
              final posts = snapshot.data!.docs;

              // no data?
              if (snapshot.data == null || posts.isEmpty){
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text('No post.. Post Something!'),
                  ),
                );
              }

              // return as a list
              return Flexible(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index){
                    // get each individual post
                    final post = posts[index];
                
                    // get data from each post
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    //Timestamp timestamp = post['Timestamp'];
                
                    // return list tile
                    return MyListTile(title: message, subtitle: userEmail);
                  }),
              );
            })
        ],
      ),
    );
  }


}
