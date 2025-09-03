import 'package:flutter/cupertino.dart';

class BillProvider with ChangeNotifier {
  // Aquí puedes definir tus controladores y lógica de negocio
  // por ejemplo, para manejar el estado de los campos del formulario de la factura.

  TextEditingController ctrlRuc = TextEditingController();
  TextEditingController ctrlCompanyName = TextEditingController();
  TextEditingController ctrlIndustry = TextEditingController();
  TextEditingController ctrlAddress = TextEditingController();
  TextEditingController ctrlDepartment = TextEditingController();
  TextEditingController ctrlDistrict = TextEditingController();

  // Métodos para manejar la lógica de negocio, como validaciones o envíos de datos.

}
