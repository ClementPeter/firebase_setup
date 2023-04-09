import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_manual/screens/upload_post.dart';
import 'package:firebase_manual/screens/widgets/button.dart';
import 'package:flutter/material.dart';

//Home Screen : navigates to upload screen and fetches real time data from firestore
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //create a Stream to the post collection
  final Stream<QuerySnapshot> _postStream =
      FirebaseFirestore.instance.collection("posts").snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Firebase Manual Setup',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 25,
                        fontWeight: FontWeight.w800),
                  ),
                  button(
                    height: 30,
                    width: 80,
                    text: "Setup",
                    onPressed: () {},
                    buttonColor: Colors.grey,
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const CircleAvatar(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UploadPost(),
                          ),
                        );
                      },
                      decoration: InputDecoration(
                        hintText: "Write Something",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            // StreamBuilder<QuerySnapshot>(
            //   stream: _postStream,
            //   builder: (BuildContext context,
            //       AsyncSnapshot<QuerySnapshot> snapshot) {
            //     if (snapshot.hasError) {
            //       return const Text('Something went wrong');
            //     }

            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Text("Loading");
            //     }

            //     return Expanded(
            //       child: ListView(
            //         //passing data from firestore to the list view
            //         children:
            //             snapshot.data!.docs.map((DocumentSnapshot document) {
            //           Map<String, dynamic> data =
            //               document.data()! as Map<String, dynamic>;
            //           return Column(
            //             children: [
            //               ListTile(
            //                 leading: const CircleAvatar(),
            //                 title: const Text("John Doe"),
            //                 subtitle: Text(
            //                   DateTime.now().toString(),
            //                 ),
            //               ),
            //               Container(
            //                 child: ListTile(
            //                   title: Text(data['post']),
            //                 ),
            //               ),
            //               const Text(
            //                   "Post from firebase fire stoer comes heere")
            //             ],
            //           );
            //         }).toList(),
            //       ),
            //     );
            //   },
            // )
            StreamBuilder<QuerySnapshot>(
                stream: _postStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return Expanded(
                    child: ListView(
                      // children: [
                      //   ...snapshot.data.docs.map((DocumentSnapshot document) {
                      //     Map<String, dynamic> data =
                      //         document.data() as Map<String, dynamic>;
                      //     return Column(
                      //       children: [
                      // ListTile(
                      //   leading: const CircleAvatar(),
                      //   title: const Text("John Doe"),
                      //   subtitle: Text(
                      //     DateTime.now().toString(),
                      //   ),
                      // ),
                      //         Container(
                      //           child: ListTile(
                      //             title: Text(data['post']),
                      //           ),
                      //         ),
                      //         const Text(
                      //             "Post from firebase fire stoer comes heere")
                      //       ],
                      //     );
                      //   }).toList()
                      // ],
                      children: [
                        ...snapshot.data.docs.map((DocumentSnapshot document) {
                          Map data = document.data() as Map<dynamic, dynamic>;

                          return Column(
                            children: [
                              ListTile(
                                leading: const CircleAvatar(),
                                title: const Text("User xyz"),
                                subtitle: Text(
                                  DateTime.now().toString().substring(0, 10),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  children: [
                                    Text(data["post"]),
                                    Container(
                                      color: Colors.grey,
                                      height: 200,
                                      width: double.infinity,
                                      
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        })
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
