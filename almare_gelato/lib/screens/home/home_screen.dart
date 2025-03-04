import 'package:flutter/material.dart';
import '../../widgets/navigation/customer_drawer.dart';
import '../../widgets/common/gradient_app_bar.dart';
import '../../config/theme_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Almare Gelato',
        showDrawerIcon: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          tabs: const [
            Tab(text: 'Berkeley'),
            Tab(text: 'Pleasanton'),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: const [
          BerkeleyLocationTab(),
          PleasantonLocationTab(),
        ],
      ),
    );
  }
}

class BerkeleyLocationTab extends StatelessWidget {
  const BerkeleyLocationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Berkeley Store Image
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/Berkeley.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Berkeley Location',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Address Card
                _buildInfoCard(
                  icon: Icons.location_on,
                  title: 'Address',
                  content: '2170 Shattuck Ave, Berkeley, CA 94704',
                  onTap: () {
                    // Open maps
                  },
                ),
                
                // Hours Card
                _buildInfoCard(
                  icon: Icons.access_time,
                  title: 'Hours',
                  content: 'Monday - Thursday: 12:00 PM - 10:00 PM\n'
                      'Friday - Saturday: 12:00 PM - 11:00 PM\n'
                      'Sunday: 12:00 PM - 9:00 PM',
                ),
                
                // Contact Card
                _buildInfoCard(
                  icon: Icons.phone,
                  title: 'Contact',
                  content: 'Phone: (510) 649-1888\nEmail: info@almaregelato.com',
                  onTap: () {
                    // Make a call
                  },
                ),
                
                // About Card
                _buildInfoCard(
                  icon: Icons.info_outline,
                  title: 'About This Location',
                  content: 'Our original location in the heart of downtown Berkeley. '
                      'We\'ve been serving authentic Italian gelato here since 2008. '
                      'Located just steps from the Downtown Berkeley BART station, '
                      'we\'re a favorite stop for locals and visitors alike.',
                ),
                
                // Special Features Card
                _buildInfoCard(
                  icon: Icons.star,
                  title: 'Special Features',
                  content: '• Outdoor seating available\n'
                      '• Student discounts with valid ID\n'
                      '• Catering services available\n'
                      '• Vegan and dairy-free options',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: ThemeColors.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (onTap != null)
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: ThemeColors.secondaryColor,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PleasantonLocationTab extends StatelessWidget {
  const PleasantonLocationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Pleasanton Store Image
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/pleasanton_store.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pleasanton Location',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Address Card
                _buildInfoCard(
                  icon: Icons.location_on,
                  title: 'Address',
                  content: '234 Main Street, Pleasanton, CA 94566',
                  onTap: () {
                    // Open maps
                  },
                ),
                
                // Hours Card
                _buildInfoCard(
                  icon: Icons.access_time,
                  title: 'Hours',
                  content: 'Monday - Thursday: 11:00 AM - 9:00 PM\n'
                      'Friday - Saturday: 11:00 AM - 10:00 PM\n'
                      'Sunday: 12:00 PM - 8:00 PM',
                ),
                
                // Contact Card
                _buildInfoCard(
                  icon: Icons.phone,
                  title: 'Contact',
                  content: 'Phone: (925) 462-5400\nEmail: pleasanton@almaregelato.com',
                  onTap: () {
                    // Make a call
                  },
                ),
                
                // About Card
                _buildInfoCard(
                  icon: Icons.info_outline,
                  title: 'About This Location',
                  content: 'Our newest location in downtown Pleasanton. '
                      'Opened in 2019, this shop brings our authentic Italian gelato '
                      'to the Tri-Valley area. Enjoy our handcrafted gelato in a '
                      'spacious, family-friendly environment.',
                ),
                
                // Special Features Card
                _buildInfoCard(
                  icon: Icons.star,
                  title: 'Special Features',
                  content: '• Indoor and outdoor seating\n'
                      '• Private event space available\n'
                      '• Gelato cakes and catering\n'
                      '• Free parking behind building\n'
                      '• Coffee and espresso bar',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: ThemeColors.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (onTap != null)
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: ThemeColors.secondaryColor,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}