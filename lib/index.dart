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

class _HomeScreenState extends State<HomeScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            _buildHeroSection(),

            // Testimonials Section
            _buildTestimonialsSection(),

            // Newsletter Section
            _buildNewsletterSection(),
          ],
        ),
      ),
    );
  }

  void _navigateToHome() {
    // Already on home, just pop drawer if open
    Navigator.pop(context);
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

  Widget _buildHeroSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/heroimagehome.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.4), // Dark overlay
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/logo.png',
                  width: 128,
                  height: 128,
                  errorBuilder: (context, error, stackTrace) => _buildPlaceholderLogo(),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Freeze the Wild, Forever.',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFE5E5E5),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'Bringing the wild to your walls — each photograph tells a nature\'s untamed story.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFE5E5E5),
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

  Widget _buildTestimonialsSection() {
    final testimonials = [
      {
        'image': 'assets/testimonial1.jpg',
        'name': 'Naveen Perera',
        'quote': 'Absolutely breathtaking photos! Every image feels alive.',
      },
      {
        'image': 'assets/testimonial2.jpg',
        'name': 'Shehan Sinhabahu',
        'quote': 'A true celebration of wildlife. The details are incredible.',
      },
      {
        'image': 'assets/testimonial3.jpg',
        'name': 'Malki Perera',
        'quote': 'I feel like I\'m right there in the wild every time I visit the site.',
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      color: const Color(0xFF1F2937), // Gray-900 equivalent
      child: Column(
        children: [
          const Text(
            'What Our Visitors Say',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Desktop layout
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: testimonials.map((testimonial) => 
                    _buildTestimonialCard(testimonial)
                  ).toList(),
                );
              } else {
                // Mobile layout
                return Column(
                  children: testimonials.map((testimonial) => 
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildTestimonialCard(testimonial),
                    )
                  ).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF374151), // Gray-800 equivalent
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: const Color(0xFF4B5563),
            backgroundImage: AssetImage(testimonial['image']!),
            child: testimonial['image']!.isEmpty 
                ? const Icon(Icons.person, size: 40, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            testimonial['quote']!,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '— ${testimonial['name']!}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsletterSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      color: const Color(0xFF121212), // Much darker gray (almost black)
      child: Column(
        children: [
          const Text(
            'Subscribe to Our Newsletter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Get the latest updates and offers directly to your inbox.',
            style: TextStyle(
              color: Color(0xFFE5E5E5),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48, // Reduced height
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your email',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          borderSide: BorderSide(color: Color(0xFFD1D5DB)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48, // Same height as input field
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement newsletter subscription
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Newsletter subscription coming soon!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Orange color
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text(
                      'Subscribe',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
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
}