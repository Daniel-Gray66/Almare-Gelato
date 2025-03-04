import 'package:flutter/material.dart';
import 'package:almare_gelato/themes/themes_colors.dart';
import '../widgets/customer_drawer.dart';

class Announcement {
  final String title;
  final String description;
  final DateTime date;
  final String? imageUrl;
  final AnnouncementType type;
  final String location;

  Announcement({
    required this.title,
    required this.description,
    required this.date,
    this.imageUrl,
    required this.type,
    required this.location,
  });
}

enum AnnouncementType {
  newFlavor,
  event,
  hours,
  general
}

class AnnouncementsScreen extends StatelessWidget {
  // Sample announcements with location
  final List<Announcement> berkeleyAnnouncements = [
    Announcement(
      title: "Berkeley Special: Student Discount!",
      description: "Show your student ID for 10% off your purchase.",
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: AnnouncementType.general,
      location: "Berkeley",
    ),
    Announcement(
      title: "New Flavor: Matcha Green Tea",
      description: "Berkeley exclusive! Try our new Matcha flavor made with premium Japanese green tea.",
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: AnnouncementType.newFlavor,
      location: "Berkeley",
    ),
  ];

  final List<Announcement> pleasantonAnnouncements = [
    Announcement(
      title: "Pleasanton Downtown Event",
      description: "Join us this weekend for the downtown festival! Special flavors available.",
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: AnnouncementType.event,
      location: "Pleasanton",
    ),
    Announcement(
      title: "Updated Hours",
      description: "Starting next week, we'll be open from 11am on weekdays!",
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: AnnouncementType.hours,
      location: "Pleasanton",
    ),
  ];

  AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: const Text(
            'Announcements',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: ThemeColors.primaryColor,
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Pleasanton'),
              Tab(text: 'Berkeley'),
            ],
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicator: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
        drawer: const CustomDrawer(),
        backgroundColor: ThemeColors.backgroundColor,
        body: TabBarView(
          children: [
            _buildAnnouncementsList(pleasantonAnnouncements),
            _buildAnnouncementsList(berkeleyAnnouncements),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementsList(List<Announcement> announcements) {
    if (announcements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off,
              size: 64,
              color: ThemeColors.subtitleTextColor,
            ),
            const SizedBox(height: 16),
            Text(
              'No announcements yet',
              style: TextStyle(
                fontSize: 18,
                color: ThemeColors.subtitleTextColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        return _buildAnnouncementCard(announcements[index]);
      },
    );
  }

  Widget _buildAnnouncementCard(Announcement announcement) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: ThemeColors.dividerColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: _getAnnouncementColor(announcement.type).withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getAnnouncementIcon(announcement.type),
                    color: _getAnnouncementColor(announcement.type),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _getAnnouncementTypeText(announcement.type),
                    style: TextStyle(
                      color: _getAnnouncementColor(announcement.type),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (announcement.imageUrl != null)
              Image.asset(
                announcement.imageUrl!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    announcement.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeColors.textColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _formatDate(announcement.date),
                    style: TextStyle(
                      fontSize: 14,
                      color: ThemeColors.subtitleTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAnnouncementColor(AnnouncementType type) {
    switch (type) {
      case AnnouncementType.newFlavor:
        return Colors.purple;
      case AnnouncementType.event:
        return Colors.green;
      case AnnouncementType.hours:
        return Colors.blue;
      case AnnouncementType.general:
        return Colors.orange;
    }
  }

  IconData _getAnnouncementIcon(AnnouncementType type) {
    switch (type) {
      case AnnouncementType.newFlavor:
        return Icons.icecream;
      case AnnouncementType.event:
        return Icons.event;
      case AnnouncementType.hours:
        return Icons.access_time;
      case AnnouncementType.general:
        return Icons.announcement;
    }
  }

  String _getAnnouncementTypeText(AnnouncementType type) {
    switch (type) {
      case AnnouncementType.newFlavor:
        return 'New Flavor';
      case AnnouncementType.event:
        return 'Event';
      case AnnouncementType.hours:
        return 'Hours Update';
      case AnnouncementType.general:
        return 'Announcement';
    }
  }

  String _formatDate(DateTime date) {
    // Simple date formatting - you can make this more sophisticated
    return '${date.month}/${date.day}/${date.year}';
  }
} 