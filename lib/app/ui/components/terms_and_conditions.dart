import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    final List<String> introTerms = [
      'Al ingresar al Aplicativo Móvil CIP CD LAMBAYEQUE, el Cliente reconoce haber leído, comprendido y aceptado los Términos y Condiciones que a continuación se listan.',
      'La información relacionada al servicio de pago de cotizaciones, certificado de habilidad, certificado de residencia de obra, constancia de no adeudo, eventos y certificados de capacitación y capítulos.',
      'Los Términos y Condiciones se aplican para acceder en línea desde el aplicativo a:',
    ];
    final String subTittle01 = 'I. Condiciones Generales de Uso para Clientes';
    final String subTittle02 = 'II. Consideraciones según dispositivo';
    final String subTittle03 = 'III. Términos y Condiciones Legales';
    final String subTittle04 =
        'IV. Información relacionada a servicios ofrecidos en el aplicativo (móvil - web) CIP CD LAMBAYEQUE';

    final List<String> textsByPoints01 = [
      'La afiliación otorgará una contraseña única e intransferible, la misma que será utilizada por el Cliente para realizar cualquiera de los Servicios desde cualquier dispositivo. La contraseña será requerida cada vez que el Cliente desee realizar el servicio de pago desde el aplicativo móvil.',
      'El acceso al aplicativo móvil implica el consumo de datos, los mismos que serán consumidos de tu plan de datos contratado, salvo que te encuentres en una conexión WIFI.',
      'Si te encuentras en el extranjero y utilizas el aplicativo, estarás realizando consumo de datos de tu plan de datos contratado por lo que se te aplicarán costos de transmisión de datos en Roaming de acuerdo a las tarifas vigentes, te recomendamos utilizar una conexión WIFI para evitar costos adicionales.',
    ];

    final List<String> textByPoint02 = [
      'Los Clientes (Ingenieros Colegiados se registran con su CIP), y los clientes externos se registrarán con su DNI, al Aplicativo (móvil - web) CIP CD LAMBAYEQUE.',
    ];

    final List<String> texsByPoints03 = [
      'En ningún caso EL CIP - CD LAMBAYEQUE proporciona información que identifique a sus clientes, sin previa autorización de éstos, salvo para el estricto y único fin de atenderlos de la mejor forma.',
      'EL CIP - CD LAMBAYEQUE garantiza que los datos ingresados y las transacciones realizadas son seguras y permanecen confidenciales e inalterables gracias al Protocolo de Seguridad SSL.',
      'EL CIP - CD LAMBAYEQUE garantiza que los datos ingresados y las transacciones realizadas son seguras y permanecen confidenciales e inalterables gracias al Protocolo de Seguridad SSL.',
      'El correo electrónico registrado debe ser válido y es de exclusiva responsabilidad del Cliente.',
    ];

    final List<String> textsByPoints0301 = [
      'Las transacciones que realicen los Clientes implican la aceptación plena y sin reservas de éste de todos los términos y condiciones establecidos en el presente documento.',
      'La solicitud y uso de la contraseña para ingresar al Aplicativo (móvil - web) CIP CD LAMBAYEQUE es exclusiva responsabilidad del Cliente. EL CIP CD LAMBAYEQUE queda excluido de cualquier responsabilidad por el uso indebido o cualquier acto que pueda perjudicar al cliente o a un tercero que se vean afectados directa o indirectamente.',
    ];
    final List<String> textsByList0401 = [
      'A través de esta aplicación el Cliente podrá acceder a consultas de estado de cuenta.',
      'La aplicación cuenta con un sistema de contraseña enviado vía correo electrónico, para brindarle mayor seguridad y de esta manera su información estará protegida.',
      'La contraseña podrá ser actualizada solo por voluntad del cliente.',
    ];
    final List<String> textsByList0402 = [
      'Los precios corresponden a los productos/servicios descritos. EL CIP CD LAMBAYEQUE se reserva el derecho de efectuar, en cualquier momento y sin previo aviso, las modificaciones que considere oportunas, pudiendo actualizar, incluso diariamente los precios de los productos y/o servicios.',
      'EL CIP CD LAMBAYEQUE se reserva el derecho de comercializar ofertas exclusivas para los Clientes que adquieran los productos/servicios a través del Aplicativo (móvil - web) CIP CD LAMBAYEQUE.',
    ];
    final List<String> textsByList0403 = [
      'El pago se realizará a través del Aplicativo (móvil - web) CIP CD LAMBAYEQUE con tarjetas de crédito Visa o MasterCard emitidas en el país o internacionales.',
      'No se aceptan como formas de pago los cheques ni el pago en efectivo.',
      'El cliente recibirá un correo electrónico por parte del CIP CD LAMBAYEQUE de CONFIRMACION DE PAGO.',
      'La facturación por el pago de los productos/servicios a través del Aplicativo (móvil - web) CIP CD LAMBAYEQUE, se materializará dentro de un plazo máximo de 48 horas siguientes a la transacción realizada por el cliente.',
    ];
    final List<String> textsByList0404 = [
      'El CIP CD LAMBAYEQUE, no contempla las cancelaciones o devoluciones por los productos y servicios que ofrece mediante este Aplicativo (móvil - web) CIP CD LAMBAYEQUE.',
    ];

    final String introLegalConditions =
        'EL COLEGIO DE INGENIEROS DEL PERU CONSEJO DEPARTAMENTAL DE LAMBAYEQUE (CIP – CD LAMBAYEQUE) garantiza la seguridad y confidencialidad en el tratamiento de los datos de carácter personal facilitados por sus Clientes, de conformidad con la legislación peruana.';
    final String introLegalConditions01 =
        'Cliente: persona natural que requiera realizar a través del aplicativo móvil CIP CD LAMBAYEQUE el servicio de pago de cotizaciones, certificado de habilidad, certificado de residencia de obra, constancia de no adeudo, eventos y certificados de capacitación y capítulos.';

    return SizedBox(
      width: 800,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.0,
        children: [
          SizedBox(height: 10.0),
          Center(
            child: Text(
              "CONDICIONES Y POLÍTICAS DE PRIVACIDAD DEL APLICATIVO (MÓVIL - WEB) CIP CD LAMBAYEQUE",
              style: AppTextStyle(
                context,
              ).bold18(color: AppColors.textBasic(context)),
            ),
          ),
          Text(
            "Ultima actualización 08/08/2024",
            style: AppTextStyle(
              context,
            ).bold14(color: AppColors.textBasic(context)),
          ),
          SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: introTerms.map((e) => _textGeneral(context, e)).toList(),
          ),
          SizedBox(),
          _subTittle(context, subTittle01),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: textsByPoints01
                .map((e) => _textsByPoints(context, e))
                .toList(),
          ),
          SizedBox(height: 10.0),

          _subTittle(context, subTittle02),
          Column(
            children: textByPoint02
                .map((e) => _textGeneral(context, e))
                .toList(),
          ),
          SizedBox(height: 10.0),

          _subTittle(context, subTittle03),
          _textGeneral(context, introLegalConditions),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.0,
            children: texsByPoints03
                .map((e) => _textsByPoints(context, e))
                .toList(),
          ),
          SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Términos y Condiciones Legales",
              style: AppTextStyle(
                context,
              ).bold14(color: AppColors.textBasic(context)),
            ),
          ),
          _textGeneral(context, introLegalConditions01),
          Column(
            spacing: 10.0,
            children: textsByPoints0301
                .map((e) => _textsByPoints(context, e))
                .toList(),
          ),
          SizedBox(height: 10.0),

          _subTittle(context, subTittle04),
          _textByNumber(context, 'Zona consulta de estado de cuenta', false),
          Column(
            spacing: 10,
            children: textsByList0401
                .map((e) => _listedTexts(context, e, false))
                .toList(),
          ),
          _textByNumber(
            context,
            '2. Servicios de pago para cursos de actualización profesional',
            false,
          ),
          _textByNumber(context, '2.1. Precios', true),
          Column(
            spacing: 10,
            children: textsByList0402
                .map((e) => _listedTexts(context, e, true))
                .toList(),
          ),
          
          _textByNumber(
            context,
            '2.2. Forma de pago de los productos/servicios a través del Aplicativo (móvil - web) CIP CD LAMBAYEQUE',
            true,
          ),
          Column(
            spacing: 10.0,
            children: textsByList0403.map((e)=> _listedTexts(context,e,true),).toList()),
          
          _textByNumber(context, '2.3. Cancelaciones o devoluciones', true),
          Column(
            spacing: 10,
            children: textsByList0404.map((e) => _listedTexts(context,e,true),).toList()),
          
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

Widget _subTittle(BuildContext context, String text) {
  return Text(
    text,
    style: AppTextStyle(context).bold17(color: AppColors.textBasic(context)),
  );
}

Widget _textByNumber(BuildContext context, String text, bool isSubtittle) {
  return Padding(
    padding: EdgeInsets.only(left: isSubtittle ? 25.0 : 15.0),
    child: Text(
      text,
      style: AppTextStyle(context).bold14(color: AppColors.textBasic(context)),
    ),
  );
}

Widget _textGeneral(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0),
    child: Text(
      text,
      style: AppTextStyle(
        context,
      ).textGeneralTerms(color: AppColors.textBasic(context)),
    ),
  );
}

Widget _textsByPoints(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 25.0),
    child: Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Icon(
            Icons.circle,
            color: AppColors.textTittleContent(context),
            size: 6,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle(
              context,
            ).textGeneralTerms(color: AppColors.textBasic(context)),
          ),
        ),
      ],
    ),
  );
}

Widget _listedTexts(BuildContext context, String text, bool isSub) {
  return Padding(
    padding: EdgeInsets.only(left: isSub ? 30.0 : 25.0),
    child: Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Icon(
            Bootstrap.dash,
            color: AppColors.textTittleContent(context),
            size: 8,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle(
              context,
            ).textGeneralTerms(color: AppColors.textBasic(context)),
          ),
        ),
      ],
    ),
  );
}
