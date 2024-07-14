import 'package:flutter/material.dart';
import 'package:cmru_app/services/post_service.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;

  PostDetailScreen({required this.postId});

  @override
  _PostDetailScreenState createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  // late Future<Post> futurePost;
  dynamic post = {};

  @override
  void initState() {
    super.initState();
    PostService.fetchPage(widget.postId).then((post) {
      setState(() {
        this.post = post;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Detail'),
      ),
      body: Container(
        child: Text(post['content']),
      ),
    );
  }
}
