import 'package:flutter/material.dart';
import 'index.dart';
import 'login.dart';
import 'aboutus.dart';
import 'purchase.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> _cartItems = [
    {
      'title': 'Zebras',
      'photographer': 'Mc James',
      'category': 'Mammals',
      'price': 45000.00,
      'quantity': 1,
      'image': 'assets/product1.jpg',
      'size': '12"x18"',
      'subtotal': 45000.00,
    },
    {
      'title': 'Cheetah Family',
      'photographer': 'John Smith',
      'category': 'Mammals',
      'price': 50000.00,
      'quantity': 1,
      'image': 'assets/product2.jpg',
      'size': '12"x18"',
      'subtotal': 50000.00,
    },
  ];

  double get _cartTotal {
    return _cartItems.fold(0, (sum, item) => sum + (item['subtotal'] as double));
  }

  int get _cartCount {
    return _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));
  }

  void _increaseQuantity(int index) {
    setState(() {
      final item = _cartItems[index];
      item['quantity'] = (item['quantity'] as int) + 1;
      item['subtotal'] = (item['price'] as double) * (item['quantity'] as int);
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      final item = _cartItems[index];
      if (item['quantity'] > 1) {
        item['quantity'] = (item['quantity'] as int) - 1;
        item['subtotal'] = (item['price'] as double) * (item['quantity'] as int);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item removed from cart')),
    );
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cart cleared')),
    );
  }

  void _checkout() {
    // TODO: Implement checkout functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proceeding to checkout...')),
    );
  }

  // Helper function to format prices with comma separators
  String _formatPrice(double price) {
    return 'LKR ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
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
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  // Already on cart screen
                },
              ),
              if (_cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _cartCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cart Details heading - center aligned
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        'Cart Details',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Cart Items
                  _buildCartItemsSection(),

                  const SizedBox(height: 24),

                  // Cart Summary
                  _buildCartSummarySection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

  Widget _buildCartItemsSection() {
    if (_cartItems.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF374151).withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Column(
          children: [
            Icon(Icons.shopping_cart_outlined, size: 64, color: Color(0xFF9CA3AF)),
            SizedBox(height: 16),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFD1D5DB),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF374151).withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Desktop Table Header (hidden on mobile)
          if (MediaQuery.of(context).size.width > 600)
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF4B5563))),
              ),
              child: const Row(
                children: [
                  Expanded(flex: 2, child: Text('Product', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
                  Expanded(child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center)),
                  Expanded(child: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center)),
                  Expanded(child: Text('Subtotal', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center)),
                  Expanded(child: Text('Remove', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center)),
                ],
              ),
            ),

          // Cart Items
          ..._cartItems.asMap().entries.map((entry) => _buildCartItem(entry.value, entry.key)),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    if (isDesktop) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFF4B5563))),
        ),
        child: Row(
          children: [
            // Product
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Image.asset(
                    item['image'],
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 64,
                      height: 64,
                      color: const Color(0xFF4B5563),
                      child: const Icon(Icons.photo, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'By ${item['photographer']}',
                          style: const TextStyle(
                            color: Color(0xFFD1D5DB),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Size: ${item['size']}',
                          style: const TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Price
            Expanded(
              child: Text(
                _formatPrice(item['price']),
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),

            // Quantity
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white, size: 16),
                    onPressed: () => _decreaseQuantity(index),
                  ),
                  Text(
                    item['quantity'].toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white, size: 16),
                    onPressed: () => _increaseQuantity(index),
                  ),
                ],
              ),
            ),

            // Subtotal
            Expanded(
              child: Text(
                _formatPrice(item['subtotal']),
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),

            // Remove
            Expanded(
              child: IconButton(
                icon: const Icon(Icons.delete_outline, color: Color(0xFF9CA3AF)),
                onPressed: () => _removeItem(index),
              ),
            ),
          ],
        ),
      );
    } else {
      // Mobile layout
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFF4B5563))),
        ),
        child: Column(
          children: [
            // Product row
            Row(
              children: [
                Image.asset(
                  item['image'],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60,
                    height: 60,
                    color: const Color(0xFF4B5563),
                    child: const Icon(Icons.photo, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'By ${item['photographer']}',
                        style: const TextStyle(
                          color: Color(0xFFD1D5DB),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Size: ${item['size']}',
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatPrice(item['price']),
                        style: const TextStyle(color: Color(0xFFD1D5DB)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Color(0xFF9CA3AF)),
                  onPressed: () => _removeItem(index),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Quantity and subtotal row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quantity controls
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.white, size: 20),
                      onPressed: () => _decreaseQuantity(index),
                    ),
                    Text(
                      item['quantity'].toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.white, size: 20),
                      onPressed: () => _increaseQuantity(index),
                    ),
                  ],
                ),

                // Subtotal
                Text(
                  _formatPrice(item['subtotal']),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _buildCartSummarySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF374151).withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cart Summary',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                _formatPrice(_cartTotal),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _checkout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B5563),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Checkout'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _clearCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B5563),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Clear Cart'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}