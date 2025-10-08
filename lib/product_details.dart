import 'package:flutter/material.dart';
import 'index.dart';
import 'login.dart';
import 'cart.dart';
import 'purchase.dart';
import 'aboutus.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final List<Map<String, dynamic>> otherProducts;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.otherProducts,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

  // Helper function to format prices with comma separators
  String _formatPrice(double price) {
    return 'LKR ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Widget _buildPlaceholderLogo() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF212121),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF121212),
            ),
            child: GestureDetector(
              onTap: _navigateToHome,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 60,
                    height: 60,
                    errorBuilder: (context, error, stackTrace) => _buildPlaceholderLogo(),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Wild TRACE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, 'HOME', () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }),
          _buildDrawerItem(Icons.landscape, 'JOURNEY', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutUsScreen()),
            );
          }),
          _buildDrawerItem(Icons.shopping_bag, 'PURCHASE', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PurchaseScreen()),
            );
          }),
          const Divider(color: Color(0xFF4b4b4b)),
          _buildDrawerItem(Icons.shopping_cart, 'CART', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          }),
          _buildDrawerItem(Icons.login, 'LOGIN', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: GestureDetector(
          onTap: _navigateToHome,
          child: Image.asset(
            'assets/logo.png',
            width: 40,
            height: 40,
            errorBuilder: (context, error, stackTrace) => _buildPlaceholderLogo(),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          // Background image with dark overlay
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bgimage.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _buildProductDetailsSection(context),
                _buildPhotographerSection(),
                _buildOtherProductsSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetailsSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF374151).withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Product Image and Info Row
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 768) {
                // Desktop layout
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Expanded(
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(widget.product['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    // Product Info
                    Expanded(
                      child: _buildProductInfo(context),
                    ),
                  ],
                );
              } else {
                // Mobile layout
                return Column(
                  children: [
                    // Product Image
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(widget.product['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Product Info
                    _buildProductInfo(context),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product['title'],
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'By ${widget.product['photographer']}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _formatPrice(widget.product['price']),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${widget.product['category']} | ${widget.product['size']}',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFFD1D5DB),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'A majestic ${widget.product['title'].toString().toLowerCase()} captured in its natural habitat, showcasing the raw beauty of wildlife photography at its finest.',
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF9CA3AF),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        
        // Quantity Selector and Add to Cart
        _buildQuantitySelector(context),
      ],
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    return Row(
      children: [
        // Quantity Selector - Only the increment box
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF4B5563),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.white),
                onPressed: () {
                  if (_quantity > 1) {
                    setState(() {
                      _quantity--;
                    });
                  }
                },
              ),
              Container(
                width: 50,
                height: 40,
                color: Colors.white, // White background for the quantity box
                child: Center(
                  child: Text(
                    _quantity.toString(),
                    style: const TextStyle(
                      color: Colors.black, // Black text for better visibility
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        
        // Add to Cart Button - Navigates to purchase.dart
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // Navigate directly to purchase screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PurchaseScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9CA3AF),
              foregroundColor: const Color(0xFF1F2937),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotographerSection() {
    // Get photographer image based on name - proper mapping
    String getPhotographerImage(String name) {
      switch (name) {
        case 'Aarzoo Khurana':
          return 'assets/teammember3.jpg';
        case 'Mc James':
          return 'assets/teammember1.jpg';
        case 'John Smith':
          return 'assets/teammember2.jpg';
        case 'Thomas Vijayan':
          return 'assets/teammember4.jpg';
        default:
          // Default fallback
          return 'assets/teammember1.jpg';
      }
    }

    // Mock photographer data
    final photographers = [
      {
        'name': widget.product['photographer'],
        'image': getPhotographerImage(widget.product['photographer']),
        'quote': 'Capturing the essence of wildlife through my lens has been my life\'s passion. Every shot tells a story of nature\'s untamed beauty.',
      },
    ];

    return Container(
      width: double.infinity, // Full width
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black, // Solid black background covering whole section
        borderRadius: BorderRadius.circular(0), // No rounded corners
      ),
      child: Column(
        children: [
          const Text(
            'A Word from the Photographer',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: photographers.map((photog) => _buildPhotographerCard(photog)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotographerCard(Map<String, dynamic> photographer) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.transparent, // Remove gray background
        borderRadius: BorderRadius.circular(0), // No rounded corners
      ),
      child: Column(
        children: [
          // Photographer Image - Circle with white border
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2), // White border for the circle
              image: DecorationImage(
                image: AssetImage(photographer['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            photographer['name'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Wildlife Photographer',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            photographer['quote'],
            style: const TextStyle(
              color: Color(0xFFD1D5DB),
              fontSize: 16,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOtherProductsSection(BuildContext context) {
    // Ensure we have at least 4 products for display
    List<Map<String, dynamic>> displayProducts = widget.otherProducts;
    if (displayProducts.length < 4) {
      // If we have less than 4 products, duplicate existing ones to fill the grid
      displayProducts = [
        ...widget.otherProducts,
        ...widget.otherProducts.take(4 - widget.otherProducts.length)
      ];
    } else {
      // If we have more than 4, take only the first 4
      displayProducts = widget.otherProducts.take(4).toList();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Other Products',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 products per row
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.7, // Adjusted aspect ratio
            ),
            itemCount: 4, // Always show exactly 4 products
            itemBuilder: (context, index) => _buildOtherProductCard(displayProducts[index], context),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherProductCard(Map<String, dynamic> product, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Product Image
          Container(
            height: 140, // Adjusted height
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: AssetImage(product['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Product Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        product['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'By ${product['photographer']}',
                        style: const TextStyle(
                          color: Color(0xFFD1D5DB),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Print Size: ${product['size']}',
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _formatPrice(product['price']),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // View Details Button - Full width
                  SizedBox(
                    width: double.infinity, // Full width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              product: product,
                              otherProducts: widget.otherProducts,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD1D5DB),
                        foregroundColor: const Color(0xFF1F2937),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}