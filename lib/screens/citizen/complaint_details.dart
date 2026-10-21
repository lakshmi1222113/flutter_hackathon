import 'package:flutter/material.dart';
import '../../data/complaint_store.dart';

class ComplaintDetails extends StatelessWidget {
  final Complaint complaint;

  const ComplaintDetails({
    super.key,
    required this.complaint,
  });

  @override
  Widget build(BuildContext context) {
    final status = complaint.status;

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: const Text(
          'Complaint Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xffF5F6FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // PHOTO
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffDDEAF5),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 50,
                    color: Color(0xff2196F3),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Problem Photo',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // TITLE + STATUS
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    complaint.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                _statusChip(status),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              complaint.category,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 18),

            // DESCRIPTION
            _sectionTitle('Description'),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                complaint.description,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 22),

            // LOCATION
            _sectionTitle('Location'),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xffE8F4FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xff2196F3),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          complaint.location,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Reported location',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.map_outlined,
                    color: Color(0xff2196F3),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // ASSIGNMENT
            _sectionTitle('Assignment'),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _infoRow(
                    Icons.business_outlined,
                    'Department',
                    complaint.department ?? 'Not assigned yet',
                  ),

                  const Divider(height: 24),

                  _infoRow(
                    Icons.person_outline,
                    'Officer',
                    complaint.officer ?? 'Not assigned yet',
                  ),

                  const Divider(height: 24),

                  _infoRow(
                    Icons.flag_outlined,
                    'Priority',
                    complaint.priority,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // STATUS TIMELINE
            _sectionTitle('Status Timeline'),

            const SizedBox(height: 15),

            _timelineItem(
              title: 'Complaint Submitted',
              subtitle: 'Complaint received by CityPulse',
              icon: Icons.check,
              active: true,
              isLast: false,
            ),

            _timelineItem(
              title: 'Department Assigned',
              subtitle: complaint.department != null
                  ? '${complaint.department} assigned'
                  : 'Waiting for department assignment',
              icon: Icons.business,
              active: complaint.department != null,
              isLast: false,
            ),

            _timelineItem(
              title: 'In Progress',
              subtitle: complaint.officer != null
                  ? '${complaint.officer} is working on the issue'
                  : 'Waiting for officer assignment',
              icon: Icons.autorenew,
              active: status == 'In Progress' || status == 'Resolved',
              isLast: false,
            ),

            _timelineItem(
              title: 'Resolved',
              subtitle: status == 'Resolved'
                  ? 'Problem has been resolved'
                  : 'Problem is not resolved yet',
              icon: Icons.check_circle,
              active: status == 'Resolved',
              isLast: true,
            ),

            const SizedBox(height: 20),

            // INFO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffEEF6FF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Color(0xff2196F3),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'You will receive updates when the status of your complaint changes.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget _infoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: const Color(0xffEEF6FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: const Color(0xff2196F3),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _statusChip(String status) {
    Color color;

    if (status == 'Pending') {
      color = Colors.orange;
    } else if (status == 'Assigned') {
      color = Colors.purple;
    } else if (status == 'In Progress') {
      color = Colors.blue;
    } else {
      color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget _timelineItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool active,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: active
                    ? const Color(0xff2196F3)
                    : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: active ? Colors.white : Colors.grey,
                size: 18,
              ),
            ),

            if (!isLast)
              Container(
                width: 2,
                height: 58,
                color: active
                    ? const Color(0xff2196F3)
                    : Colors.grey.shade300,
              ),
          ],
        ),

        const SizedBox(width: 13),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: active ? Colors.black : Colors.grey,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
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