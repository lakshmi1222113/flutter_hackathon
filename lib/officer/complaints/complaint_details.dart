import 'package:flutter/material.dart';

class ComplaintDetails extends StatefulWidget {
  final Map<String, String> complaint;

  const ComplaintDetails({
    super.key,
    required this.complaint,
  });

  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  late String currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.complaint['status'] ?? 'Pending';
  }

  // ============================================================
  // PROBLEM IMAGE
  // ============================================================

  String? getProblemImage() {
    final title =
        (widget.complaint['title'] ?? '').toLowerCase();

    final category =
        (widget.complaint['category'] ?? '').toLowerCase();

    if (title.contains('water') || category.contains('water')) {
      return 'assets/images/water_leakage.jpeg';
    }

    if (title.contains('pothole') ||
        category.contains('road')) {
      return 'assets/images/potholo_problem.jpg';
    }

    if (title.contains('streetlight') ||
        category.contains('electrical')) {
      return 'assets/images/streetlight_problem.jpeg';
    }

    return null;
  }

  // ============================================================
  // SOLUTION IMAGE
  // ============================================================

  String? getSolutionImage() {
    final title =
        (widget.complaint['title'] ?? '').toLowerCase();

    final category =
        (widget.complaint['category'] ?? '').toLowerCase();

    if (title.contains('water') || category.contains('water')) {
      return 'assets/images/water_leakage_solution.png';
    }

    if (title.contains('pothole') ||
        category.contains('road')) {
      return 'assets/images/potholo_solution.jpeg';
    }

    if (title.contains('streetlight') ||
        category.contains('electrical')) {
      return 'assets/images/street_solution.jpg';
    }

    return null;
  }

  // ============================================================
  // DEPARTMENT
  // ============================================================

  String getDepartment() {
    final category =
        (widget.complaint['category'] ?? '').toLowerCase();

    if (category.contains('water')) {
      return 'Water Department';
    }

    if (category.contains('electrical')) {
      return 'Electrical Department';
    }

    if (category.contains('sanitation')) {
      return 'Sanitation Department';
    }

    if (category.contains('road')) {
      return 'Roads Department';
    }

    return 'Municipal Services';
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final complaint = widget.complaint;

    final title =
        complaint['title'] ?? 'Water Leakage';

    final category =
        complaint['category'] ?? 'Water';

    final location =
        complaint['location'] ?? 'MVP Colony';

    final priority =
        complaint['priority'] ?? 'High';

    final description =
        complaint['description'] ??
            'Water leakage has been reported in this area. Immediate action is required to prevent water wastage.';

    final problemImage = getProblemImage();
    final solutionImage = getSolutionImage();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          'Complaint Details',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.w700,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Color(0xFF0F172A),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ==================================================
              // COMPLAINT ID + STATUS
              // ==================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    complaint['id'] ?? 'CP1025',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                    ),
                  ),

                  _StatusBadge(
                    text: currentStatus,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ==================================================
              // PROBLEM PHOTO
              // ==================================================

              const Text(
                'Problem Photo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),

              const SizedBox(height: 10),

              _PhotoBox(
                imagePath: problemImage,
                placeholderText: 'Problem photo not available',
                icon: Icons.image_outlined,
              ),

              const SizedBox(height: 24),

              // ==================================================
              // TITLE
              // ==================================================

              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                category,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // INFORMATION
              // ==================================================

              _InfoCard(
                children: [
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    title: 'Location',
                    value: location,
                  ),

                  _InfoRow(
                    icon: Icons.business_outlined,
                    title: 'Department',
                    value: getDepartment(),
                  ),

                  _InfoRow(
                    icon: Icons.priority_high_outlined,
                    title: 'Priority',
                    value: priority,
                  ),
                ],
              ),

              const SizedBox(height: 22),

              // ==================================================
              // DESCRIPTION
              // ==================================================

              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),

                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                  ),
                ),

                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF475569),
                  ),
                ),
              ),

              const SizedBox(height: 26),

              // ==================================================
              // STATUS TIMELINE
              // ==================================================

              const Text(
                'Status Timeline',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),

              const SizedBox(height: 16),

              _TimelineItem(
                title: 'Complaint Reported',
                subtitle:
                    'Complaint submitted by citizen',
                completed: true,
                isLast: false,
              ),

              _TimelineItem(
                title: 'Assigned to Officer',
                subtitle:
                    'Complaint assigned for action',
                completed: true,
                isLast: false,
              ),

              _TimelineItem(
                title: 'In Progress',
                subtitle:
                    'Officer is working on the complaint',
                completed:
                    currentStatus == 'In Progress' ||
                    currentStatus == 'Resolved',
                isLast: false,
              ),

              _TimelineItem(
                title: 'Resolved',
                subtitle:
                    'Complaint has been resolved',
                completed:
                    currentStatus == 'Resolved',
                isLast: true,
              ),

              const SizedBox(height: 26),

              // ==================================================
              // UPDATE STATUS
              // ==================================================

              const Text(
                'Update Status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: currentStatus,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,

                  prefixIcon: const Icon(
                    Icons.sync_outlined,
                    color: Color(0xFF2563EB),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                    ),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE2E8F0),
                    ),
                  ),
                ),

                items: const [
                  DropdownMenuItem(
                    value: 'Pending',
                    child: Text('Pending'),
                  ),

                  DropdownMenuItem(
                    value: 'In Progress',
                    child: Text('In Progress'),
                  ),

                  DropdownMenuItem(
                    value: 'Resolved',
                    child: Text('Resolved'),
                  ),
                ],

                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    currentStatus = value;
                  });
                },
              ),

              const SizedBox(height: 14),

              // ==================================================
              // UPDATE BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                height: 52,

                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          'Status updated to $currentStatus',
                        ),
                      ),
                    );

                    setState(() {});
                  },

                  icon: const Icon(Icons.check),

                  label: const Text(
                    'Update Status',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF2563EB),

                    foregroundColor: Colors.white,

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ==================================================
              // RESOLUTION PHOTO
              // ==================================================

              const Text(
                'Resolution Photo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),

              const SizedBox(height: 10),

              // IMPORTANT:
              // Solution image is ALWAYS displayed.
              // It does not depend on currentStatus.

              _PhotoBox(
                imagePath: solutionImage,
                placeholderText:
                    'Resolution photo not available',
                icon: Icons.camera_alt_outlined,
              ),

              const SizedBox(height: 18),

              // ==================================================
              // RESOLUTION NOTE
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(14),

                  border: Border.all(
                    color: const Color(0xFFBBF7D0),
                  ),
                ),

                child: const Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Color(0xFF16A34A),
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        'Resolution photo uploaded by the officer after fixing the issue.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          color: Color(0xFF166534),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PHOTO BOX
// ============================================================

class _PhotoBox extends StatelessWidget {
  final String? imagePath;
  final String placeholderText;
  final IconData icon;

  const _PhotoBox({
    required this.imagePath,
    required this.placeholderText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),

        child: Image.asset(
          imagePath!,

          width: double.infinity,
          height: 220,

          fit: BoxFit.cover,

          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return _placeholder();
          },
        ),
      );
    }

    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      width: double.infinity,
      height: 180,

      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),

        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [
          Icon(
            icon,
            size: 42,
            color: const Color(0xFF94A3B8),
          ),

          const SizedBox(height: 10),

          Text(
            placeholderText,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// INFO CARD
// ============================================================

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(16),

        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),

      child: Column(
        children: children,
      ),
    );
  }
}

// ============================================================
// INFO ROW
// ============================================================

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Icon(
            icon,
            color: const Color(0xFF2563EB),
            size: 21,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// STATUS BADGE
// ============================================================

class _StatusBadge extends StatelessWidget {
  final String text;

  const _StatusBadge({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color background;
    Color foreground;

    if (text == 'Resolved') {
      background = const Color(0xFFDCFCE7);
      foreground = const Color(0xFF15803D);
    } else if (text == 'In Progress') {
      background = const Color(0xFFDBEAFE);
      foreground = const Color(0xFF2563EB);
    } else {
      background = const Color(0xFFFEF3C7);
      foreground = const Color(0xFFD97706);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),

      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ============================================================
// TIMELINE ITEM
// ============================================================

class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool completed;
  final bool isLast;

  const _TimelineItem({
    required this.title,
    required this.subtitle,
    required this.completed,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Column(
          children: [
            Container(
              width: 28,
              height: 28,

              decoration: BoxDecoration(
                color: completed
                    ? const Color(0xFF2563EB)
                    : const Color(0xFFE2E8F0),

                shape: BoxShape.circle,
              ),

              child: Icon(
                completed
                    ? Icons.check
                    : Icons.circle,

                size: completed ? 17 : 8,

                color: completed
                    ? Colors.white
                    : const Color(0xFF94A3B8),
              ),
            ),

            if (!isLast)
              Container(
                width: 2,
                height: 45,
                color: completed
                    ? const Color(0xFF2563EB)
                    : const Color(0xFFE2E8F0),
              ),
          ],
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 20),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,

                    color: completed
                        ? const Color(0xFF0F172A)
                        : const Color(0xFF94A3B8),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,

                    color: completed
                        ? const Color(0xFF64748B)
                        : const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}