import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../models/announcement_category.dart';

const List<AnnouncementCategory> dummyCategories = [
  AnnouncementCategory(id: 'general', name: 'General', icon: Icons.campaign_outlined),
  AnnouncementCategory(id: 'exams', name: 'Exams', icon: Icons.edit_note_outlined),
  AnnouncementCategory(id: 'events', name: 'Events', icon: Icons.event_outlined),
  AnnouncementCategory(id: 'sports', name: 'Sports', icon: Icons.sports_soccer_outlined),
  AnnouncementCategory(id: 'holidays', name: 'Holidays', icon: Icons.beach_access_outlined),
  AnnouncementCategory(id: 'clubs', name: 'Clubs', icon: Icons.groups_outlined),
];

final List<Announcement> dummyAnnouncements = [
  Announcement(
    id: 'a1',
    title: 'Final exam schedule released',
    body:
        'The final examination schedule for all year levels is now posted. '
        'Exams begin on December 8 and end on December 12. Please check your '
        'room assignments with your class adviser and bring a valid school ID.',
    categoryId: 'exams',
    author: 'Registrar\'s Office',
    date: DateTime(2026, 11, 17),
    isUrgent: true,
  ),
  Announcement(
    id: 'a2',
    title: 'Class suspension on November 20',
    body:
        'Classes will be suspended on Friday, November 20 due to the faculty '
        'development day. Regular classes resume on Monday.',
    categoryId: 'holidays',
    author: 'Principal\'s Office',
    date: DateTime(2026, 11, 16),
    isUrgent: true,
  ),
  Announcement(
    id: 'a3',
    title: 'Intramurals opening ceremony',
    body:
        'The annual intramurals will open on December 1 at the main gym. '
        'All students are expected to wear their house color shirt.',
    categoryId: 'sports',
    author: 'PE Department',
    date: DateTime(2026, 11, 15),
  ),
  Announcement(
    id: 'a4',
    title: 'Science fair registration open',
    body:
        'Register your project with your science teacher before November 25. '
        'Groups of up to three students are allowed.',
    categoryId: 'events',
    author: 'Science Department',
    date: DateTime(2026, 11, 14),
  ),
  Announcement(
    id: 'a5',
    title: 'Library hours extended',
    body:
        'During exam week the library will stay open until 7:00 PM. '
        'Quiet study rooms can be reserved at the front desk.',
    categoryId: 'general',
    author: 'Library',
    date: DateTime(2026, 11, 13),
  ),
  Announcement(
    id: 'a6',
    title: 'Robotics Club recruitment',
    body:
        'The Robotics Club is looking for new members. No experience needed. '
        'Meetings are every Thursday at 4:00 PM in Room 204.',
    categoryId: 'clubs',
    author: 'Robotics Club',
    date: DateTime(2026, 11, 12),
  ),
  Announcement(
    id: 'a7',
    title: 'Uniform reminder',
    body:
        'Students must wear the complete uniform from Monday to Thursday. '
        'Wash day uniform is allowed on Fridays.',
    categoryId: 'general',
    author: 'Discipline Office',
    date: DateTime(2026, 11, 10),
  ),
  Announcement(
    id: 'a8',
    title: 'Basketball tryouts',
    body:
        'Varsity basketball tryouts will be held on November 23 at 3:30 PM '
        'in the gym. Bring your medical clearance.',
    categoryId: 'sports',
    author: 'PE Department',
    date: DateTime(2026, 11, 9),
  ),
  Announcement(
    id: 'a9',
    title: 'Enrollment for next term opens',
    body:
        'Online enrollment for the next term opens on December 15. '
        'Settle your clearance at the Registrar before enrolling.',
    categoryId: 'general',
    author: 'Registrar\'s Office',
    date: DateTime(2026, 11, 8),
  ),
  Announcement(
    id: 'a10',
    title: 'Christmas break schedule',
    body:
        'Classes end on December 18 and resume on January 4. '
        'Offices will have limited hours during the break.',
    categoryId: 'holidays',
    author: 'Principal\'s Office',
    date: DateTime(2026, 11, 7),
  ),
  Announcement(
    id: 'a11',
    title: 'Coding Club hackathon',
    body:
        'Join the one-day campus hackathon on December 5. Teams of up to '
        'four students. Register with the Coding Club officers by December 1.',
    categoryId: 'clubs',
    author: 'Coding Club',
    date: DateTime(2026, 11, 6),
  ),
  Announcement(
    id: 'a12',
    title: 'Midterm grade release',
    body:
        'Midterm grades are now available. Report any concerns to your '
        'subject teacher within one week of release.',
    categoryId: 'exams',
    author: 'Registrar\'s Office',
    date: DateTime(2026, 11, 5),
  ),
];
