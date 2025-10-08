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

class _CartScreenState extends State<CartScreen> with SingleTickerProviderStateMixin {
  // --- Cart Items ---
  final List<Map<String, dynamic>> _cartItems = [
    {'title': 'Zebras', 'photographer': 'Mc James', 'price': 45000.0, 'quantity': 1, 'image': 'assets/product1.jpg', 'size': '12"x18"', 'subtotal': 45000.0},
    {'title': 'Cheetah Family', 'photographer': 'John Smith', 'price': 50000.0, 'quantity': 1, 'image': 'assets/product2.jpg', 'size': '12"x18"', 'subtotal': 50000.0},
  ];

  // --- Animation Controller for fade-in ---
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // --- Computed Values ---
  double get _cartTotal => _cartItems.fold(0, (sum, item) => sum + (item['subtotal'] as double));
  int get _cartCount => _cartItems.fold(0, (sum, item) => sum + (item['quantity'] as int));

  // --- Cart Manipulation Methods ---
  void _increaseQuantity(int i) {
    setState(() {
      final item = _cartItems[i];
      item['quantity'] += 1;
      item['subtotal'] = item['price'] * item['quantity'];
    });
  }

  void _decreaseQuantity(int i) {
    setState(() {
      final item = _cartItems[i];
      if (item['quantity'] > 1) {
        item['quantity'] -= 1;
        item['subtotal'] = item['price'] * item['quantity'];
      }
    });
  }

  void _removeItem(int i) => setState(() => _cartItems.removeAt(i));
  void _clearCart() => setState(() => _cartItems.clear());
  void _checkout() => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Proceeding to checkout...')));

  // --- Utilities ---
  String _formatPrice(double price) =>
      'LKR ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';

  void _navigateToHome() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));

  Widget _buildPlaceholderLogo() => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: const Color(0xFF333333), borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
      );

  // --- Drawer Item Widget ---
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) => ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        onTap: onTap,
      );

  // --- Drawer Section ---
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF212121),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF121212)),
            child: GestureDetector(
              onTap: _navigateToHome,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/logo.png', width: 60, height: 60, errorBuilder: (_, __, ___) => _buildPlaceholderLogo()),
                  const SizedBox(height: 10),
                  const Text('Wild TRACE', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          _buildDrawerItem(Icons.home, 'HOME', _navigateToHome),
          _buildDrawerItem(Icons.landscape, 'JOURNEY', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsScreen()))),
          _buildDrawerItem(Icons.shopping_bag, 'PURCHASE', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PurchaseScreen()))),
          const Divider(color: Color(0xFF4b4b4b)),
          _buildDrawerItem(Icons.shopping_cart, 'CART', () {}),
          _buildDrawerItem(Icons.login, 'LOGIN', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
        ],
      ),
    );
  }

  // --- Cart Item Widget with Animation ---
  Widget _buildCartItem(Map<String, dynamic> item, int i) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    Widget productInfo = Row(
      children: [
        FadeTransition(
          opacity: _animController,
          child: Image.asset(
            item['image'],
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: const Color(0xFF4B5563), child: const Icon(Icons.photo, color: Colors.white)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            Text('By ${item['photographer']}', style: const TextStyle(color: Color(0xFFD1D5DB), fontSize: 12)),
            Text('Size: ${item['size']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11)),
            if (!isDesktop) Text(_formatPrice(item['price']), style: const TextStyle(color: Color(0xFFD1D5DB))),
          ]),
        ),
        if (!isDesktop)
          IconButton(icon: const Icon(Icons.delete_outline, color: Color(0xFF9CA3AF)), onPressed: () => _removeItem(i)),
      ],
    );

    Widget quantitySubtotal = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          IconButton(icon: const Icon(Icons.remove, color: Colors.white, size: 16), onPressed: () => _decreaseQuantity(i)),
          Text(item['quantity'].toString(), style: const TextStyle(color: Colors.white, fontSize: 16)),
          IconButton(icon: const Icon(Icons.add, color: Colors.white, size: 16), onPressed: () => _increaseQuantity(i)),
        ]),
        if (!isDesktop)
          Text(_formatPrice(item['subtotal']), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF4B5563)))),
      child: isDesktop
          ? Row(
              children: [
                Expanded(flex: 2, child: productInfo),
                Expanded(child: Text(_formatPrice(item['price']), style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
                Expanded(child: quantitySubtotal),
                Expanded(child: Text(_formatPrice(item['subtotal']), style: const TextStyle(color: Colors.white), textAlign: TextAlign.center)),
                Expanded(child: IconButton(icon: const Icon(Icons.delete_outline, color: Color(0xFF9CA3AF)), onPressed: () => _removeItem(i))),
              ],
            )
          : Column(children: [productInfo, const SizedBox(height: 12), quantitySubtotal]),
    );
  }

  // --- Main Build ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      // --- AppBar with hamburger menu ---
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: GestureDetector(onTap: _navigateToHome, child: Image.asset('assets/logo.png', width: 40, height: 40, errorBuilder: (_, __, ___) => _buildPlaceholderLogo())),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(icon: const Icon(Icons.shopping_cart, color: Colors.white), onPressed: () {}),
              if (_cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(_cartCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                ),
            ],
          ),
          IconButton(icon: const Icon(Icons.person, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
        ],
      ),
      drawer: _buildDrawer(),
      // --- Body Section ---
      body: Stack(
        children: [
          Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/bgimage.jpg'), fit: BoxFit.cover)), child: Container(color: Colors.black.withOpacity(0.8))),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // --- Page Header ---
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                        child: Text('Cart Details', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white))),
                  ),

                  // --- Cart Items Section ---
                  _cartItems.isEmpty
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(color: const Color(0xFF374151).withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
                          child: const Column(
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: 64, color: Color(0xFF9CA3AF)),
                              SizedBox(height: 16),
                              Text('Your cart is empty', style: TextStyle(fontSize: 18, color: Color(0xFFD1D5DB))),
                            ],
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(color: const Color(0xFF374151).withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
                          child: Column(
                              children: _cartItems.asMap().entries.map((e) => _buildCartItem(e.value, e.key)).toList()),
                        ),

                  const SizedBox(height: 24),

                  // --- Cart Summary Section ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: const Color(0xFF374151).withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        const Text('Cart Summary', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white)),
                        const SizedBox(height: 16),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          const Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text(_formatPrice(_cartTotal), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        ]),
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
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
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
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                child: const Text('Clear Cart'),
                              ),
                            ),
                          ],
                        )
                      ],
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
