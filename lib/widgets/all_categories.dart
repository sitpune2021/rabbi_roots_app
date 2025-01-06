import 'package:flutter/material.dart';
import 'package:rabbi_roots/models/category2.dart';
import 'package:rabbi_roots/services/api_service.dart';
import 'package:rabbi_roots/widgets/category_card.dart';

class AllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    Future<List<Category>> categories = apiService.fetchCategoriesFromBackend();
    // Simulate fetching the full list of categories
    // List<Category> categories = fetchCategoriesFromBackend();

    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(title: Text('All Categories')),
      body: CategoryList(categories: categories),
    );
  }
}
