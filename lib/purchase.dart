import 'package:flutter/material.dart';
import 'index.dart';
import 'login.dart';
import 'cart.dart';
import 'aboutus.dart';
import 'product_details.dart'; // Add this import

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  final List<Map<String, dynamic>> _products = [
    {
      'title': 'Zebras',
      'photographer': 'Mc James',
      'category': 'Mammals',
      'image': 'assets/product1.jpg',
      'price': 45000.00,
      'size': '12"x18"',
    },
    {
      'title': 'Cheetah Family',
      'photographer': 'John Smith',
      'category': 'Mammals',
      'image': 'assets/product2.jpg',
      'price': 50000.00,
      'size': '12"x18"',
    },
    {
      'title': 'Hipopotamus',
      'photographer': 'Aarzoo Khurana',
      'category': 'Mammals',
      'image': 'assets/product3.jpg',
      'price': 50000.00,
      'size': '12"x18"',
    },
    {
      'title': 'Dugong',
      'photographer': 'Thomas Vijayan',
      'category': 'Mammals',
      'image': 'assets/product4.jpg',
      'price': 52000.00,
      'size': '16"x24"',
    },
    {
      'title': 'Bald Eagle',
      'photographer': 'Mc James',
      'category': 'Birds',
      'image': 'assets/product5.jpg',
      'price': 55000.00,
      'size': '16"x24"',
    },
    {
      'title': 'Greezly Bear',
      'photographer': 'John Smith',
      'category': 'Mammals',
      'image': 'assets/product6.jpg',
      'price': 58000.00,
      'size': '16"x24"',
    },
    {
      'title': 'Snow Leopard',
      'photographer': 'Aarzoo Khurana',
      'category': 'Mammals',
      'image': 'assets/product7.jpg',
      'price': 60000.00,
      'size': '20"x30"',
    },
    {
      'title': 'Greezly Bear',
      'photographer': 'Thomas Vijayan',
      'category': 'Mammals',
      'image': 'assets/product8.jpg',
      'price': 62000.00,
      'size': '20"x30"',
    },
    {
      'title': 'Monkey',
      'photographer': 'Mc James',
      'category': 'Mammals',
      'image': 'assets/product9.jpg',
      'price': 65000.00,
      'size': '20"x30"',
    },
    {
      'title': 'Dolphins',
      'photographer': 'John Smith',
      'category': 'Aquatics',
      'image': 'assets/product10.jpg',
      'price': 68000.00,
      'size': '24"x36"',
    },
    {
      'title': 'Antilope',
      'photographer': 'Aarzoo Khurana',
      'category': 'Mammals',
      'image': 'assets/product11.jpg',
      'price': 75000.00,
      'size': '24"x36"',
    },
    {
      'title': 'Leopard',
      'photographer': 'Thomas Vijayan',
      'category': 'Mammals',
      'image': 'assets/product12.jpg',
      'price': 80000.00,
      'size': '24"x36"',
    },
  ];

  final List<String> _photographers = [
    'All Photographers',
    'Mc James',
    'John Smith',
    'Aarzoo Khurana',
    'Thomas Vijayan',
  ];

  final List<String> _categories = [
    'All Categories',
    'Mammals',
    'Birds',
    'Aquatics',
  ];

  final List<String> _sizes = [
    'All Sizes',
    '12"x18"',
    '16"x24"',
    '20"x30"',
    '24"x36"',
  ];

  final List<String> _sortOptions = [
    'Sort By',
    'Price: High to Low',
    'Price: Low to High',
    'Title: A-Z',
    'Title: Z-A',
  ];

  String _selectedPhotographer = 'All Photographers';
  String _selectedCategory = 'All Categories';
  String _selectedSize = 'All Sizes';
  String _selectedSort = 'Sort By';

  List<Map<String, dynamic>> get _filteredProducts {
    List<Map<String, dynamic>> filtered = List.from(_products);

    if (_selectedPhotographer != 'All Photographers') {
      filtered = filtered.where((product) => product['photographer'] == _selectedPhotographer).toList();
    }

    if (_selectedCategory != 'All Categories') {
      filtered = filtered.where((product) => product['category'] == _selectedCategory).toList();
    }

    if (_selectedSize != 'All Sizes') {
      filtered = filtered.where((product) => product['size'] == _selectedSize).toList();
    }

    switch (_selectedSort) {
      case 'Price: High to Low':
        filtered.sort((a, b) => b['price'].compareTo(a['price']));
        break;
      case 'Price: Low to High':
        filtered.sort((a, b) => a['price'].compareTo(b['price']));
        break;
      case 'Title: A-Z':
        filtered.sort((a, b) => a['title'].compareTo(b['title']));
        break;
      case 'Title: Z-A':
        filtered.sort((a, b) => b['title'].compareTo(a['title']));
        break;
    }

    return filtered;
  }

  void _clearFilters() {
    setState(() {
      _selectedPhotographer = 'All Photographers';
      _selectedCategory = 'All Categories';
      _selectedSize = 'All Sizes';
      _selectedSort = 'Sort By';
    });
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  // Helper function to format prices with comma separators
  String _formatPrice(double price) {
    return 'LKR ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
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
              color: Colors.black.withOpacity(0.8), // Dark overlay
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(),
                _buildFilterSection(),
                _buildProductsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/heroimagepurchase.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Bring the Wild Home',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'Bringing the wild to your walls, each photograph a nature\'s untamed story.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFD1D5DB),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildFilterDropdown(
                _photographers,
                _selectedPhotographer,
                (value) {
                  setState(() {
                    _selectedPhotographer = value!;
                  });
                },
              ),
              _buildFilterDropdown(
                _categories,
                _selectedCategory,
                (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              _buildFilterDropdown(
                _sizes,
                _selectedSize,
                (value) {
                  setState(() {
                    _selectedSize = value!;
                  });
                },
              ),
              _buildFilterDropdown(
                _sortOptions,
                _selectedSort,
                (value) {
                  setState(() {
                    _selectedSort = value!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: 180, // Reduced width
            child: ElevatedButton(
              onPressed: _clearFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B5563),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10), // Reduced height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6), // Reduced border radius
                ),
              ),
              child: const Text('Clear Filters'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    List<String> options,
    String selectedValue,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      width: 180,
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF4B5563),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        dropdownColor: const Color(0xFF4B5563),
        style: const TextStyle(color: Colors.white, fontSize: 14),
        onChanged: onChanged,
        items: options.map((option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductsList() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _filteredProducts.isEmpty
          ? const Center(
              child: Text(
                'No products found.',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 18,
                ),
              ),
            )
          : Column(
              children: _filteredProducts.map((product) => 
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildProductCard(product),
                )
              ).toList(),
            ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Card(
      color: const Color(0xFF374151),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200, // Increased height for better image display
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, // Center aligned
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Center aligned
                  children: [
                    Text(
                      product['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Center aligned
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'By ${product['photographer']}',
                      style: const TextStyle(
                        color: Color(0xFFD1D5DB),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center, // Center aligned
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Print Size: ${product['size']}',
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center, // Center aligned
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatPrice(product['price']), // Added comma separation
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Center aligned
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to ProductDetailsScreen with the selected product
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            product: product,
                            otherProducts: _getOtherProducts(product),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B5563), // Dark gray
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get other products (excluding the current one)
  List<Map<String, dynamic>> _getOtherProducts(Map<String, dynamic> currentProduct) {
    return _products
        .where((product) => product != currentProduct)
        .take(3)
        .toList();
  }
}