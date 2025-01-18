import 'package:flutter/material.dart';
import 'package:food_save/pages/grocery_basket_menu.dart';
import 'package:food_save/pages/kafe_basket_menu.dart';

class OnboardingPage extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      "image": "images/mcdon.png",
      "title": "McDonald's",
    },
    {
      "image": "images/magnum.png",
      "title": "Magnum",
    },
    {
      "image": "images/kfc.png",
      "title": "KFC",
    },
    {
      "image": "images/fermag.jpg",
      "title": "Fermag",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Good morning, User',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Find the tasty and cheaper food',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // "Today's Popular" Section
              Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('images/fermag.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      "Today's Popular",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: Row(
                      children: [
                        DiscountTag('-50%', Colors.red),
                        const SizedBox(width: 8),
                        DiscountTag('-40%', Colors.orange),
                        const SizedBox(width: 8),
                        DiscountTag('-30%', Colors.green),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // "All" Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // List/Grid of Items
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) => FoodItemCard(
                  imagePath: items[index]['image']!,
                  title: items[index]['title']!,
                  onTap: () {
                    // Navigate to different screens based on the item's index or type
                    if (index % 2 == 0) {
                      // Navigate to ScreenTypeA for even-index items
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              KafeBasketMenu(title: items[index]['title']!),
                        ),
                      );
                    } else {
                      // Navigate to ScreenTypeB for odd-index items
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GroceryBasketMenu(title: items[index]['title']!),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class DiscountTag extends StatelessWidget {
  final String label;
  final Color color;

  const DiscountTag(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final Function onTap; // Callback for navigation

  const FoodItemCard({
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(), // Trigger navigation when tapped
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2, // Dynamic height
            width: MediaQuery.of(context).size.width * 0.4, // Dynamic width
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                'Hot',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
