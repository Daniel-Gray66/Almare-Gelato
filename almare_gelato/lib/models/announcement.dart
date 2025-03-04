import 'package:flutter/material.dart';

enum AnnouncementType {
  newFlavor,
  event,
  hours,
  general
}

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

  Color getTypeColor() {
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

  IconData getTypeIcon() {
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

  static String getTypeText(AnnouncementType type) {
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
}