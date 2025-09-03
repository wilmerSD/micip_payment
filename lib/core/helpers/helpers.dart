import 'dart:convert';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  static String formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('HH:mm').format(dateTime);
  }

  static String formatDateddMMString(String date) {
    if (date.isEmpty) return '';
    DateTime parsedDate = DateTime.parse(date);
    List<String> months = [
      "Ene",
      "Feb",
      "Mar",
      "Abr",
      "May",
      "Jun",
      "Jul",
      "Ago",
      "Sep",
      "Oct",
      "Nov",
      "Dic"
    ];
    return "${parsedDate.day}/${months[parsedDate.month - 1]}";
  }

  static String getNameMonth(int month) {
    if (month < 1 || month > 12) return "";
    List<String> months = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre"
    ];
    return months[month-1];
  }


  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /* 📌 Obtener iniciales de los nombres*/
  static String getInitial(String name) {
    if (name.isEmpty) return '';
    
    List<String> parts = name.trim().split(' ');
    /* String initials = parts
        .where((part) => part.isNotEmpty) // Elimina strings vacíos
        .map((part) => part[0].toUpperCase()) // Toma la primera letra
        .join(); */
     String initials = parts
      .where((part) => part.isNotEmpty) // Filtrar vacíos primero
      .take(2) // Solo las primeras dos palabras
      .map((part) => part[0].toUpperCase())
      .join();
    return initials;
  }

  static String formattedDateToDMA(DateTime? date) {
    if (date == null) return 'Fecha no disponible';

    String formattedDate = '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year.toString().substring(2)}';

    return formattedDate;
  }

  static String formattedRecords(String text) {
    if (text.isEmpty) return '';
    String formattedText = '';
    formattedText = text.replaceAll(RegExp(r'</(p|span)>'), '\n');
    formattedText = formattedText.replaceAll(
        RegExp(
            r'<span style="font-family:verdana,arial; font-size:10px; font-stretch:normal; font-style:normal;"><strong>'),
        '');
    formattedText = formattedText.replaceAll(
        RegExp(r'<span><br>------------------------------<br></p>'), '');
    formattedText = formattedText.replaceAll(RegExp(r'<p>'), '');
    formattedText = formattedText.replaceAll(RegExp(r'<br>'), '');
    formattedText = formattedText.replaceAll(RegExp(r'<span>'), '');
    formattedText = formattedText.replaceAll(RegExp(r'</strong>'), '');
    return formattedText.trimRight();
  }

  static int getHours(String time) {
    if (time.isEmpty) return 0;
    return int.parse(time.split(':')[0]);
  }

  static int getMinutes(String time) {
    if (time.isEmpty) return 0;
    return int.parse(time.split(':')[1]);
  }

  static String formattedDateddmmyy(DateTime? date) {
    if (date == null) return 'Fecha no disponible';

    String formattedDate = '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year.toString().substring(2)}';

    return formattedDate;
  }

  static String dateToStringDMY(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  static String formatStringDateToddmmyy(String date) {
    if (date.isEmpty) return "Fecha no disponible";
    List<String> parts = date.split('-');
    return '${parts[2]}/${parts[1]}/${parts[0].substring(2)}';
  }

  static Future<dynamic> loadJsonAssets(String fileName) async {
    final response = await rootBundle.loadString("assets/json/$fileName");
    return json.decode(response);
  }

  static DateTime stringToDateTime(String dateTimeString) {
    try {
      final formatter = DateFormat('yyyy/MM/dd');
      return formatter.parse(dateTimeString);
    } catch (e) {
      return DateTime.now();
    }
  }
  
  static String timestampToString(Timestamp timeStamp) {
    try {
      DateTime date = timeStamp.toDate();
      String formattedDate = DateFormat('yyyy/MM/dd').format(date);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  static noRequiredDateTime(String? value, String date) {
    RegExp fechaRegex =
        RegExp(r'^(\d{4})/(0[1-9]|1[0-2])/(0[1-9]|1\d|2\d|3[01])$');
    if (value == null || value.isEmpty) {
      return null;
    } else if (!fechaRegex.hasMatch(date)) {
      return "Formato no válido";
    } else {
      return null;
    }
  }

  static noRequiredDateTimeDMY(String? value, String date) {
    RegExp fechaRegex =
        RegExp(r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[012])\/\d{4}$');
    if (value == null || value.isEmpty) {
      return null;
    } else if (!fechaRegex.hasMatch(date)) {
      return "Formato no válido";
    } else {
      return null;
    }
  }

  static String? regexFormSearch(
    String? value,
  ) {
    final regExp = RegExp(r'^$|^[0-9a-zA-ZáéíóúÁÉÍÓÚñÑ\s\-\_\(\)\/]*$');
    if (value == null || value.isEmpty) {
      return null;
    } else if (!regExp.hasMatch(value)) {
      return "Caracteres permitidos '/', '-' , '_' y '()'";
    } else {
      return null;
    }
  }

  /* 📌 comparar fechas en formato yyyy/mm/dd*/
  static int compareDates(String date1, String date2) {
    DateFormat format = DateFormat("yyyy/MM/dd");
    if (date1.isEmpty || date2.isEmpty) {
      return 0;
    }
    try {
      DateTime dateTime1 = format.parseStrict(date1);
      DateTime dateTime2 = format.parseStrict(date2);
      return dateTime1.compareTo(dateTime2);
    } catch (e) {
      // Error de formato de fecha
      return 0;
    }
  }

/* 📌 comparar fechas en formato dd/mm/yyyy*/
  static int compareDatesDMY(String date1, String date2) {
    DateFormat format = DateFormat("dd/MM/yyyy");
    if (date1.isEmpty || date2.isEmpty) {
      return 0;
    }
    try {
      DateTime dateTime1 = format.parseStrict(date1);
      DateTime dateTime2 = format.parseStrict(date2);
      return dateTime1.compareTo(dateTime2);
    } catch (e) {
      // Error de formato de fecha
      return 0;
    }
  }

  /* 📌 Formato del calendario */
  static String dateToStringTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy/MM/dd');
    return formatter.format(dateTime);
  }

  /* 📌 Formato del calendario dd/mm/yyyy */
  static String dateToStringTimeDMY(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  /* 📌 Formato del calendario dd/mm/yyyy */
  static String dateToStringHourMinute(DateTime dateTime) {
    final formatter = DateFormat('hh:mm a'); // Formato 12 horas con AM/PM
    return formatter.format(dateTime);
  }

  static String formatDurationToHHMM(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes.remainder(60);

    final String formattedHours = hours.toString().padLeft(2, '0');
    final String formattedMinutes = minutes.toString().padLeft(2, '0');

    return "$formattedHours:$formattedMinutes";
  }

  static String formatDurationToHHMMCupertino(DateTime duration) {
    final int hours = duration.hour;
    final int minutes = duration.minute.remainder(60);

    final String formattedHours = hours.toString().padLeft(2, '0');
    final String formattedMinutes = minutes.toString().padLeft(2, '0');

    return "$formattedHours:$formattedMinutes";
  }

  static String timeOfDayToString(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final formatter = DateFormat('hh:mm a');
    return formatter.format(dateTime);
  }

  static String formatearHora(String stringDateHour) {
    // Parsear la cadena a un objeto DateTime
    DateTime dateTime = DateTime.parse(stringDateHour);
    // Formatear la hora en formato de 12 horas con AM/PM
    String horaFormateada = DateFormat('hh:mm a').format(dateTime);
    return horaFormateada;
  }

  Color getCircleColor(int idValidacion) {
    Color circleColor;
    switch (idValidacion) {
      case 1:
        circleColor = AppColors.validationTimely;
        break;
      case 2:
        circleColor = AppColors.validationLate;
        break;
      case 3:
        circleColor = AppColors.validationMissing;
        break;
      default:
        circleColor = AppColors.validationJustified;
        break;
    }
    return circleColor;
  }

  String getWeekCurrent() {
    final now = DateTime.now();
    // Obtén el día de la semana actual (0 = domingo, 1 = lunes, ..., 6 = sábado)
    final currentDayOfWeek = now.weekday;
    // Calcula la fecha del lunes de la semana actual
    final startOfWeek = now.subtract(Duration(days: currentDayOfWeek - 1));
    // Calcula la fecha del viernes de la semana actual
    final endOfWeek = startOfWeek.add(const Duration(days: 4));
    final format = DateFormat('dd', 'es');
    final monthFormat = DateFormat('MMM', 'es');
    final startDayFormatted = format.format(startOfWeek);
    final endDayFormatted = format.format(endOfWeek);
    final monthFormatted = monthFormat.format(startOfWeek);

    return '$startDayFormatted - $endDayFormatted $monthFormatted.';
  }

  String getDateLarge() {
    final now = DateTime.now();
    final format = DateFormat('EEEE dd \'de\' MMM.', 'es');
    return format.format(now);
  }

  String formatDateNormal(DateTime fecha) {
    final DateFormat formato = DateFormat('yyyy-MM-dd');
    return formato.format(fecha);
  }

  String formatDateShort(DateTime fecha) {
    final DateFormat formato = DateFormat('yyyy-MM');
    return formato.format(fecha);
  }

  static Timestamp? stringToTimestamp(String dateString, {String format = "dd-MM-yyyy"}) {
  try {
    final DateFormat formatter = DateFormat(format);
    final DateTime parsedDate = formatter.parse(dateString);

    return Timestamp.fromDate(parsedDate);
  } catch (e) {
    return null;
  }
}

  /* 📌 Comparar que las contraseñas ingresadas sean iguales */
  static String? comparePassword(String firstPass, String secondPass) {
    if (firstPass != secondPass) {
      return "Asegúrate de que las contraseñas sean idénticas";
    } else {
      return null;
    }
  }

  /* 📌 Validar fecha en formato yyyy/MM/dd  */
  static String? validateDateFormat(String? value) {
    if (value == null || value.isEmpty) {
      return "Seleccionar una fecha";
    } else {
      final RegExp dateRegex =
          RegExp(r'^\d{4}\/(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])$');
      if (!dateRegex.hasMatch(value)) {
        return "Formato de fecha inválido";
      }
      return null;
    }
  }

  /* 📌 Validar fecha en formato dd/MM/yyyy */
  static String? validateDateFormatDMY(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else {
      final RegExp dateRegex =
          RegExp(r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[012])\/\d{4}$');
      if (!dateRegex.hasMatch(value)) {
        return "Formato de fecha inválido";
      }
      return null;
    }
  }

  /* 📌 Cambiar formato de fecha de yyyy/MM/dd a dd/MM/yyyy */
  static String changeDateToddMMyyyy(String date) {
    DateFormat inputFormat =
        DateFormat('yyyy/MM/dd'); // Define el formato de entrada
    DateFormat outputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de salida

    DateTime dateTime =
        inputFormat.parse(date); // Convierte la cadena de texto a DateTime
    String formattedDateString = outputFormat.format(
        dateTime); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }

  /* 📌 Cambiar formato de fecha de  dd/MM/yyyy  a yyyy/MM/dd */
  static String changeDateToyyyyMMdd(String date) {
    DateFormat inputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de entrada
    DateFormat outputFormat =
        DateFormat('yyyy/MM/dd'); // Define el formato de salida

    DateTime dateTime =
        inputFormat.parse(date); // Convierte la cadena de texto a DateTime
    String formattedDateString = outputFormat.format(
        dateTime); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }

  // 📌 Saber que tipo de error es y mostrar un mensaje descriptivo al usuario
  static String knowTypeError(error) {
    if (error.toString().contains('NOT_INTERNET_EXCEPTION')) {
      return "kmessageErrorNetwork";
    }
    if (error.toString().contains('TIME_OUT')) {
      return "messageErrorOnTimeOut";
    }
    if (error.toString().contains('connection error')) {
      return "messageErrorNotResponse";
    } else {
      return "kmessageErrorGeneral";
    }
  }

  /* 📌 Cambiar formato de fecha de yyyy/MM/dd a dd/MM/yyyy */
  static String changeDateTodMy(String date) {
    DateFormat inputFormat =
        DateFormat('yyyy-MM-dd'); // Define el formato de entrada
    DateFormat outputFormat =
        DateFormat('dd/MM/yyyy'); // Define el formato de salida

    DateTime dateTime =
        inputFormat.parse(date); // Convierte la cadena de texto a DateTime
    String formattedDateString = outputFormat.format(
        dateTime); // Convierte DateTime de vuelta a la cadena de texto con el nuevo formato
    return formattedDateString;
  }

}
