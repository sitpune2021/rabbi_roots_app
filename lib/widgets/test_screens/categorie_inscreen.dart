import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ScrollController scrollController = ScrollController();

  // Sample category data - Replace with real API data
  final List<Category> categoryList = [
    Category(id: '1', name: 'Electronics', imageUrl: 'assets/atta.png'),
    Category(id: '2', name: 'Clothing', imageUrl: 'assets/atta.png'),
    Category(id: '3', name: 'Food', imageUrl: 'assets/atta.jpg'),
    Category(id: '4', name: 'Health', imageUrl: 'assets/atta.jpg'),
    // Add more categories as needed
  ];

  @override
  void initState() {
    super.initState();
    // Fetch category data (this can be done via an API)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Categories',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              categoryList.isNotEmpty
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: MediaQuery.of(context).size.width > 1200
                            ? 6
                            : MediaQuery.of(context).size.width > 800
                                ? 4
                                : 3,
                        childAspectRatio: 1 / 1,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Implement your navigation logic here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailScreen(
                                    category: categoryList[index]),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 1),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    categoryList[index].imageUrl,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  categoryList[index].name,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 14),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'No categories found.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sample category data model
class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});
}

// Sample Category Detail Screen - You can modify as per your app's requirement
class CategoryDetailScreen extends StatelessWidget {
  final Category category;
  const CategoryDetailScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(category.imageUrl),
            const SizedBox(height: 16),
            Text(category.name, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
