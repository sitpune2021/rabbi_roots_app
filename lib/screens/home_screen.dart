import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbi_roots/screens/category_product_screen.dart';
import 'package:rabbi_roots/screens/nointernet.dart';
import 'package:rabbi_roots/screens/past_order_screen.dart';
import 'package:rabbi_roots/screens/profile/profile_screen.dart';
import 'package:rabbi_roots/screens/wishlist_screen.dart';
import 'package:rabbi_roots/services/api_service.dart';
import 'package:rabbi_roots/services/connectivity.dart';
import 'package:rabbi_roots/widgets/all_categories.dart';
import 'package:rabbi_roots/widgets/delivery_section.dart';
import 'package:rabbi_roots/widgets/search_bar.dart';
import 'package:rabbi_roots/widgets/banner_view.dart';
import 'package:rabbi_roots/widgets/section_header.dart';
import 'package:rabbi_roots/widgets/category_card.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/category2.dart';

// API Service instance
final ApiService apiService = ApiService();

class HomeScreen extends StatefulWidget {
  final String? message;

  HomeScreen({this.message});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeTabScreen(),
    PastOrdersScreen(),
    WishlistScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.message != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Expanded(child: Text(widget.message!)),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<ConnectivityService>(
        builder: (context, connectivity, child) {
          // If there is no connection, show the NoInternetScreen
          if (connectivity.connectionStatus == ConnectivityResult.none) {
            return NoInternetScreen();
          } else {
            // If connected, show the selected screen
            return _screens[_selectedIndex];
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline), label: 'Wishlist'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            const SliverToBoxAdapter(child: DeliverySection()),
            SliverToBoxAdapter(child: SearchBar1()),
            const SliverToBoxAdapter(child: BannerView(isFeatured: false)),
            SliverToBoxAdapter(
              child: SectionHeader(
                title: 'Grocery & Kitchen',
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllCategoriesScreen(),
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            FutureBuilder<List<Category>>(
              future: apiService.fetchCategoriesFromBackend(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                      child: Center(
                          child: Text(
                              'Failed to load categories: ${snapshot.error}')));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                      child: Center(child: Text('No categories available')));
                }

                final categories = snapshot.data!.take(8).toList();

                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryProductsScreen(
                              categoryId: categories[index].id,
                              categoryName: categories[index].name,
                              subcategories: categories[index].subcategories,
                            ),
                          ),
                        );
                      },
                      child: CategoryCard(category: categories[index]),
                    ),
                    childCount: categories.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
