import 'package:flutter/material.dart';

class CitizenNotifications extends StatelessWidget {
  const CitizenNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Complaint Assigned',
        'message':
            'Your Street Light complaint has been assigned to the Electrical Department.',
        'time': '10 minutes ago',
        'icon': Icons.assignment_turned_in_outlined,
        'color': Colors.blue,
      },
      {
        'title': 'Complaint In Progress',
        'message':
            'Your Street Light complaint is currently being worked on.',
        'time': '2 hours ago',
        'icon': Icons.engineering_outlined,
        'color': Colors.orange,
      },
      {
        'title': 'Complaint Resolved',
        'message':
            'Your Road Pothole complaint has been successfully resolved.',
        'time': 'Yesterday',
        'icon': Icons.check_circle_outline,
        'color': Colors.green,
      },
      {
        'title': 'Nearby Issue',
        'message':
            'A new garbage complaint was reported near your area.',
        'time': 'Yesterday',
        'icon': Icons.location_on_outlined,
        'color': Colors.red,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: (notification['color'] as Color)
                        .withOpacity(0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    notification['icon'] as IconData,
                    color: notification['color'] as Color,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification['title'] as String,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        notification['message'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        notification['time'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}