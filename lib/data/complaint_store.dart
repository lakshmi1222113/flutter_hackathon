import 'package:flutter/foundation.dart';
import 'dart:typed_data';

class Complaint {
  String id;
  String title;
  String category;
  String description;
  String location;

  Uint8List? photoBytes;
  Uint8List? resolutionPhotoBytes;

  String status;
  String priority;
  String? department;
  String? officer;

  DateTime createdAt;

  Complaint({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.location,
    this.photoBytes,
    this.resolutionPhotoBytes,
    this.status = 'Pending',
    this.priority = 'Medium',
    this.department,
    this.officer,
    required this.createdAt,
  });
}

class ComplaintStore extends ChangeNotifier {
  ComplaintStore._();

  static final ComplaintStore instance = ComplaintStore._();

  final List<Complaint> _complaints = [];

  List<Complaint> get complaints =>
      List.unmodifiable(_complaints);

  void addComplaint(Complaint complaint) {
    _complaints.insert(0, complaint);
    notifyListeners();
  }

  void assignComplaint({
    required String complaintId,
    required String department,
    required String officer,
  }) {
    final complaint = _findComplaint(complaintId);

    if (complaint == null) return;

    complaint.department = department;
    complaint.officer = officer;
    complaint.status = 'Assigned';

    notifyListeners();
  }

  void updateStatus({
    required String complaintId,
    required String status,
  }) {
    final complaint = _findComplaint(complaintId);

    if (complaint == null) return;

    complaint.status = status;

    notifyListeners();
  }

  void updatePriority({
    required String complaintId,
    required String priority,
  }) {
    final complaint = _findComplaint(complaintId);

    if (complaint == null) return;

    complaint.priority = priority;

    notifyListeners();
  }

  void addResolutionPhoto({
    required String complaintId,
    required Uint8List photoBytes,
  }) {
    final complaint = _findComplaint(complaintId);

    if (complaint == null) return;

    complaint.resolutionPhotoBytes = photoBytes;

    notifyListeners();
  }

  Complaint? _findComplaint(String id) {
    for (final complaint in _complaints) {
      if (complaint.id == id) {
        return complaint;
      }
    }

    return null;
  }
}