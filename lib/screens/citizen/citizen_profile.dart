import 'package:flutter/material.dart';

import '../../auth/login_screen.dart';

class CitizenProfile extends StatelessWidget {
  const CitizenProfile({super.key});

  // =====================================================
  // LOGOUT
  // =====================================================

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout from CityPulse?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Close logout dialog
                Navigator.pop(dialogContext);

                // Remove all previous screens
                // and go back to Login Screen.
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // NOTIFICATIONS
  // =====================================================

  void _showNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.notifications_outlined,
                color: Color(0xff2196F3),
              ),
              SizedBox(width: 10),
              Text('Notifications'),
            ],
          ),
          content: const Text(
            'Your notification preferences are enabled.\n\n'
            'You will receive updates about complaint status, '
            'department assignment and resolution.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // HELP & SUPPORT
  // =====================================================

  void _showHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.help_outline,
                color: Color(0xff2196F3),
              ),
              SizedBox(width: 10),
              Text('Help & Support'),
            ],
          ),
          content: const Text(
            'Need help with CityPulse?\n\n'
            'You can report urban problems, track complaints, '
            'support nearby complaints and receive status updates.\n\n'
            'For technical support, please contact the CityPulse '
            'support team.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // ABOUT CITYPULSE
  // =====================================================

  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.location_city,
                color: Color(0xff2196F3),
              ),
              SizedBox(width: 10),
              Text('About CityPulse'),
            ],
          ),
          content: const Text(
            'CityPulse is a citizen-focused urban problem '
            'reporting and management application.\n\n'
            'Citizens can report problems, view nearby issues, '
            'track complaints and receive updates from city '
            'departments.\n\n'
            'Version 1.0.0',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            // =====================================================
            // PROFILE HEADER
            // =====================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [

                  // Profile Avatar
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      color: const Color(0xffE8F4FF),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xff2196F3),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 48,
                      color: Color(0xff2196F3),
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Rahul Kumar',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Citizen',
                    style: TextStyle(
                      color: Color(0xff2196F3),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Statistics
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                    children: [
                      _statItem(
                        value: '3',
                        label: 'Complaints',
                      ),
                      _divider(),
                      _statItem(
                        value: '1',
                        label: 'Resolved',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // PERSONAL INFORMATION
            // =====================================================

            _sectionTitle('Personal Information'),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _infoTile(
                    icon: Icons.person_outline,
                    title: 'Full Name',
                    value: 'Rahul Kumar',
                  ),

                  _line(),

                  _infoTile(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    value: 'rahul.kumar@email.com',
                  ),

                  _line(),

                  _infoTile(
                    icon: Icons.phone_outlined,
                    title: 'Phone',
                    value: '+91 98765 43210',
                  ),

                  _line(),

                  _infoTile(
                    icon: Icons.location_on_outlined,
                    title: 'Area',
                    value: 'MVP Colony',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // =====================================================
            // SETTINGS
            // =====================================================

            _sectionTitle('Settings'),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _settingTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle:
                        'Manage complaint notifications',
                    onTap: () {
                      _showNotifications(context);
                    },
                  ),

                  _line(),

                  _settingTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle:
                        'Get help using CityPulse',
                    onTap: () {
                      _showHelp(context);
                    },
                  ),

                  _line(),

                  _settingTile(
                    icon: Icons.info_outline,
                    title: 'About CityPulse',
                    subtitle:
                        'Application information',
                    onTap: () {
                      _showAbout(context);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // =====================================================
            // LOGOUT BUTTON
            // =====================================================

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () {
                  _logout(context);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.red,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'CityPulse • Make your city better, together.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // STAT ITEM
  // =====================================================

  static Widget _statItem({
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff2196F3),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // =====================================================
  // DIVIDER
  // =====================================================

  static Widget _divider() {
    return Container(
      width: 1,
      height: 35,
      color: Colors.grey.shade200,
    );
  }

  // =====================================================
  // SECTION TITLE
  // =====================================================

  static Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // =====================================================
  // INFO TILE
  // =====================================================

  static Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      child: Row(
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
              size: 21,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // SETTING TILE
  // =====================================================

  static Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      leading: Container(
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
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  // =====================================================
  // LINE
  // =====================================================

  static Widget _line() {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: Colors.grey.shade200,
    );
  }
}