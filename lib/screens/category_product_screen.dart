import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbi_roots/models/cart.dart';
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
  List<Map<String, dynamic>> subcategories = [];
  String selectedSubcategory = "All";
  List<Map<String, dynamic>> products = [];

  // Mock data
  List<Map<String, dynamic>> mockSubcategories() {
    return [
      {
        'id': '1',
        'name': 'Flours',
        'imageUrl':
            'https://cdn.grofers.com/app/images/category/cms_images/rc-upload-1702734004998-8', // Placeholder image
      },
      {
        'id': '2',
        'name': 'Rice',
        'imageUrl':
            'https://cdn.grofers.com/app/images/category/cms_images/icon/395_1668582176947.png', // Placeholder image
      },
      {
        'id': '3',
        'name': 'Pulses',
        'imageUrl':
            'https://cdn.grofers.com/app/images/category/cms_images/icon/278_1678705041060.png', // Placeholder image
      },
      {
        'id': '4',
        'name': 'Spices',
        'imageUrl':
            'https://cdn.grofers.com/app/images/category/cms_images/rc-upload-1702734004998-3', // Placeholder image
      },
      {
        'id': '5',
        'name': 'Oils',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/fe0b1a25-65c8-4051-88be-4897bff884ed.jpg?ts=1711472717', // Placeholder image
      },
      {
        'id': '6',
        'name': 'Frozen veg',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/images/products/sliding_image/364302a.jpg?ts=1690815239', // Placeholder image
      },
      {
        'id': '7',
        'name': 'Herbs',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/images/products/sliding_image/372028a.jpg?ts=1694867421', // Placeholder image
      },
      {
        'id': '8',
        'name': 'Flowers',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/da/cms-assets/cms/product/ce8f87bc-4a0a-4145-9c5e-862069996df4.jpg?ts=1736323330', // Placeholder image
      },
      {
        'id': '9',
        'name': 'Apples',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/ff98ff54-6e60-4f2b-84c4-f39e3488a492.jpg?ts=1724820766', // Placeholder image
      },
    ];
  }

  List<Map<String, dynamic>> mockProducts(String subcategoryId) {
    return [
      {
        'id': '1',
        'name': 'Product 1',
        'weight': '500g',
        'price': '100',
        'mrp': '150',
        'discount': '30%',
        'deliveryTime': '2-3 days',
        'subcategoryId': '1',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/e80be228-6de3-4e51-96a6-207d9fd7d5d9.jpg?ts=1726553716',
      },
      {
        'id': '2',
        'name': 'Product 2',
        'weight': '1kg',
        'price': '200',
        'mrp': '250',
        'discount': '20%',
        'deliveryTime': '1-2 days',
        'subcategoryId': '2',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/9aed6a6e-9ddb-42a5-970f-db2e1274d9bd.jpg?ts=1717402578',
      },
      {
        'id': '3',
        'name': 'Product 3',
        'weight': '200g',
        'price': '50',
        'mrp': '80',
        'discount': '40%',
        'deliveryTime': '3-4 days',
        'subcategoryId': '3',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/e6ddf56a-8c7d-4391-8b6d-7fea62d370ca.jpg?ts=1716522689',
      },
      {
        'id': '4',
        'name': 'Product 4',
        'weight': '1.5kg',
        'price': '300',
        'mrp': '400',
        'discount': '25%',
        'deliveryTime': '4-5 days',
        'subcategoryId': '4',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/d3131455-8586-473b-9ea6-e8193fad986b.jpg?ts=1711473370',
      },
      {
        'id': '5',
        'name': 'Product 5',
        'weight': '1.5kg',
        'price': '300',
        'mrp': '400',
        'discount': '25%',
        'deliveryTime': '4-5 days',
        'subcategoryId': '5',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/d3131455-8586-473b-9ea6-e8193fad986b.jpg?ts=1711473370',
      },
      {
        'id': '6',
        'name': 'Product 6',
        'weight': '1.5kg',
        'price': '300',
        'mrp': '400',
        'discount': '25%',
        'deliveryTime': '4-5 days',
        'subcategoryId': '6',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/da/cms-assets/cms/product/2bd35640-4748-4f74-a8aa-0f9de2fbed0f.jpg?ts=1732162400',
      },
      {
        'id': '7',
        'name': 'Product 7',
        'weight': '1.5kg',
        'price': '300',
        'mrp': '400',
        'discount': '25%',
        'deliveryTime': '4-5 days',
        'subcategoryId': '7',
        'imageUrl':
            'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/b0cbc6f3-d789-44bb-a57b-c4cd340e1646.jpg?ts=1711442491',
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    fetchSubcategories();
    fetchProducts(""); // Fetch all products initially
  }

  // Fetch subcategories by calling the ApiService (mocked for now)
  Future<void> fetchSubcategories() async {
    try {
      final fetchedSubcategories = mockSubcategories(); // Using mock data here
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

  // Fetch products by calling the ApiService and filtering based on subcategoryId
  Future<void> fetchProducts(String subcategoryId) async {
    setState(() {
      isLoading = true;
    });

    try {
      final allProducts = mockProducts(subcategoryId); // Using mock data here
      // If a subcategory is selected, filter the products by subcategoryId
      final filteredProducts = subcategoryId.isNotEmpty
          ? allProducts
              .where((product) => product['subcategoryId'] == subcategoryId)
              .toList()
          : allProducts;

      setState(() {
        products = filteredProducts;
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
                  style: TextStyle(color: Colors.white, fontSize: 10.0),
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

  // Build sidebar with subcategories (shimmer effect for loading)
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
          String subcategory = subcategories[index]['name'];
          String imageUrl = subcategories[index]['imageUrl'];
          String subcategoryId = subcategories[index]['id'];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedSubcategory = subcategory;
              });
              fetchProducts(
                  subcategoryId); // Fetch products based on selected subcategory
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
                    child: Image.network(
                      imageUrl,
                      height: 30,
                      width: 30,
                      fit: BoxFit.cover,
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

  // Build the shimmer grid for products (shimmer effect for loading)
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
