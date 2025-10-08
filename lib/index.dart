import 'package:flutter/material.dart';
import 'login.dart';
import 'cart.dart';
import 'aboutus.dart';
import 'purchase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  Widget _logo({double size = 40}) => Image.asset(
        'assets/logo.png',
        width: size,
        height: size,
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(size / 2)),
          child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: GestureDetector(onTap: () => Navigator.pop(context), child: _logo()),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () => _navigateTo(const CartScreen())),
          IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () => _navigateTo(const LoginScreen())),
        ],
      ),

      // Drawer with hamburger menu
      drawer: Tooltip(
        message: '', 
        child: Drawer(
          backgroundColor: const Color(0xFF212121),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF121212)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _logo(size: 60),
                    const SizedBox(height: 10),
                    const Text('Wild TRACE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              _drawerItem(Icons.home, 'HOME', () => Navigator.pop(context)),
              _drawerItem(Icons.landscape, 'JOURNEY',
                  () => _navigateTo(const AboutUsScreen())),
              _drawerItem(Icons.shopping_bag, 'PURCHASE',
                  () => _navigateTo(const PurchaseScreen())),
              const Divider(color: Color(0xFF4b4b4b)),
              _drawerItem(Icons.shopping_cart, 'CART',
                  () => _navigateTo(const CartScreen())),
              _drawerItem(Icons.login, 'LOGIN',
                  () => _navigateTo(const LoginScreen())),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            _heroSection(),
            _testimonialsSection(),
            _newsletterSection(),
          ],
        ),
      ),
    );
  }

  // Drawer item widget
  ListTile _drawerItem(IconData icon, String title, VoidCallback onTap) =>
      ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(title, style: const TextStyle(color: Colors.white)),
          onTap: onTap);

  // Hero section with fade animation
  Widget _heroSection() => FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/heroimagehome.jpg'), fit: BoxFit.cover),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.4),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Welcome to',
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: Colors.white)),
                    const SizedBox(height: 20),
                    _logo(size: 128),
                    const SizedBox(height: 20),
                    const Text('Freeze the Wild, Forever.',
                        style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFFE5E5E5))),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        "Bringing the wild to your walls — each photograph tells nature's story.",
                        style: TextStyle(fontSize: 16, color: Color(0xFFE5E5E5)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  // Testimonials section with slide animation
  Widget _testimonialsSection() {
    final testimonials = [
      {
        'image': 'assets/testimonial1.jpg',
        'name': 'Naveen Perera',
        'quote': 'Absolutely breathtaking photos! Every image feels alive.'
      },
      {
        'image': 'assets/testimonial2.jpg',
        'name': 'Shehan Sinhabahu',
        'quote': 'A true celebration of wildlife. The details are incredible.'
      },
      {
        'image': 'assets/testimonial3.jpg',
        'name': 'Malki Perera',
        'quote': "Feels like I'm in the wild every time I visit the site."
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      color: const Color(0xFF1F2937),
      child: Column(
        children: [
          const Text('What Our Visitors Say',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (_, constraints) {
              final isWide = constraints.maxWidth > 600;
              final list = testimonials
                  .map((t) => Padding(
                        padding: EdgeInsets.only(bottom: isWide ? 0 : 16),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 600),
                          builder: (_, value, child) => Opacity(
                            opacity: value,
                            child: Transform.translate(
                                offset: Offset(0, 50 * (1 - value)), child: child),
                          ),
                          child: _testimonialCard(t),
                        ),
                      ))
                  .toList();
              return isWide
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: list)
                  : Column(children: list);
            },
          ),
        ],
      ),
    );
  }

  // Individual testimonial card
  Widget _testimonialCard(Map<String, String> t) => Container(
        width: 280,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF374151),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
                radius: 48,
                backgroundColor: const Color(0xFF4B5563),
                backgroundImage: AssetImage(t['image']!)),
            const SizedBox(height: 16),
            Text(t['quote']!,
                style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    fontSize: 14),
                textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text('— ${t['name']}',
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.white)),
          ],
        ),
      );

  // Newsletter section
  Widget _newsletterSection() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
        color: const Color(0xFF121212),
        child: Column(
          children: [
            const Text('Subscribe to Our Newsletter',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 16),
            const Text('Get the latest updates and offers directly to your inbox.',
                style: TextStyle(color: Color(0xFFE5E5E5), fontSize: 16),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Enter your email',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Newsletter subscription coming soon!'))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                      child: const Text('Subscribe',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
