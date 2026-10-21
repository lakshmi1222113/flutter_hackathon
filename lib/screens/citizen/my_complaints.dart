import 'package:flutter/material.dart';

import '../../data/complaint_store.dart';
import 'complaint_details.dart';

class MyComplaints extends StatefulWidget {
  const MyComplaints({super.key});

  @override
  State<MyComplaints> createState() => _MyComplaintsState();
}

class _MyComplaintsState extends State<MyComplaints> {
  @override
  void initState() {
    super.initState();
    ComplaintStore.instance.addListener(_refresh);
  }

  @override
  void dispose() {
    ComplaintStore.instance.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Complaint> get complaints {
    return ComplaintStore.instance.complaints;
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Assigned':
        return Colors.indigo;

      case 'In Progress':
        return Colors.blue;

      case 'Resolved':
        return Colors.green;

      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final allComplaints = complaints;

    final pendingCount = allComplaints
        .where((c) => c.status == 'Pending')
        .length;

    final inProgressCount = allComplaints
        .where((c) => c.status == 'In Progress')
        .length;

    final resolvedCount = allComplaints
        .where((c) => c.status == 'Resolved')
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'My Complaints',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Column(
        children: [

          // ===================================================
          // SUMMARY
          // ===================================================

          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: _summaryCard(
                    'Total',
                    allComplaints.length.toString(),
                    Colors.blue,
                    Icons.assignment_outlined,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _summaryCard(
                    'Pending',
                    pendingCount.toString(),
                    Colors.orange,
                    Icons.pending_actions,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _summaryCard(
                    'Progress',
                    inProgressCount.toString(),
                    Colors.indigo,
                    Icons.autorenew,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _summaryCard(
                    'Resolved',
                    resolvedCount.toString(),
                    Colors.green,
                    Icons.check_circle_outline,
                  ),
                ),
              ],
            ),
          ),

          // ===================================================
          // COMPLAINT LIST
          // ===================================================

          Expanded(
            child: allComplaints.isEmpty
                ? _emptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: allComplaints.length,
                    itemBuilder: (context, index) {
                      return _complaintCard(
                        allComplaints[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SUMMARY CARD
  // =========================================================

  Widget _summaryCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 21,
          ),

          const SizedBox(height: 6),

          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // COMPLAINT CARD
  // =========================================================

  Widget _complaintCard(Complaint complaint) {
    return GestureDetector(
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

      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // TITLE + STATUS
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    complaint.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(
                      complaint.status,
                    ).withOpacity(0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    complaint.status,
                    style: TextStyle(
                      color: _statusColor(
                        complaint.status,
                      ),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // CATEGORY
            Row(
              children: [
                const Icon(
                  Icons.category_outlined,
                  size: 17,
                  color: Colors.grey,
                ),

                const SizedBox(width: 7),

                Text(
                  complaint.category,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 7),

            // LOCATION
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 17,
                  color: Colors.grey,
                ),

                const SizedBox(width: 7),

                Expanded(
                  child: Text(
                    complaint.location,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // DESCRIPTION
            Text(
              complaint.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            // ASSIGNED OFFICER
            if (complaint.officer != null)
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 17,
                    color: Colors.blue,
                  ),

                  const SizedBox(width: 7),

                  Text(
                    'Assigned to ${complaint.officer}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 12),

            // PRIORITY
            Row(
              children: [
                const Icon(
                  Icons.flag_outlined,
                  size: 17,
                ),

                const SizedBox(width: 6),

                Text(
                  'Priority: ${complaint.priority}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY STATE
  // =========================================================

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 70,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 15),

            const Text(
              'No Complaints Yet',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Your submitted complaints will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}