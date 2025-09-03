import 'package:cip_payment_web/routes/app_routes_name.dart';

abstract class RouteDataTemporary {
  static String currentRoute = AppRoutesName.DASHBOARD;
  static int idChecklistToEdit = 0;
  static int idVisitToEdit = 0;
  static int currentIdEvaluation = 0;
  static int idStateOperation = 0;
  static int ope = 0;

  static void reset() {
    currentRoute = AppRoutesName.DASHBOARD;
    idChecklistToEdit = 0;
    idVisitToEdit = 0;
    currentIdEvaluation = 0;
    idStateOperation = 0;
  }
}
