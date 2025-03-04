import '../models/announcement.dart';

class AnnouncementRepository {
  static final List<Announcement> berkeleyAnnouncements = [
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

  static final List<Announcement> pleasantonAnnouncements = [
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
} 