import 'package:flutter/material.dart';
import 'index.dart';
import 'login.dart';
import 'cart.dart';
import 'aboutus.dart';
import 'product_details.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _products = [
    {'title': 'Zebras', 'photographer': 'Mc James', 'category': 'Mammals', 'image': 'assets/product1.jpg', 'price': 45000.00, 'size': '12"x18"'},
    {'title': 'Cheetah Family', 'photographer': 'John Smith', 'category': 'Mammals', 'image': 'assets/product2.jpg', 'price': 50000.00, 'size': '12"x18"'},
    {'title': 'Hipopotamus', 'photographer': 'Aarzoo Khurana', 'category': 'Mammals', 'image': 'assets/product3.jpg', 'price': 50000.00, 'size': '12"x18"'},
    {'title': 'Dugong', 'photographer': 'Thomas Vijayan', 'category': 'Mammals', 'image': 'assets/product4.jpg', 'price': 52000.00, 'size': '16"x24"'},
    {'title': 'Bald Eagle', 'photographer': 'Mc James', 'category': 'Birds', 'image': 'assets/product5.jpg', 'price': 55000.00, 'size': '16"x24"'},
    {'title': 'Greezly Bear', 'photographer': 'John Smith', 'category': 'Mammals', 'image': 'assets/product6.jpg', 'price': 58000.00, 'size': '16"x24"'},
    {'title': 'Snow Leopard', 'photographer': 'Aarzoo Khurana', 'category': 'Mammals', 'image': 'assets/product7.jpg', 'price': 60000.00, 'size': '20"x30"'},
    {'title': 'Greezly Bear', 'photographer': 'Thomas Vijayan', 'category': 'Mammals', 'image': 'assets/product8.jpg', 'price': 62000.00, 'size': '20"x30"'},
    {'title': 'Monkey', 'photographer': 'Mc James', 'category': 'Mammals', 'image': 'assets/product9.jpg', 'price': 65000.00, 'size': '20"x30"'},
    {'title': 'Dolphins', 'photographer': 'John Smith', 'category': 'Aquatics', 'image': 'assets/product10.jpg', 'price': 68000.00, 'size': '24"x36"'},
    {'title': 'Antilope', 'photographer': 'Aarzoo Khurana', 'category': 'Mammals', 'image': 'assets/product11.jpg', 'price': 75000.00, 'size': '24"x36"'},
    {'title': 'Leopard', 'photographer': 'Thomas Vijayan', 'category': 'Mammals', 'image': 'assets/product12.jpg', 'price': 80000.00, 'size': '24"x36"'},
  ];

  final List<String> _photographers = ['All Photographers', 'Mc James', 'John Smith', 'Aarzoo Khurana', 'Thomas Vijayan'];
  final List<String> _categories = ['All Categories', 'Mammals', 'Birds', 'Aquatics'];
  final List<String> _sizes = ['All Sizes', '12"x18"', '16"x24"', '20"x30"', '24"x36"'];
  final List<String> _sortOptions = ['Sort By', 'Price: High to Low', 'Price: Low to High', 'Title: A-Z', 'Title: Z-A'];

  String _selectedPhotographer = 'All Photographers';
  String _selectedCategory = 'All Categories';
  String _selectedSize = 'All Sizes';
  String _selectedSort = 'Sort By';

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Filtered products
  List<Map<String, dynamic>> get _filteredProducts {
    List<Map<String, dynamic>> filtered = List.from(_products);

    if (_selectedPhotographer != 'All Photographers') {
      filtered = filtered.where((p) => p['photographer'] == _selectedPhotographer).toList();
    }
    if (_selectedCategory != 'All Categories') {
      filtered = filtered.where((p) => p['category'] == _selectedCategory).toList();
    }
    if (_selectedSize != 'All Sizes') {
      filtered = filtered.where((p) => p['size'] == _selectedSize).toList();
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  String _formatPrice(double price) {
    return 'LKR ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  Widget _buildPlaceholderLogo() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(color: const Color(0xFF333333), borderRadius: BorderRadius.circular(20)),
      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
    );
  }

  // Drawer menu
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
          _drawerItem(Icons.home, 'HOME', () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()))),
          _drawerItem(Icons.landscape, 'JOURNEY', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsScreen()))),
          _drawerItem(Icons.shopping_bag, 'PURCHASE', () => Navigator.pop(context)),
          const Divider(color: Color(0xFF4b4b4b)),
          _drawerItem(Icons.shopping_cart, 'CART', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()))),
          _drawerItem(Icons.login, 'LOGIN', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
        ],
      ),
    );
  }

  ListTile _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon, color: Colors.white), title: Text(title, style: const TextStyle(color: Colors.white)), onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: GestureDetector(
          onTap: _navigateToHome,
          child: Image.asset('assets/logo.png', width: 40, height: 40, errorBuilder: (_, __, ___) => _buildPlaceholderLogo()),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.shopping_cart, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()))),
          IconButton(icon: const Icon(Icons.person, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
        ],
      ),
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/bgimage.jpg'), fit: BoxFit.cover)),
            child: Container(color: Colors.black.withOpacity(0.8)),
          ),
          SingleChildScrollView(
            child: Column(children: [
              _buildHero(),
              _buildFilters(),
              _buildProducts(),
            ]),
          ),
        ],
      ),
    );
  }

  // Hero section with fade
  Widget _buildHero() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/heroimagepurchase.jpg'), fit: BoxFit.cover)),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bring the Wild Home', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.2), textAlign: TextAlign.center),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text('Bringing the wild to your walls, each photograph a nature\'s untamed story.', style: TextStyle(fontSize: 16, color: Color(0xFFD1D5DB)), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Filters section with fade
  Widget _buildFilters() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _filterDropdown(_photographers, _selectedPhotographer, (v) => setState(() => _selectedPhotographer = v!)),
                _filterDropdown(_categories, _selectedCategory, (v) => setState(() => _selectedCategory = v!)),
                _filterDropdown(_sizes, _selectedSize, (v) => setState(() => _selectedSize = v!)),
                _filterDropdown(_sortOptions, _selectedSort, (v) => setState(() => _selectedSort = v!)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: _clearFilters,
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4B5563), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 10)),
                child: const Text('Clear Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown(List<String> list, String value, ValueChanged<String?> onChanged) {
    return SizedBox(
      width: 180,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(filled: true, fillColor: const Color(0xFF4B5563), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none)),
        dropdownColor: const Color(0xFF4B5563),
        style: const TextStyle(color: Colors.white, fontSize: 14),
        onChanged: onChanged,
        items: list.map((v) => DropdownMenuItem(value: v, child: Text(v, style: const TextStyle(color: Colors.white)))).toList(),
      ),
    );
  }

  // Products grid/list
  Widget _buildProducts() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _filteredProducts.isEmpty
          ? const Center(child: Text('No products found.', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 18)))
          : Column(
              children: _filteredProducts.asMap().entries.map((entry) {
                final index = entry.key;
                final p = entry.value;
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 500 + index * 100),
                  builder: (_, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(offset: Offset(0, 50 * (1 - value)), child: child),
                  ),
                  child: Padding(padding: const EdgeInsets.only(bottom: 16), child: _productCard(p)),
                );
              }).toList(),
            ),
    );
  }

  // Individual product card
  Widget _productCard(Map<String, dynamic> p) {
    return Card(
      color: const Color(0xFF374151),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 200, decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), image: DecorationImage(image: AssetImage(p['image']), fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(p['title'], style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Text('By ${p['photographer']}', style: const TextStyle(color: Color(0xFFD1D5DB), fontSize: 14)),
                const SizedBox(height: 8),
                Text('Print Size: ${p['size']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                const SizedBox(height: 8),
                Text(_formatPrice(p['price']), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: p, otherProducts: _products.where((e) => e != p).take(3).toList()))),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4B5563), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: const Text('View Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
