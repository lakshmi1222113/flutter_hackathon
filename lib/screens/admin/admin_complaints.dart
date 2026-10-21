import 'package:flutter/material.dart';

import '../../data/complaint_store.dart';

class AdminComplaints extends StatefulWidget {
  const AdminComplaints({super.key});

  @override
  State<AdminComplaints> createState() => _AdminComplaintsState();
}

class _AdminComplaintsState extends State<AdminComplaints> {
  String selectedFilter = 'All';

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

  List<Complaint> get filteredComplaints {
    final complaints = ComplaintStore.instance.complaints;

    if (selectedFilter == 'All') {
      return complaints;
    }

    return complaints
        .where(
          (complaint) => complaint.status == selectedFilter,
        )
        .toList();
  }

  // =========================================================
  // ASSIGN COMPLAINT
  // =========================================================

  void _showAssignDialog(Complaint complaint) {
    String selectedDepartment =
        complaint.department ?? 'Roads Department';

    String selectedOfficer =
        complaint.officer ?? 'Officer Ravi';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Assign Complaint',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    complaint.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    value: selectedDepartment,
                    decoration: const InputDecoration(
                      labelText: 'Department',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Roads Department',
                        child: Text('Roads Department'),
                      ),
                      DropdownMenuItem(
                        value: 'Electrical Department',
                        child: Text('Electrical Department'),
                      ),
                      DropdownMenuItem(
                        value: 'Sanitation Department',
                        child: Text('Sanitation Department'),
                      ),
                      DropdownMenuItem(
                        value: 'Water Department',
                        child: Text('Water Department'),
                      ),
                      DropdownMenuItem(
                        value: 'Traffic Department',
                        child: Text('Traffic Department'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() {
                          selectedDepartment = value;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 15),

                  DropdownButtonFormField<String>(
                    value: selectedOfficer,
                    decoration: const InputDecoration(
                      labelText: 'Officer',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Officer Ravi',
                        child: Text('Officer Ravi'),
                      ),
                      DropdownMenuItem(
                        value: 'Officer Suresh',
                        child: Text('Officer Suresh'),
                      ),
                      DropdownMenuItem(
                        value: 'Officer Priya',
                        child: Text('Officer Priya'),
                      ),
                      DropdownMenuItem(
                        value: 'Officer Anjali',
                        child: Text('Officer Anjali'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() {
                          selectedOfficer = value;
                        });
                      }
                    },
                  ),
                ],
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: () {
                    ComplaintStore.instance.assignComplaint(
                      complaintId: complaint.id,
                      department: selectedDepartment,
                      officer: selectedOfficer,
                    );

                    Navigator.pop(context);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Complaint assigned successfully',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text('Assign'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // =========================================================
  // PRIORITY
  // =========================================================

  void _showPriorityDialog(Complaint complaint) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Priority'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _priorityOption(
                complaint,
                'High',
                Colors.red,
              ),
              _priorityOption(
                complaint,
                'Medium',
                Colors.orange,
              ),
              _priorityOption(
                complaint,
                'Low',
                Colors.green,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _priorityOption(
    Complaint complaint,
    String priority,
    Color color,
  ) {
    return ListTile(
      leading: Icon(
        Icons.flag,
        color: color,
      ),
      title: Text(priority),
      trailing: complaint.priority == priority
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : null,
      onTap: () {
        ComplaintStore.instance.updatePriority(
          complaintId: complaint.id,
          priority: priority,
        );

        Navigator.pop(context);
      },
    );
  }

  // =========================================================
  // STATUS COLOR
  // =========================================================

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

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final complaints = filteredComplaints;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Complaints',
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
          // =====================================================
          // FILTERS
          // =====================================================

          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _filterButton('All'),
                  _filterButton('Pending'),
                  _filterButton('Assigned'),
                  _filterButton('In Progress'),
                  _filterButton('Resolved'),
                ],
              ),
            ),
          ),

          // =====================================================
          // COMPLAINT LIST
          // =====================================================

          Expanded(
            child: complaints.isEmpty
                ? _emptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      final complaint = complaints[index];

                      return _complaintCard(complaint);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FILTER BUTTON
  // =========================================================

  Widget _filterButton(String filter) {
    final isSelected = selectedFilter == filter;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(filter),
        selected: isSelected,
        onSelected: (_) {
          setState(() {
            selectedFilter = filter;
          });
        },
      ),
    );
  }

  // =========================================================
  // COMPLAINT CARD
  // =========================================================

  Widget _complaintCard(Complaint complaint) {
    return Container(
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
                    fontSize: 12,
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
                size: 18,
                color: Colors.grey,
              ),

              const SizedBox(width: 7),

              Text(
                complaint.category,
                style: const TextStyle(
                  color: Colors.grey,
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
                size: 18,
                color: Colors.grey,
              ),

              const SizedBox(width: 7),

              Expanded(
                child: Text(
                  complaint.location,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // DESCRIPTION
          Text(
            complaint.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 12),

          // PRIORITY
          Row(
            children: [
              const Icon(
                Icons.flag_outlined,
                size: 18,
              ),

              const SizedBox(width: 5),

              Text(
                'Priority: ${complaint.priority}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              if (complaint.officer != null)
                Text(
                  complaint.officer!,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 15),

          // ACTIONS
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showPriorityDialog(complaint);
                  },
                  icon: const Icon(
                    Icons.flag_outlined,
                    size: 18,
                  ),
                  label: const Text('Priority'),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showAssignDialog(complaint);
                  },
                  icon: const Icon(
                    Icons.person_add_alt_1,
                    size: 18,
                  ),
                  label: Text(
                    complaint.officer == null
                        ? 'Assign'
                        : 'Reassign',
                  ),
                ),
              ),
            ],
          ),
        ],
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
              'No complaints found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Complaints submitted by citizens will appear here.',
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