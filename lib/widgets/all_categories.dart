import 'package:flutter/material.dart';
import 'package:rabbi_roots/models/category2.dart';
import 'package:rabbi_roots/services/api_service.dart';
import 'package:rabbi_roots/widgets/category_card.dart';

class AllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    Future<List<Category>> categories = apiService.fetchCategoriesFromBackend();

    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('All Categories'),
        // shadowColor: Colors.yellow,
      ),
      body: CategoryList(categories: categories),
    );
  }
}
