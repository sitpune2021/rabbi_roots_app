import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbi_roots/models/cart.dart';
import 'package:rabbi_roots/services/api_service.dart';
import 'package:rabbi_roots/widgets/bottomsheet.dart';
import 'package:rabbi_roots/widgets/product_card_sub.dart';
import 'package:rabbi_roots/widgets/product_detail_modal.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rabbi_roots/screens/checkout_screen.dart';
import 'package:badges/badges.dart' as badge;

class CategoryProductsScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final List<String> subcategories;

  const CategoryProductsScreen({
    required this.categoryId,
    required this.categoryName,
    required this.subcategories,
  });

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  bool isLoading = true;
  List<String> subcategories = [];
  String selectedSubcategory = "All";
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchSubcategories();
    fetchProducts("");
  }

  // Fetch subcategories by calling the ApiService
  Future<void> fetchSubcategories() async {
    try {
      final fetchedSubcategories =
          await ApiService().fetchSubcategories(widget.categoryId);
      setState(() {
        subcategories = fetchedSubcategories;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching subcategories: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fetch products by calling the ApiService
  Future<void> fetchProducts(String subcategoryId) async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedProducts =
          await ApiService().fetchProducts(widget.categoryId, subcategoryId);
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching products: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return badge.Badge(
                position: badge.BadgePosition.topEnd(top: 5, end: 5),
                badgeContent: Text(
                  cart.items.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    showCartBottomSheet(context);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar for Subcategories
          isLoading ? buildShimmerSidebar() : buildSubcategorySidebar(),

          // Product Grid
          Expanded(
            child: isLoading
                ? buildShimmerProductGrid()
                : buildProductGrid(products),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomButton(),
    );
  }

  // Build sidebar with subcategories
  Widget buildShimmerSidebar() {
    return Container(
      width: 80,
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              height: 60,
            ),
          );
        },
      ),
    );
  }

  // Build sidebar with actual subcategories
  Widget buildSubcategorySidebar() {
    return Container(
      width: 80,
      color: Colors.grey[200],
      child: ListView.builder(
        itemCount: subcategories.length,
        itemBuilder: (context, index) {
          String subcategory = subcategories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedSubcategory = subcategory;
              });
              fetchProducts(subcategory);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: selectedSubcategory == subcategory
                    ? Colors.green.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Image.asset(
                      "assets/atta.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subcategory,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: selectedSubcategory == subcategory
                          ? Colors.green
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Build the shimmer grid for products
  Widget buildShimmerProductGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }

  // Build the product grid with actual data
  Widget buildProductGrid(List<Map<String, dynamic>> products) {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.68,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductCardScreen(
                  imageUrl: product["imageUrl"] ?? '',
                  weight: product["weight"] ?? '',
                  productName: product["name"] ?? 'Unknown',
                  deliveryTime: product["deliveryTime"] ?? '',
                  price: int.tryParse(product["price"] ?? '0') ?? 0,
                  mrp: int.tryParse(product["mrp"] ?? '0') ?? 0,
                ),
              ),
            );
          },
          child: ProductCard(
            imageUrl: product["imageUrl"] ?? '',
            weight: product["weight"] ?? '',
            productName: product["name"] ?? 'Unknown',
            deliveryTime: product["deliveryTime"] ?? '',
            price: int.tryParse(product["price"] ?? '0') ?? 0,
            mrp: int.tryParse(product["mrp"] ?? '0') ?? 0,
          ),
        );
      },
    );
  }

  // Continue Button at the bottom
  Widget buildBottomButton() {
    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: () {
            // Handle the continue button action
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckoutScreen()),
            );
          },
          child: Text(
            "Continue",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
