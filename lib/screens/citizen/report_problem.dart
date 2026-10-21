import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/complaint_store.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _descriptionController =
      TextEditingController();

  Uint8List? selectedImageBytes;

  String? selectedCategory;
  String? selectedLocation;

  final List<String> categories = [
    'Road / Pothole',
    'Street Light',
    'Garbage',
    'Water Leakage',
    'Drainage',
    'Traffic',
    'Other',
  ];

  final List<String> locations = [
    'MVP Colony',
    'Madhurawada',
    'Gajuwaka',
    'Dwaraka Nagar',
    'Siripuram',
    'Visakhapatnam Railway Station',
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  // ============================================================
  // PICK IMAGE
  // ============================================================

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (image == null) return;

      final bytes = await image.readAsBytes();

      setState(() {
        selectedImageBytes = bytes;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to select image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ============================================================
  // PHOTO OPTIONS
  // ============================================================

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Problem Photo',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.camera_alt),
                  ),
                  title: const Text('Take Photo'),
                  subtitle: const Text(
                    'Capture the problem using camera',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),

                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.photo_library),
                  ),
                  title: const Text('Choose from Gallery'),
                  subtitle: const Text(
                    'Select an existing photo',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // LOCATION
  // ============================================================

  void _showLocationOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Location',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                ...locations.map(
                  (location) {
                    return ListTile(
                      leading: const Icon(
                        Icons.location_on_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(location),
                      onTap: () {
                        setState(() {
                          selectedLocation = location;
                        });

                        Navigator.pop(context);
                      },
                    );
                  },
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // SUBMIT COMPLAINT
  // ============================================================

  void _submitComplaint() {
    // Category validation
    if (selectedCategory == null) {
      _showError('Please select a problem category.');
      return;
    }

    // Description validation
    if (_descriptionController.text.trim().isEmpty) {
      _showError('Please enter a problem description.');
      return;
    }

    // Photo validation
    if (selectedImageBytes == null) {
      _showError('Please add a problem photo.');
      return;
    }

    // Location validation
    if (selectedLocation == null) {
      _showError('Please select the problem location.');
      return;
    }

    // ==========================================================
    // CREATE COMPLAINT
    // ==========================================================

    final complaint = Complaint(
      id: 'CP-${DateTime.now().millisecondsSinceEpoch}',

      title: selectedCategory!,

      category: selectedCategory!,

      description:
          _descriptionController.text.trim(),

      location: selectedLocation!,

      photoBytes: selectedImageBytes,

      status: 'Pending',

      priority: 'Medium',

      createdAt: DateTime.now(),
    );

    // ==========================================================
    // ADD TO GLOBAL STORE
    // ==========================================================

    ComplaintStore.instance.addComplaint(
      complaint,
    );

    // ==========================================================
    // CONFIRMATION
    // ==========================================================

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Complaint submitted successfully!',
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Return to previous screen
    Navigator.pop(context);
  }

  // ============================================================
  // ERROR
  // ============================================================

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Report Problem',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // INTRO
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.campaign_outlined,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Report an Urban Problem',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Help your city by reporting problems around you.',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==================================================
            // CATEGORY
            // ==================================================

            const Text(
              'Problem Category',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 9),

            DropdownButtonFormField<String>(
              value: selectedCategory,

              decoration: InputDecoration(
                hintText: 'Select problem category',
                filled: true,
                fillColor: Colors.white,

                prefixIcon: const Icon(
                  Icons.category_outlined,
                  color: Colors.blue,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),

              items: categories.map(
                (category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                },
              ).toList(),

              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 22),

            // ==================================================
            // DESCRIPTION
            // ==================================================

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 9),

            TextField(
              controller: _descriptionController,

              maxLines: 5,

              decoration: InputDecoration(
                hintText:
                    'Describe the problem in detail...',

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 22),

            // ==================================================
            // PHOTO
            // ==================================================

            const Text(
              'Problem Photo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 9),

            GestureDetector(
              onTap: _showPhotoOptions,

              child: Container(
                width: double.infinity,
                height: 210,

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(16),

                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),

                child: selectedImageBytes == null
                    ? Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 48,
                            color: Colors.grey.shade500,
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            'Tap to add photo',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            'Camera or Gallery',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius:
                            BorderRadius.circular(15),

                        child: Image.memory(
                          selectedImageBytes!,
                          width: double.infinity,
                          height: 210,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 22),

            // ==================================================
            // LOCATION
            // ==================================================

            const Text(
              'Problem Location',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 9),

            GestureDetector(
              onTap: _showLocationOptions,

              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(14),

                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.red,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        selectedLocation ??
                            'Select problem location',

                        style: TextStyle(
                          color: selectedLocation == null
                              ? Colors.grey
                              : Colors.black87,

                          fontWeight:
                              selectedLocation == null
                                  ? FontWeight.normal
                                  : FontWeight.w600,
                        ),
                      ),
                    ),

                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ==================================================
            // SUBMIT
            // ==================================================

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed: _submitComplaint,

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF2563EB),

                  foregroundColor: Colors.white,

                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),

                child: const Text(
                  'Submit Complaint',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}