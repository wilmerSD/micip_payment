import 'package:cip_payment_web/app/models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CourseService {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  Future<List<CourseModel>> fetchAllCourse() async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('Course')
        .get();

    final courses = snapshot.docs.map((doc) {
      final data = doc.data();
      return CourseModel.fromFirestore(data);
    }).toList();

    return courses;
  } catch (e) {
    print('Error al obtener personas: $e');
    return [];
  }
  }

  Future<String> createCourse(CourseModel course) async {
  try {
    final response = await FirebaseFirestore.instance
        .collection('Course')
        .add(course.toFirestore());
    debugPrint('✅ Curso creada exitosamente');
    if (response.id.isNotEmpty) {
      return response.id;
    }
    return '';
  } catch (e) {
    debugPrint('❌ Error al crear persona: $e');
    return '';
  }
}
}

