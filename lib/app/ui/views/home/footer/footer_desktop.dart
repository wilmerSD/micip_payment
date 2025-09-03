import 'package:cip_payment_web/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_web/app/ui/components/terms_and_conditions.dart';
import 'package:cip_payment_web/app/ui/views/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class FooterDesktop extends StatelessWidget {
  const FooterDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFFB71C1C), Color(0xFFD32F2F)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Primera fila: columnas principales
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contacto
              Expanded(
                // flex: 2,
                child: contact(),
              ),
              // Enlaces
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: customLinks(context),
                ),
              ),
              // Redes sociales
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Redes sociales",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 16),
                      socialMediaGen(context, () {}),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Línea divisoria
          const Divider(color: Colors.white54, thickness: 1),
          const SizedBox(height: 8),
          // Derechos reservados
          Row(
            children: [
              Expanded(child: Container()),
              Text(
                "©2025 Todos los derechos reservados: ",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              GestureDetector(
                onTap: () {
                  // Acción al hacer click
                },
                child: const Text(
                  "CIP CDL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget socialMedia(BuildContext context, IconData icon, Function() ontap) {
  return IconButton(
    onPressed: ontap,
    icon: Icon(icon, color: Colors.white, size: 28),
  );
}

Widget socialMediaGen(BuildContext context, Function ontap) {
  final homeProvider = Provider.of<HomeProvider>(context);
  return Row(
    spacing: 12.0,
    children: [
      socialMedia(context, Bootstrap.whatsapp, () {
        homeProvider.launchUrlProv(homeProvider.urlWhatsaap);
      }),
      socialMedia(context, Bootstrap.facebook, () {
        homeProvider.launchUrlProv(homeProvider.urlFaceboook);
      }),
      socialMedia(context, Bootstrap.instagram, () {
        homeProvider.launchUrlProv(homeProvider.urlInstagram);
      }),
      socialMedia(context, Bootstrap.youtube, () {
        homeProvider.launchUrlProv(homeProvider.urlYoutube);
      }),
      socialMedia(context, Bootstrap.linkedin, () {
        homeProvider.launchUrlProv(homeProvider.urlLinkedin);
      }),
    ],
  );
}

Widget contact() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Contacto",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      const SizedBox(height: 16),
      // Dirección
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.location_on, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dirección:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Av. Balta N°581 – Chiclayo",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 12),
      // Correo Electrónico
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.email, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Correo Electrónico:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "• Informes@ciplambayeque.com",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "• Colegiaturacip@ciplambayeque.com",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 12),
      // Teléfono
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.phone, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Teléfono de mesa de Partes:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Celular: (+51) 996947998",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget customLinks(BuildContext context) {
  final homeProvider = Provider.of<HomeProvider>(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Enlaces",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      SizedBox(height: 16),
      Row(
        children: [
          Icon(Icons.description, color: Colors.white, size: 18),
          SizedBox(width: 8),
          InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return PopupGeneral(
                  scrollable: true,
                  onTapButton: () => {},
                  title: "",
                  content: TermsAndConditions(),
                );
              },
            ),
            child: Text(
              "Terminos y condiciones",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      SizedBox(height: 8.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.0,
        children: [
          InkWell(
            onTap: () => homeProvider.launchUrlProv(homeProvider.urlComplaintsBook),
            child: Row(
              spacing: 8.0,
              children: [
                Icon(Icons.receipt_long, color: Colors.white, size: 18),
                Text(
                    "Libro de reclamaciones",
                    style: TextStyle(color: Colors.white),
                  ),
              ],
            ),
          ),
          InkWell(
            onTap: () => homeProvider.launchUrlProv(homeProvider.urlComplaintsBook),
            child: Image.asset(
              height: 110,
              width: 80.0,
              'assets/libroReclamaciones.webp'),
          )
        ],
      ),
    ],
  );
}
