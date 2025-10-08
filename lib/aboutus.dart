import 'package:flutter/material.dart';
import 'index.dart';
import 'login.dart';
import 'cart.dart';
import 'purchase.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> with SingleTickerProviderStateMixin {
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

  void _navigateToHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),

      // Drawer with hamburger menu
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            }),
            _buildDrawerItem(Icons.landscape, 'JOURNEY', () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(Icons.shopping_bag, 'PURCHASE', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PurchaseScreen()));
            }),
            const Divider(color: Color(0xFF4b4b4b)),
            _buildDrawerItem(Icons.shopping_cart, 'CART', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            }),
            _buildDrawerItem(Icons.login, 'LOGIN', () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            }),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildPhotographersSection(),
            _buildTimelineSection(),
          ],
        ),
      ),
    );
  }

  // Drawer item widget
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  // Hero section with fade animation
  Widget _buildHeroSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/heroimageaboutus.jpg'),
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
                children: const [
                  Text(
                    'Our Journey Into the Wild',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      '"Bringing the wild to your walls, each shot tells nature\'s untamed story."',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
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
      ),
    );
  }

  // Photographers section with fade animation
  Widget _buildPhotographersSection() {
    final photographers = [
      {
        'image': 'assets/teammember1.jpg',
        'name': 'Mc James',
        'quote': 'Wildlife photographer capturing intimate moments of big cats.',
      },
      {
        'image': 'assets/teammember2.jpg',
        'name': 'John Smith',
        'quote': 'Award-winning bird photographer focusing on endangered species.',
      },
      {
        'image': 'assets/teammember3.jpg',
        'name': 'Aarzoo Khurana',
        'quote': 'Underwater photography expert documenting marine life.',
      },
      {
        'image': 'assets/teammember4.jpg',
        'name': 'Thomas Vijayan',
        'quote': 'Photographer telling stories of human-animal coexistence.',
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      color: Colors.black,
      child: Column(
        children: [
          const Text(
            'Meet the Photographers',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 48),
          Column(
            children: photographers.asMap().entries.map((entry) {
              final index = entry.key;
              final p = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 500 + index * 100),
                  builder: (_, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(offset: Offset(0, 50 * (1 - value)), child: child),
                  ),
                  child: _buildPhotographerCard(p),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Individual photographer card
  Widget _buildPhotographerCard(Map<String, String> p) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 600),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF212121).withOpacity(0.8),
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
            backgroundColor: const Color(0xFF9CA3AF),
            backgroundImage: AssetImage(p['image']!),
            child: p['image']!.isEmpty
                ? const Icon(Icons.person, size: 30, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            p['name']!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Wildlife Photographer',
            style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
          ),
          const SizedBox(height: 12),
          Text(
            p['quote']!,
            style: const TextStyle(fontSize: 14, color: Color(0xFFD1D5DB)),
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Timeline section
  Widget _buildTimelineSection() {
    final milestones = [
      {'year': '2018 — The Beginning', 'description': 'Born from a passion for wildlife.'},
      {'year': '2019 — First Collection Launch', 'description': 'Released our debut gallery.'},
      {'year': '2021 — Global Connections', 'description': 'Partnered with photographers worldwide.'},
      {'year': '2023 — Online Store Opens', 'description': 'Started selling exclusive prints.'},
      {'year': '2025 — Conservation & Community', 'description': 'Supporting wildlife preservation.'},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 16),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/bgimage.jpg'),
          fit: BoxFit.cover,
        ),
        color: Colors.black.withOpacity(0.4),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: const Color(0xFF121212).withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Text(
              'Our Journey: Key Milestones',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Column(
              children: milestones.asMap().entries.map((entry) {
                final index = entry.key;
                final m = entry.value;
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 500 + index * 100),
                  builder: (_, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(offset: Offset(0, 50 * (1 - value)), child: child),
                  ),
                  child: _buildTimelineItem(m['year']!, m['description']!, index == milestones.length - 1),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Individual timeline item
  Widget _buildTimelineItem(String year, String description, bool isLast) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 16,
            height: 16,
            margin: const EdgeInsets.only(top: 4, right: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF9CA3AF),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  year,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                if (!isLast) const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
