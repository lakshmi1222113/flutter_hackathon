import 'package:flutter/material.dart';
import 'complaint_details.dart';

class AssignedComplaints extends StatefulWidget {
  const AssignedComplaints({super.key});

  @override
  State<AssignedComplaints> createState() => _AssignedComplaintsState();
}

class _AssignedComplaintsState extends State<AssignedComplaints> {
  String selectedFilter = 'All';

  final List<Map<String, String>> complaints = [
    {
      'id': 'CP1024',
      'title': 'Large Pothole',
      'category': 'Road',
      'location': 'Beach Road',
      'priority': 'High',
      'status': 'Pending',
    },
    {
      'id': 'CP1025',
      'title': 'Water Leakage',
      'category': 'Water',
      'location': 'MVP Colony',
      'priority': 'High',
      'status': 'In Progress',
    },
    {
      'id': 'CP1026',
      'title': 'Streetlight Issue',
      'category': 'Electrical',
      'location': 'Seethammadhara',
      'priority': 'Low',
      'status': 'Pending',
    },
    {
      'id': 'CP1027',
      'title': 'Garbage Overflow',
      'category': 'Sanitation',
      'location': 'Dwaraka Nagar',
      'priority': 'Medium',
      'status': 'Resolved',
    },
    {
      'id': 'CP1028',
      'title': 'Road Damage',
      'category': 'Road',
      'location': 'Gajuwaka',
      'priority': 'Medium',
      'status': 'In Progress',
    },
  ];

  List<Map<String, String>> get filteredComplaints {
    if (selectedFilter == 'All') {
      return complaints;
    }

    return complaints
        .where((complaint) => complaint['status'] == selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F9FC),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Assigned Complaints',
          style: TextStyle(
            color: Color(0xFF111827),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF111827),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 360 ? 16 : 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Manage your assigned complaints',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),

            const SizedBox(height: 22),

            // Filter buttons
            SizedBox(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _FilterButton(
                    title: 'All',
                    selected: selectedFilter == 'All',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'All';
                      });
                    },
                  ),
                  _FilterButton(
                    title: 'Pending',
                    selected: selectedFilter == 'Pending',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'Pending';
                      });
                    },
                  ),
                  _FilterButton(
                    title: 'In Progress',
                    selected: selectedFilter == 'In Progress',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'In Progress';
                      });
                    },
                  ),
                  _FilterButton(
                    title: 'Resolved',
                    selected: selectedFilter == 'Resolved',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'Resolved';
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Complaint count
            Text(
              '${filteredComplaints.length} Complaints',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF111827),
              ),
            ),

            const SizedBox(height: 12),

            // Complaint list
            if (filteredComplaints.isEmpty)
              _EmptyState()
            else
              ...filteredComplaints.map(
                (complaint) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _ComplaintCard(
                    complaint: complaint,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComplaintDetails(
                            complaint: complaint,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// FILTER BUTTON
// ---------------------------------------------------------

class _FilterButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFF2563EB)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? const Color(0xFF2563EB)
                  : const Color(0xFFE5E7EB),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected
                  ? Colors.white
                  : const Color(0xFF4B5563),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// COMPLAINT CARD
// ---------------------------------------------------------

class _ComplaintCard extends StatelessWidget {
  final Map<String, String> complaint;
  final VoidCallback onTap;

  const _ComplaintCard({
    required this.complaint,
    required this.onTap,
  });

  IconData _getIcon(String category) {
    switch (category) {
      case 'Road':
        return Icons.construction_outlined;
      case 'Water':
        return Icons.water_drop_outlined;
      case 'Electrical':
        return Icons.lightbulb_outline;
      case 'Sanitation':
        return Icons.delete_outline;
      default:
        return Icons.report_problem_outlined;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color(0xFFDC2626);
      case 'Medium':
        return const Color(0xFFEA580C);
      default:
        return const Color(0xFF16A34A);
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Resolved':
        return const Color(0xFF16A34A);
      case 'In Progress':
        return const Color(0xFF2563EB);
      default:
        return const Color(0xFFEA580C);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    _getIcon(complaint['category']!),
                    color: const Color(0xFF2563EB),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        complaint['title']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '#${complaint['id']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF9CA3AF),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 17,
                  color: Color(0xFF6B7280),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    complaint['location']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                _Badge(
                  text: '${complaint['priority']} Priority',
                  color: _getPriorityColor(
                    complaint['priority']!,
                  ),
                ),
                const SizedBox(width: 8),
                _Badge(
                  text: complaint['status']!,
                  color: _getStatusColor(
                    complaint['status']!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// BADGE
// ---------------------------------------------------------

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// EMPTY STATE
// ---------------------------------------------------------

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 20,
      ),
      child: const Column(
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 55,
            color: Color(0xFF9CA3AF),
          ),
          SizedBox(height: 14),
          Text(
            'No complaints found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF374151),
            ),
          ),
          SizedBox(height: 6),
          Text(
            'There are no complaints in this category.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}