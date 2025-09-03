import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
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

    CourseModel({
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

    factory CourseModel.fromFirestore(Map<String, dynamic> json) => CourseModel(
        itIsExternal: json["ItIsExternal"],
        createDate: json["createDate"] ?? Timestamp.now(),
        descriptionCourse: json["descriptionCourse"],
        endDateCourse: json["endDateCourse"] ?? Timestamp.now(),
        endDateRegistration: json["endDateRegistration"] ?? Timestamp.now(),
        imageCourse: json["imageCourse"],
        modalityCourse: json["modalityCourse"],
        nameCourse: json["nameCourse"],
        personId: json["personId"],
        priceCourse: json["priceCourse"]?.toDouble(),
        startDateCourse: json["startDateCourse"] ?? Timestamp.now(),
        stateCourse: json["stateCourse"],
        totalTimeHours: json["totalTimeHours"],
        updatedDate: json["updatedDate"] ?? Timestamp.now(),
    );

    Map<String, dynamic> toFirestore() => {
        "ItIsExternal": itIsExternal,
        "createDate": createDate,
        "descriptionCourse": descriptionCourse,
        "endDateCourse": endDateCourse,
        "endDateRegistration": endDateRegistration,
        "imageCourse": imageCourse,
        "modalityCourse": modalityCourse,
        "nameCourse": nameCourse,
        "personId": personId,
        "priceCourse": priceCourse,
        "startDateCourse": startDateCourse,
        "stateCourse": stateCourse,
        "totalTimeHours": totalTimeHours,
        "updatedDate": updatedDate,
    };
}