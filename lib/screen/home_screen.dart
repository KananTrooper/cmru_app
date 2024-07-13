import 'dart:convert';
import 'package:card_swiper/card_swiper.dart';
import 'package:cmru_app/config/app.dart';
import 'package:cmru_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> banners = [];

  Future<void> fetchBanners() async {
    try {
      final response = await http.get(Uri.parse('${API_URL}/api/banners'));
      final List<dynamic> bannersList = jsonDecode(response.body);
      setState(() {
        banners = bannersList;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    AuthService().checkLogIn().then((loggedIn) {
      if (!loggedIn) {
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        fetchBanners();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(banners[index]['imageUrl']);
              },
              itemCount: banners.length,
              pagination: const SwiperPagination(),
              autoplay: true,
            ),
          ),
        ],
      ),
    );
  }
}
