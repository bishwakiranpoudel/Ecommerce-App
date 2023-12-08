import 'package:batuwa/components/trending-searches.dart';
import 'package:batuwa/screens/explore/explore_category.dart';
import 'package:batuwa/screens/home/components/search_field.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SearchField(),
                TrendingSearches(),
                ExploreCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
