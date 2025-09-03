import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
const TermsAndConditions({ super.key });

  @override
  Widget build(BuildContext context){
    final generalConditions =
        '* La afiliación otorgará una contraseña única e intransferible, la misma que será utilizada por el Cliente para realizar cualquiera de los Servicios desde cualquier dispositivo. La contraseña será requerida cada vez que el Cliente desee realizar el servicio de pago desde el aplicativo móvil\n* El acceso al aplicativo móvil implica el consumo de datos, los mismos que serán consumidos de tu plan de datos contratado, salvo que te encuentres en una conexión WIFI.\n* Si te encuentras en el extranjero y utilizas el aplicativo, estarás realizando consumo de datos de tu plan de datos contratado por lo que se te aplicarán costos de transmisión de datos en Roaming de acuerdo a las tarifas vigentes, te recomendamos utilizar una conexión WIFI para evitar costos adicionales.';
    final legalConditions =
        'EL COLEGIO DE INGENIEROS DEL PERU CONSEJO DEPARTAMENTAL DE LAMBAYEQUE (CIP – CD LAMBAYEQUE) garantiza la seguridad y confidencialidad en el tratamiento de los datos de carácter personal facilitados por sus Clientes, de conformidad con la legislación peruana.\n';
    return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10.0,
                      children: [
                        Center(
                          child: Text(
                            "CONDICIONES Y POLÍTICAS DE PRIVACIDAD DEL APLICATIVO (MÓVIL - WEB) CIP CD LAMBAYEQUE",
                            style: AppTextStyle(context).bold18(),
                          ),
                        ),
                        const Text("Ultima actualización 08/08/2024"),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: '',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                            'Al ingresar al Aplicativo Móvil CIP CD LAMBAYEQUE, el Cliente reconoce haber leído, comprendido y aceptado los Términos y Condiciones que a continuación se listan.'),
                        const Text(
                            'La información relacionada al servicio de pago de cotizaciones, certificado de habilidad, certificado de residencia de obra, constancia de no adeudo, eventos y certificados de capacitación y capítulos.'),
                        const Text(
                            'Los Términos y Condiciones se aplican para acceder en línea desde el aplicativo a:'),
                        Text(
                          'I. Condiciones Generales de Uso para Clientes',
                          style: AppTextStyle(context).bold17(),
                        ),
                        Text(generalConditions),
                        Text('II. Consideraciones según dispositivo',
                            style: AppTextStyle(context).bold17()),
                        const Text(
                            'Los Clientes (Ingenieros Colegiados se registran con su CIP), y los clientes externos se registrarán con su DNI, al Aplicativo (móvil - web) CIP CD LAMBAYEQUE.'),
                        Text('III. Términos y Condiciones Legales',
                            style: AppTextStyle(context).bold17()),
                        Text(
                            '* EL COLEGIO DE INGENIEROS DEL PERU CONSEJO DEPARTAMENTAL DE LAMBAYEQUE (CIP – CD LAMBAYEQUE) garantiza la seguridad y confidencialidad en el tratamiento de los datos de carácter personal facilitados por sus Clientes, de conformidad con la legislación peruana.'),
                        Text(
                            '* En ningún caso EL CIP - CD LAMBAYEQUE proporciona información que identifique a sus clientes, sin previa autorización de éstos, salvo para el estricto y único fin de atenderlos de la mejor forma.'),
                        Text(
                            '* EL CIP - CD LAMBAYEQUE garantiza que los datos ingresados y las transacciones realizadas son seguras y permanecen confidenciales e inalterables gracias al Protocolo de Seguridad SSL.'),
                        Text(
                            '* EL CIP - CD LAMBAYEQUE garantiza que los datos ingresados y las transacciones realizadas son seguras y permanecen confidenciales e inalterables gracias al Protocolo de Seguridad SSL.'),
                        Text(
                            '* El correo electrónico registrado debe ser válido y es de exclusiva responsabilidad del Cliente.'),
                        Text('  Términos y Condiciones Legales',
                            style: AppTextStyle(context).bold14()),
                        Text(
                            '  Cliente: persona natural que requiera realizar a través del aplicativo móvil CIP CD LAMBAYEQUE el servicio de pago de cotizaciones, certificado de habilidad, certificado de residencia de obra, constancia de no adeudo, eventos y certificados de capacitación y capítulos.'),
                        Text(
                            '    * Las transacciones que realicen los Clientes implican la aceptación plena y sin reservas de éste de todos los términos y condiciones establecidos en el presente documento.'),
                        Text(
                            '    * La solicitud y uso de la contraseña para ingresar al Aplicativo (móvil - web) CIP CD LAMBAYEQUE es exclusiva responsabilidad del Cliente. EL CIP CD LAMBAYEQUE queda excluido de cualquier responsabilidad por el uso indebido o cualquier acto que pueda perjudicar al cliente o a un tercero que se vean afectados directa o indirectamente.'),
                        Text(
                            'IV. Información relacionada a servicios ofrecidos en el aplicativo (móvil - web) CIP CD LAMBAYEQUE',
                            style: AppTextStyle(context).bold17()),
                        Text('1. Zona consulta de Estado de cuenta'),
                        Text(
                            '- A través de esta aplicación el Cliente podrá acceder a consultas de estado de cuenta.'),
                        Text(
                            '- La aplicación cuenta con un sistema de contraseña enviado vía correo electrónico, para brindarle mayor seguridad y de esta manera su información estará protegida.'),
                        Text(
                            '- La contraseña podrá ser actualizada solo por voluntad del cliente.'),
                        Text(
                            '2. Servicios de pago para cursos de actualización profesional'),
                        Text('2.1. Precios'),
                        Text(
                            '- Los precios corresponden a los productos/servicios descritos. EL CIP CD LAMBAYEQUE se reserva el derecho de efectuar, en cualquier momento y sin previo aviso, las modificaciones que considere oportunas, pudiendo actualizar, incluso diariamente los precios de los productos y/o servicios.'),
                        Text(
                            '- EL CIP CD LAMBAYEQUE se reserva el derecho de comercializar ofertas exclusivas para los Clientes que adquieran los productos/servicios a través del Aplicativo (móvil - web) CIP CD LAMBAYEQUE.'),
                        Text(
                            '2.2. Forma de pago de los productos/servicios a través del Aplicativo (móvil - web) CIP CD LAMBAYEQUE'),
                        Text(
                            '- El pago se realizará a través del Aplicativo (móvil - web) CIP CD LAMBAYEQUE con tarjetas de crédito Visa o MasterCard emitidas en el país o internacionales.'),
                        Text(
                            '- No se aceptan como formas de pago los cheques ni el pago en efectivo.'),
                        Text(
                            '- El cliente recibirá un correo electrónico por parte del CIP CD LAMBAYEQUE de CONFIRMACION DE PAGO.'),
                        Text(
                            '- la facturación por el pago de los productos/servicios a través del Aplicativo (móvil - web) CIP CD LAMBAYEQUE, se materializará dentro de un plazo máximo de 48 horas siguientes a la transacción realizada por el cliente.'),
                        Text('2.3. Cancelaciones o devoluciones'),
                        Text(
                            '- El CIP CD LAMBAYEQUE, no contempla las cancelaciones o devoluciones por los productos y servicios que ofrece mediante este Aplicativo (móvil - web) CIP CD LAMBAYEQUE.')
                      ],
                    ),
                  );
  }
}