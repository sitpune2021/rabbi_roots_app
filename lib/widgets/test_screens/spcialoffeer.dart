import 'package:flutter/material.dart';

// Replace the imports with the necessary Flutter widgets and logic
class SpecialOfferView extends StatelessWidget {
  final bool isFood;
  final bool isShop;

  const SpecialOfferView({Key? key, required this.isFood, required this.isShop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace GetBuilder with a simple stateful widget or another state management solution like Provider, setState, etc.
    return FutureBuilder<List<Item>>(
      future: _getDiscountedItems(), // Replace with your data fetching method
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ItemShimmerView(isPopularItem: false);
        }

        List<Item>? discountedItemList = snapshot.data;

        return discountedItemList != null && discountedItemList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Container(
                  color: Theme.of(context).disabledColor.withOpacity(0.1),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16.0, right: 16.0),
                        child: TitleWidget(
                          title:
                              'special_offer', // Replace with translated text if needed
                          image:
                              'assets/atta.png', // Replace with your image assets
                          onTap: () {
                            // Navigate to popular items or handle tap action
                          },
                        ),
                      ),
                      SizedBox(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 16.0),
                          itemCount: discountedItemList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, right: 16.0, top: 16.0),
                              child: ItemCard(
                                item: discountedItemList[index],
                                isPopularItem: false,
                                isFood: isFood,
                                isShop: isShop,
                                index: index,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }

  // Mock method for fetching discounted items, replace with your logic
  Future<List<Item>> _getDiscountedItems() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return List.generate(5, (index) => Item()); // Mock items
  }
}

class ItemShimmerView extends StatelessWidget {
  final bool isPopularItem;
  const ItemShimmerView({Key? key, required this.isPopularItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        color: Theme.of(context).disabledColor.withOpacity(0.1),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: TitleWidget(
                title: isPopularItem ? 'most_popular_items' : 'special_offer',
                image: isPopularItem
                    ? 'assets/bakery.png' // Replace with your image assets
                    : 'assets/oats.png',
              ),
            ),
            SizedBox(
              height: 285,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(left: 16.0),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 16.0, right: 16.0, top: 16.0),
                    child: ShimmerLoadingCard(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerLoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 285,
      width: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).shadowColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 15,
                  width: 100,
                  color: Theme.of(context).shadowColor,
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 20,
                  width: 200,
                  color: Theme.of(context).shadowColor,
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 15,
                  width: 100,
                  color: Theme.of(context).shadowColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  // This is a mock class, replace with your actual Item model
}

class ItemCard extends StatelessWidget {
  final Item item;
  final bool isPopularItem;
  final bool isFood;
  final bool isShop;
  final int index;

  const ItemCard({
    Key? key,
    required this.item,
    required this.isPopularItem,
    required this.isFood,
    required this.isShop,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          Image.asset('assets/oil.png'), // Replace with your item image
          Text('Item $index'), // Display item info here
        ],
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback? onTap;

  const TitleWidget({
    Key? key,
    required this.title,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, width: 24.0, height: 24.0),
        const SizedBox(width: 8.0),
        Text(title),
        if (onTap != null)
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: onTap,
          ),
      ],
    );
  }
}
