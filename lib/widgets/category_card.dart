import 'package:flutter/material.dart';
import 'package:rabbi_roots/models/category2.dart';
import 'package:rabbi_roots/screens/category_product_screen.dart';

class CategoryList extends StatefulWidget {
  final Future<List<Category>> categories;

  CategoryList({required this.categories});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  TextEditingController _searchController = TextEditingController();
  List<Category> _filteredCategories = [];
  List<Category> _allCategories = []; // Store the original categories

  @override
  void initState() {
    super.initState();
  }

  // Function to filter categories based on search text
  void _filterCategories(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredCategories = _allCategories;
      });
    } else {
      setState(() {
        _filteredCategories = _allCategories
            .where((category) =>
                category.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: widget.categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No categories found!'));
        }

        // Data is available
        if (_allCategories.isEmpty) {
          _allCategories = snapshot.data!; // Store all categories
          _filteredCategories =
              _allCategories; // Initially display all categories
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Box
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  _filterCategories(value); // Filter categories as user types
                },
                decoration: InputDecoration(
                  hintText: 'Search by category name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Categories Grid
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Two items per row
                    childAspectRatio:
                        0.7, // Adjust aspect ratio for the desired layout
                  ),
                  itemCount: _filteredCategories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigate to category products screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryProductsScreen(
                              categoryId: _filteredCategories[index].id,
                              categoryName: _filteredCategories[index].name,
                              subcategories:
                                  _filteredCategories[index].subcategories,
                            ),
                          ),
                        );
                      },
                      child: CategoryCard(category: _filteredCategories[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Container(
        height: 60,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Category image
            Container(
              width: 86,
              height: 85,
              decoration: BoxDecoration(
                color: Colors.blue.shade50, // Background for the image
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.network(
                  height: 80,
                  width: 80,
                  category.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Category name
            SizedBox(
              height: 30,
              child: Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
