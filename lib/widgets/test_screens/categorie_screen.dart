import 'package:flutter/material.dart';
import 'package:rabbi_roots/widgets/test_screens/categorie_inscreen.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<Category> categoryList = []; // Replace with your own data source
  bool isPharmacy = false; // You can update based on your module type
  bool isFood = false; // Update this according to your module type

  // Adding mock data for categoryList
  @override
  void initState() {
    super.initState();
    // Populate the categoryList with mock data
    categoryList = [
      Category(
        id: '1',
        name: 'Electronics',
        imageUrl: 'assets/atta.png',
      ),
      Category(
        id: '2',
        name: 'Clothing',
        imageUrl: 'assets/atta.png',
      ),
      Category(
        id: '3',
        name: 'Food',
        imageUrl: 'assets/atta.png',
      ),
      Category(
        id: '4',
        name: 'Pharmacy',
        imageUrl: 'assets/atta.png',
      ),
      Category(
        id: '5',
        name: 'Furniture',
        imageUrl: 'assets/atta.png',
      ),
      Category(
        id: '6',
        name: 'Toys',
        imageUrl: 'assets/atta.png',
      ),
      Category(
        id: '7',
        name: 'Books',
        imageUrl: 'assets/atta.png',
      ),
      Category(
        id: '8',
        name: 'Sports',
        imageUrl: 'assets/atta.png',
      ),
      Category(
        id: '9',
        name: 'Automobile',
        imageUrl: 'assets/atta.png',
      ),
      Category(
        id: '10',
        name: 'Health',
        imageUrl: 'assets/atta.png',
      ),
      Category(
        id: '11',
        name: 'Beauty',
        imageUrl: 'assets/atta.png',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return isPharmacy
        ? PharmacyCategoryView(categoryList: categoryList)
        : isFood
            ? FoodCategoryView(categoryList: categoryList)
            : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 158,
                          child: categoryList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: categoryList.length > 10
                                      ? 10
                                      : categoryList.length,
                                  padding: const EdgeInsets.all(8),
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: InkWell(
                                        onTap: () {
                                          if (index == 9 &&
                                              categoryList.length > 10) {
                                            // Navigate to CategoryScreen
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryScreen(), // Navigate to CategoryScreen
                                              ),
                                            );
                                          } else {
                                            // Navigate to CategoryItemScreen and pass the categoryId
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryScreen(), // Navigate to CategoryScreen
                                              ),
                                            );
                                          }
                                        },
                                        child: SizedBox(
                                          width: 80,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 75,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        categoryList[index]
                                                            .imageUrl),
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                categoryList[index].name,
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : CategoryShimmer(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
  }
}

class PharmacyCategoryView extends StatelessWidget {
  final List<Category> categoryList;
  const PharmacyCategoryView({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        itemCount: categoryList.length > 10 ? 10 : categoryList.length,
        padding: const EdgeInsets.all(8),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/categoryItem',
                    arguments: categoryList[index].id);
              },
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(categoryList[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    categoryList[index].name,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class FoodCategoryView extends StatelessWidget {
  final List<Category> categoryList;
  const FoodCategoryView({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        itemCount: categoryList.length > 10 ? 10 : categoryList.length,
        padding: const EdgeInsets.all(8),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/categoryItem',
                    arguments: categoryList[index].id);
              },
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(categoryList[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    categoryList[index].name,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      padding: const EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                height: 75,
                width: 75,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                width: 50,
                color: Colors.grey[300],
              ),
            ],
          ),
        );
      },
    );
  }
}

class Category {
  final String id;
  final String name;
  final String imageUrl;

  Category({required this.id, required this.name, required this.imageUrl});
}
