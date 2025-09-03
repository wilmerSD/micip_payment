import 'package:cip_payment_web/app/ui/views/home/footer/footer_desktop.dart';
import 'package:flutter/material.dart';

class FooterTablet extends StatelessWidget {
  const FooterTablet({super.key});

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
              Expanded(flex: 2, child: contact()),
              // Enlaces
              Expanded(
                flex: 1,
                child: Container(
                  // padding: const EdgeInsets.only(left: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customLinks(context),
                      // Redes socialesß
                      const SizedBox(height: 24),
                      Column(
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
                    ],
                  ),
                ),
              ),
            ],
          ),

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
