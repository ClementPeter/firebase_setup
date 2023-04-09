import 'package:firebase_manual/logic/firestore.dart';
import 'package:firebase_manual/utils/snackbar.dart';
import 'package:flutter/material.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  //
  bool isComplete = false;
  //create formkey
  final _formKey = GlobalKey<FormState>();
  //create post controller
  TextEditingController postController = TextEditingController();
  //
  Database database = Database();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await database.createPost(
                            context: context,
                            postMessage: postController.text.trim(),
                          );
                          Navigator.pop(context);
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: isComplete ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: postController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "   Please enter some text";
                      }
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          isComplete = true;
                        });
                      } else {
                        setState(() {
                          isComplete = false;
                        });
                      }
                    },
                    maxLines: 100,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: "What's on your mind?",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Add to your post"),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
