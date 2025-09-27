import 'package:cip_payment_web/domain/datasources/course_datasource.dart';
import 'package:cip_payment_web/domain/entities/course.dart';
import 'package:cip_payment_web/infrastructure/mappers/course_mapper.dart';
import 'package:cip_payment_web/infrastructure/models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CoursedbDatasource extends CourseDatasource{
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  @override
  Future<List<Course>> fetchAllCourse() async {
    try {
      final snapshot = await firestoredb.collection('Course').get();

      final coursesResponse = snapshot.docs.map((doc) {
        final data = doc.data();
        return CourseModel.fromFirestore(data);
      }).toList();
      // Mapear lista de Response a lista de Entity
      final courses = coursesResponse
          .map((resp) => CourseMapper.courseResponseToEntity(resp))
          .toList();

      return courses;
    } catch (e) {
      // print('❌ Error al obtener cursos: $e');
      return [];
    }
  }
  
  @override
  Future<Course?> createCourse(CourseModel course) async {
    try {
      // 1. Crear documento en Firestore
      final docRef = await firestoredb
          .collection('Course')
          .add(course.toFirestore());

      debugPrint('✅ Curso creado exitosamente con ID: ${docRef.id}');

      // 2. Obtener datos recién guardados
      final snapshot = await docRef.get();
      final data = snapshot.data() as Map<String, dynamic>;

      // 3. Mapear a Response
      final courseResponse = CourseModel.fromFirestore(data);

      // 4. Mapear a Entidad
      final newCourse = CourseMapper.courseResponseToEntity(courseResponse);

      return newCourse;
    } catch (e) {
      debugPrint('❌ Error al crear curso: $e');
      return null; // mejor null que un string si falla
    }
  }
}
