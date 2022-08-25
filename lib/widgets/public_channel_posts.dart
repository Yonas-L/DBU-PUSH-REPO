// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbu_push/utils/helpers/custom_functions.dart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/Theme/app_colors.dart';

class PublicChannelPosts extends StatefulWidget {
  PublicChannelPosts({Key? key}) : super(key: key);

  @override
  State<PublicChannelPosts> createState() => _PublicChannelPostsState();
}

class _PublicChannelPostsState extends State<PublicChannelPosts> {
  String media = '';
  List posts = [];
  List members = [];
  List channels = [];
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final CollectionReference channel =
      FirebaseFirestore.instance.collection('channels');
  final CollectionReference _postReference =
      FirebaseFirestore.instance.collection('posts');
  Future<void> getPublicPost() async {
    // Get channel id  from collection

    await _postReference
        .where('post_type', isEqualTo: 'public')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          return posts.add(element);
        });
        Future.delayed(Duration(seconds: -1), () {
          setState(() {
            media = posts[0]['media_url'];
          });
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPublicPost();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: List.generate(
            posts.length,
            (index) {
              return Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(posts[index]['channel_image']),
                            ),
                          ),
                        ),
                      ),
                      title: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          posts[index]['message'],
                          style: GoogleFonts.roboto(fontSize: 14),
                        ),
                      ),
                    ),
                    VerticalSpacer(10),
                    Padding(
                      padding: EdgeInsets.only(left: 100.0, right: 5),
                      child: posts[index]['media_url'] != ''
                          ? Container(
                              width: double.maxFinite,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    (posts[index]['media_url']),
                                  ),
                                ),
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            )
                          : SizedBox(),
                    )
                  ]);
            },
          ),
        ),
      ],
    );
  }
}
