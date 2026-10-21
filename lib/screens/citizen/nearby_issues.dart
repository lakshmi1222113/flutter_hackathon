import 'package:flutter/material.dart';

class NearbyIssues extends StatefulWidget {
  const NearbyIssues({super.key});

  @override
  State<NearbyIssues> createState() => _NearbyIssuesState();
}

class _NearbyIssuesState extends State<NearbyIssues> {
  final List<Map<String, dynamic>> issues = [
    {
      'title': 'Road Pothole',
      'category': 'Roads',
      'location': 'MVP Colony',
      'distance': '0.8 km',
      'status': 'Pending',
      'supports': 12,
      'supported': false,
    },
    {
      'title': 'Garbage Overflow',
      'category': 'Sanitation',
      'location': 'Dwaraka Nagar',
      'distance': '1.2 km',
      'status': 'In Progress',
      'supports': 8,
      'supported': false,
    },
    {
      'title': 'Street Light Not Working',
      'category': 'Electrical',
      'location': 'Seethammadhara',
      'distance': '1.5 km',
      'status': 'Pending',
      'supports': 5,
      'supported': false,
    },
    {
      'title': 'Water Leakage',
      'category': 'Water',
      'location': 'Madhurawada',
      'distance': '2.1 km',
      'status': 'In Progress',
      'supports': 15,
      'supported': false,
    },
  ];

  void supportIssue(int index) {
    setState(() {
      final issue = issues[index];

      if (issue['supported'] == false) {
        issue['supported'] = true;
        issue['supports'] = issue['supports'] + 1;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'You supported this complaint successfully.',
            ),
          ),
        );
      } else {
        issue['supported'] = false;
        issue['supports'] = issue['supports'] - 1;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Your support was removed.',
            ),
          ),
        );
      }
    });
  }

  Color getStatusColor(String status) {
    if (status == 'Resolved') {
      return Colors.green;
    } else if (status == 'In Progress') {
      return Colors.orange;
    }

    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nearby Issues',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size(double.infinity, 220),
                    painter: MapPainter(),
                  ),

                  const Positioned(
                    top: 92,
                    left: 175,
                    child: Icon(
                      Icons.my_location,
                      size: 36,
                      color: Colors.blue,
                    ),
                  ),

                  const Positioned(
                    top: 45,
                    left: 80,
                    child: Icon(
                      Icons.location_on,
                      size: 34,
                      color: Colors.red,
                    ),
                  ),

                  const Positioned(
                    bottom: 50,
                    right: 80,
                    child: Icon(
                      Icons.location_on,
                      size: 34,
                      color: Colors.orange,
                    ),
                  ),

                  const Positioned(
                    top: 130,
                    right: 120,
                    child: Icon(
                      Icons.location_on,
                      size: 34,
                      color: Colors.red,
                    ),
                  ),

                  Positioned(
                    left: 16,
                    bottom: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.my_location,
                            size: 16,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Your Location',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Reported Near You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Support existing complaints instead of reporting the same issue again.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 16),

            ListView.builder(
              itemCount: issues.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final issue = issues[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.report_problem_outlined,
                              color: Colors.blue,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  issue['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  issue['category'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: getStatusColor(
                                issue['status'],
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              issue['status'],
                              style: TextStyle(
                                color: getStatusColor(
                                  issue['status'],
                                ),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            issue['location'],
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.near_me_outlined,
                            size: 17,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            issue['distance'],
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      const Divider(),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 20,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${issue['supports']} people supported',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),

                          const Spacer(),

                          OutlinedButton.icon(
                            onPressed: () => supportIssue(index),
                            icon: Icon(
                              issue['supported']
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_outlined,
                              size: 18,
                            ),
                            label: Text(
                              issue['supported']
                                  ? 'Supported'
                                  : 'Support',
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  issue['supported']
                                      ? Colors.green
                                      : Colors.blue,
                              side: BorderSide(
                                color: issue['supported']
                                    ? Colors.green
                                    : Colors.blue,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.55),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.25, 0),
      Offset(size.width * 0.55, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.75, 0),
      Offset(size.width * 0.45, size.height),
      paint,
    );

    final roadPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 8;

    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.2),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}