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

  String _formatPrice(double price) {
    return 'LKR ${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  void _navigateToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
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
          child: Image.asset('assets/logo.png', width: 40, height: 40, errorBuilder: (_, __, ___) => Container(width: 40, height: 40, color: Colors.grey, child: const Icon(Icons.camera_alt, color: Colors.white))),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.shopping_cart, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()))),
          IconButton(icon: const Icon(Icons.person, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
        ],
      ),
      drawer: Drawer(
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
                    Image.asset('assets/logo.png', width: 60, height: 60, errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: Colors.grey)),
                    const SizedBox(height: 10),
                    const Text('Wild TRACE', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            _drawerItem(Icons.home, 'HOME', () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()))),
            _drawerItem(Icons.landscape, 'JOURNEY', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsScreen()))),
            _drawerItem(Icons.shopping_bag, 'PURCHASE', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PurchaseScreen()))),
            const Divider(color: Color(0xFF4b4b4b)),
            _drawerItem(Icons.shopping_cart, 'CART', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()))),
            _drawerItem(Icons.login, 'LOGIN', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/bgimage.jpg'), fit: BoxFit.cover)), child: Container(color: Colors.black.withOpacity(0.8))),
          SingleChildScrollView(
            child: Column(
              children: [
                _productSection(context),
                _photographerSection(),
                _otherProductsSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon, color: Colors.white), title: Text(title, style: const TextStyle(color: Colors.white)), onTap: onTap);
  }

  Widget _productSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFF374151).withOpacity(0.9), borderRadius: BorderRadius.circular(12)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          Widget image = Container(
            height: constraints.maxWidth > 768 ? 400 : 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: AssetImage(widget.product['image']), fit: BoxFit.cover)),
          );
          Widget info = _productInfo();
          return constraints.maxWidth > 768 ? Row(children: [Expanded(child: image), const SizedBox(width: 32), Expanded(child: info)]) : Column(children: [image, const SizedBox(height: 24), info]);
        },
      ),
    );
  }

  Widget _productInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.product['title'], style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
        const SizedBox(height: 8),
        Text('By ${widget.product['photographer']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
        const SizedBox(height: 16),
        Text(_formatPrice(widget.product['price']), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        Text('${widget.product['category']} | ${widget.product['size']}', style: const TextStyle(fontSize: 16, color: Color(0xFFD1D5DB))),
        const SizedBox(height: 16),
        Text('A majestic ${widget.product['title'].toString().toLowerCase()} captured in its natural habitat.', style: const TextStyle(fontSize: 16, color: Color(0xFF9CA3AF), height: 1.5)),
        const SizedBox(height: 24),
        _quantitySelector(),
      ],
    );
  }

  Widget _quantitySelector() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: const Color(0xFF4B5563), borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.remove, color: Colors.white), onPressed: () => setState(() { if (_quantity > 1) _quantity--; })),
              Container(width: 50, height: 40, color: Colors.white, child: Center(child: Text(_quantity.toString(), style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)))),
              IconButton(icon: const Icon(Icons.add, color: Colors.white), onPressed: () => setState(() { _quantity++; })),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PurchaseScreen())),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9CA3AF), foregroundColor: const Color(0xFF1F2937), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _photographerSection() {
    final photog = widget.product['photographer'];
    Map<String, String> images = {'Aarzoo Khurana':'assets/teammember3.jpg','Mc James':'assets/teammember1.jpg','John Smith':'assets/teammember2.jpg','Thomas Vijayan':'assets/teammember4.jpg'};
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      color: Colors.black,
      child: Column(
        children: [
          const Text('A Word from the Photographer', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          _photographerCard({'name': photog, 'image': images[photog] ?? 'assets/teammember1.jpg', 'quote':'Capturing the essence of wildlife through my lens has been my passion.'}),
        ],
      ),
    );
  }

  Widget _photographerCard(Map<String, String> p) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2), image: DecorationImage(image: AssetImage(p['image']!), fit: BoxFit.cover))),
          const SizedBox(height: 16),
          Text(p['name']!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
          const SizedBox(height: 4),
          const Text('Wildlife Photographer', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
          const SizedBox(height: 16),
          Text(p['quote']!, style: const TextStyle(color: Color(0xFFD1D5DB), fontSize: 16, height: 1.5), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _otherProductsSection(BuildContext context) {
    List<Map<String, dynamic>> products = widget.otherProducts;
    if (products.length < 4) products = [...products, ...products.take(4 - products.length)];
    else products = products.take(4).toList();

    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Other Products', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white)),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.7),
            itemCount: 4,
            itemBuilder: (context, index) => _otherProductCard(products[index]),
          ),
        ],
      ),
    );
  }

  Widget _otherProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF374151), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 140, decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), image: DecorationImage(image: AssetImage(product['image']), fit: BoxFit.cover))),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(product['title'], style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text('By ${product['photographer']}', style: const TextStyle(color: Color(0xFFD1D5DB), fontSize: 12), textAlign: TextAlign.center),
                      const SizedBox(height: 4),
                      Text('Print Size: ${product['size']}', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11), textAlign: TextAlign.center),
                      const SizedBox(height: 6),
                      Text(_formatPrice(product['price']), style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product, otherProducts: widget.otherProducts))),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD1D5DB), foregroundColor: const Color(0xFF1F2937), padding: const EdgeInsets.symmetric(vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                      child: const Text('View Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
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
