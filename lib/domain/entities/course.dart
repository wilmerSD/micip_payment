import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
    final bool? itIsExternal;
    final Timestamp? createDate;
    final String? descriptionCourse;
    final Timestamp? endDateCourse;
    final Timestamp? endDateRegistration;
    final String? imageCourse;
    final int? modalityCourse;
    final String? nameCourse;
    final String? personId;
    final double? priceCourse;
    final Timestamp? startDateCourse;
    final bool? stateCourse;
    final int? totalTimeHours;
    final Timestamp? updatedDate;

    Course({
        this.itIsExternal,
        this.createDate,
        this.descriptionCourse,
        this.endDateCourse,
        this.endDateRegistration,
        this.imageCourse,
        this.modalityCourse,
        this.nameCourse,
        this.personId,
        this.priceCourse,
        this.startDateCourse,
        this.stateCourse,
        this.totalTimeHours,
        this.updatedDate,
    });

}