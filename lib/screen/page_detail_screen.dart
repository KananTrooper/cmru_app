import 'package:flutter/material.dart';
import 'package:cmru_app/services/page_service.dart';

class PageDetailScreen extends StatefulWidget {
  final String id;

  PageDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _PageDetailScreenState createState() => _PageDetailScreenState();
}

class _PageDetailScreenState extends State<PageDetailScreen> {
  Map<String, dynamic> page = {};

  @override
  void initState() {
    super.initState();
    PageService.fetchPage(widget.id).then((page) {
      setState(() {
        this.page = page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(page['title']),
      ),
      body: Container(
        child: Text(page['content']),
      ),
    );
  }
}
