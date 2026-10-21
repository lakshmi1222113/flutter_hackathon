import 'package:flutter/material.dart';
import 'admin_complaints.dart';
import 'admin_users.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    AdminHomeContent(),
    AdminComplaints(),
    AdminUsers(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff2196F3),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xffFDF8FF),

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            activeIcon: Icon(Icons.assignment),
            label: 'Complaints',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Users',
          ),
        ],
      ),
    );
  }
}

// =====================================================
// ADMIN HOME / DASHBOARD
// =====================================================

class AdminHomeContent extends StatelessWidget {
  const AdminHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // HEADER
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'CityPulse',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff222222),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Administration Dashboard',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // OVERVIEW
            const Text(
              'CityPulse Overview',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Current status of reported urban problems',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 18),

            // STAT CARDS
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    title: 'Total',
                    value: '120',
                    icon: Icons.assignment,
                    iconColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    title: 'Pending',
                    value: '32',
                    icon: Icons.pending_actions,
                    iconColor: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _statCard(
                    title: 'In Progress',
                    value: '41',
                    icon: Icons.autorenew,
                    iconColor: Colors.indigo,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                    title: 'Resolved',
                    value: '47',
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // STATUS OVERVIEW
            const Text(
              'Complaint Status',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _statusRow(
                    'Pending',
                    32,
                    120,
                    Colors.orange,
                  ),
                  const SizedBox(height: 18),
                  _statusRow(
                    'In Progress',
                    41,
                    120,
                    Colors.blue,
                  ),
                  const SizedBox(height: 18),
                  _statusRow(
                    'Resolved',
                    47,
                    120,
                    Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // DEPARTMENT OVERVIEW
            const Text(
              'Complaints by Department',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _departmentRow(
                    'Roads',
                    35,
                    Icons.directions_car,
                  ),
                  const Divider(height: 25),

                  _departmentRow(
                    'Sanitation',
                    31,
                    Icons.delete_outline,
                  ),
                  const Divider(height: 25),

                  _departmentRow(
                    'Electrical',
                    28,
                    Icons.lightbulb_outline,
                  ),
                  const Divider(height: 25),

                  _departmentRow(
                    'Water',
                    26,
                    Icons.water_drop_outlined,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // RECENT COMPLAINTS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Complaints',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            _recentComplaint(
              'Street Light Not Working',
              'MVP Colony',
              'Pending',
              Colors.orange,
            ),

            _recentComplaint(
              'Garbage Overflow',
              'Dwaraka Nagar',
              'In Progress',
              Colors.blue,
            ),

            _recentComplaint(
              'Road Pothole',
              'Gajuwaka',
              'Resolved',
              Colors.green,
            ),

            _recentComplaint(
              'Water Leakage',
              'Madhurawada',
              'Pending',
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  // ===================================================
  // STAT CARD
  // ===================================================

  static Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            value,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ===================================================
  // STATUS ROW
  // ===================================================

  static Widget _statusRow(
    String title,
    int count,
    int total,
    Color color,
  ) {
    final double percentage = count / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$count complaints',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percentage,
            minHeight: 9,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  // ===================================================
  // DEPARTMENT ROW
  // ===================================================

  static Widget _departmentRow(
    String department,
    int count,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffEEF6FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: const Color(0xff2196F3),
            size: 22,
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Text(
            department,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        Text(
          '$count',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(width: 5),

        const Text(
          'complaints',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // ===================================================
  // RECENT COMPLAINT
  // ===================================================

  static Widget _recentComplaint(
    String title,
    String location,
    String status,
    Color statusColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xffEEF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.report_problem_outlined,
              color: Colors.blue,
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '📍 $location',
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
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}