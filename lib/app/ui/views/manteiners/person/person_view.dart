import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/app/ui/components/button/btn_secondary.dart';
import 'package:cip_payment_web/app/ui/components/input_primary.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/person/person_provider.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/person/table_persons.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/person/widgets/form_person.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonView extends StatelessWidget {
  const PersonView({super.key});
  @override
  Widget build(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context, listen: false);

    // Se ejecuta solo una vez cuando se construye el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      personProvider.getAllPerson();
    });

    return Consumer<PersonProvider>(
      builder: (context, personProvider, _) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor(context),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20.0,
            children: [
              // SizedBox(height: 20.0,),
              SizedBox(
                width: 200.0,
                child: BtnPrimaryInk(
                  text: 'Nueva persona',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PopupGeneral(
                          title: 'Ingresar persona',
                          onTapButton: () {},
                          scrollable: true,
                          content: FormPerson(personProvider: personProvider),
                        );
                      },
                    );
                  },
                ),
              ),
              _seeker(context, personProvider),
              Expanded(child: TablePersons(provider: personProvider)),
            ],
          ),
        );
      },
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//         create: (_) => PersonProvider(),
//         child: Builder(builder: (context) {
//           final personProvider =
//               Provider.of<PersonProvider>(context, listen: false);

//           // Se ejecuta solo una vez cuando se construye el widget
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             personProvider.getAllPerson();
//           });

//           return Consumer<PersonProvider>(
//               builder: (context, personProvider, _) {
//             return Scaffold(
//                 backgroundColor: AppColors.backgroundColor(context),
//                 body: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   spacing: 20.0,
//                   children: [
//                     // SizedBox(height: 20.0,),
//                     SizedBox(
//                       width: 200.0,
//                       child: BtnPrimaryInk(
//                           text: 'Nueva persona',
//                           onTap: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return PopupGeneral(
//                                     title: 'Ingresar persona',
//                                     onTapButton: () {},
//                                     scrollable: true,
//                                     content: FormPerson(personProvider: personProvider,),
//                                         );
//                               },
//                             );
//                           }),
//                     ),
//                     _seeker(context, personProvider),
//                     Expanded(
//                       child: TablePersons(
//                         provider: personProvider,
//                       ),
//                     )
//                   ],
//                 ));
//           });
//         }));
//   }
// }

Widget _seeker(BuildContext context, PersonProvider personProvider) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    height: 100.0,
    decoration: BoxDecoration(
      color: AppColors.backgroundColor(context),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.07),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 1), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      spacing: 30.0,
      children: [
        Expanded(
          child: InputPrimary(
            label: "Nombres y/o apellidos",
            textEditingController: personProvider.searchFullName,
            // inputFormats: [
            //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // ],
            // maxLength: personProvider.typeDocument.value == 0 ? 8 : null,
          ),
        ),
        Expanded(
          child: InputPrimary(
            label: "Nro documento",
            textEditingController: personProvider.searchDni,
            // inputFormats: [
            //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // ],
            // maxLength: personProvider.typeDocument.value == 0 ? 8 : null,
          ),
        ),
        Expanded(
          child: InputPrimary(
            label: "Nro documento",
            textEditingController: personProvider.searchBySpecialty,
            // inputFormats: [
            //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // ],
            // maxLength: personProvider.typeDocument.value == 0 ? 8 : null,
          ),
        ),
        SizedBox(
          width: 150.0,
          child: BtnSecondary(
            text: 'Limpiar',
            onTap: () => personProvider.cleanSearch(),
          ),
        ),
      ],
    ),
  );
}
