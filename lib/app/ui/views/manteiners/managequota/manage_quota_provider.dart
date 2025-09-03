import 'package:cip_payment_web/app/models/month_model.dart';
import 'package:cip_payment_web/app/models/quota_model.dart';
import 'package:cip_payment_web/app/ui/components/toast/toast.dart';
import 'package:cip_payment_web/services/firebase/manage_quotas_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ManageQuotaProvider with ChangeNotifier {
  final ManageQuotasService cuotasService = ManageQuotasService();
  List<QuotaModel> listQuotas = [];
  String personId = '';
  double amount = 0;
  int feeMonth = 0;
  int feeYear = DateTime.now().year;
  String status = '';
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  DateTime dueDate = DateTime.now();
  TextEditingController ctrlAmount = TextEditingController(text: '30');
  TextEditingController ctrlAge = TextEditingController(
    text: DateFormat.y('es_ES').format(DateTime.now()),
  );

  List<MonthModel> listMonth = [
    MonthModel(id: 1, month: 'Enero'),
    MonthModel(id: 2, month: 'Febrero'),
    MonthModel(id: 3, month: 'Marzo'),
    MonthModel(id: 4, month: 'Abril'),
    MonthModel(id: 5, month: 'Mayo'),
    MonthModel(id: 6, month: 'Junio'),
    MonthModel(id: 7, month: 'Julio'),
    MonthModel(id: 8, month: 'Agosto'),
    MonthModel(id: 9, month: 'Septiembre'),
    MonthModel(id: 10, month: 'Octubre'),
    MonthModel(id: 11, month: 'Noviembre'),
    MonthModel(id: 12, month: 'Diciembre'),
  ];

  // MonthModel currentMonth = MonthModel(
  //   id: DateTime.now().month,
  //   month: DateFormat.MMMM('es_ES').format(DateTime.now()),
  // );
  MonthModel currentMonth = MonthModel(id: 8, month: 'Agosto');
  Future<void> getGeneratedPayments() async {
    try {
      final response = await cuotasService.fetchAllQuotas();
      if (response.isNotEmpty) {
        listQuotas = response;
      }
      print(response);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> createMemberFee() async {
    try {
      final response = cuotasService.createQuota(
        QuotaModel(
          personId: '',
          amount: amount,
          feeMonth: currentMonth.id,
          feeYear: feeYear,
          status: status,
          createdAt: Timestamp.fromDate(DateTime.now()),
          updatedAt: Timestamp.fromDate(DateTime.now()),
          dueDate: Timestamp.fromDate(DateTime.now()),
          isSelected: false,
        ),
      );
    } catch (e) {
    } finally {}
  }

  Future<void> generateQuotasForAllPersons(BuildContext context) async {
    amount = int.tryParse(ctrlAmount.toString())?.toDouble() ?? 30.0;
    try {
      final response = cuotasService.generateQuotasForEligiblePersons(
        feeMonth: currentMonth.id,
        feeYear: feeYear,
        amount: amount,
      );
      context.pop();
      showToastGlobal(
        context,
        0,
        "success",
        "Las cuotas fueron generadas correctamente.",
      );
    } catch (e) {
      showToastGlobal(
        context,
        0,
        "error",
        "Ocurrio un error, detalles: $e",
      );
    } finally {}
  }
}
