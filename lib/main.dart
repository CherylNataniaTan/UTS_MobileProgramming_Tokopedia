import 'package:flutter/material.dart';
import 'package:tokopedia/widgets/promo_banner.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/category_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Marketplace'),
          backgroundColor: Colors.green,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBarWidget(),
              SizedBox(height: 16),
              PromoBanner(),
              SizedBox(height: 16),
              Text(
                'Kategori',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize:16),
              ),
              SizedBox(height: 8),
              CategoryList(),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.grey,
          ),
          SizedBox(width: 10),
          Text(
            'Search',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
