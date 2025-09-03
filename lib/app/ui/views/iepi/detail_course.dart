import 'package:cip_payment_web/app/ui/components/button/btn_primary_ink.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class DetailCourse extends StatelessWidget {
  const DetailCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Detalles',
          style: AppTextStyle(context).bold17(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_sharp, color: Colors.black),
            onPressed: () {
              // TODO: open WhatsApp chat
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner image
            Container(
              height: 140,
              color: Colors.grey[200],
              child: Image.network(
                'https://picsum.photos/id/237/800/400',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            // Docente and pricing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'DOCENTE: Ing. Alfonso Zapata',
              ),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                decoration: BoxDecoration(
                  color: AppColors.secondary(context),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  'Colegiado Hábil: S/.80   |   No hábil: S/.100   |   Público: S/.130',
                ),
              ),
            ),
            const SizedBox(height: 14),
            // Course title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'METRADOS Y CÁLCUL DE MATERIALES DE CONSTRUCCIÓN',
                style: AppTextStyle(context).bold14(),
              ),
            ),
            const SizedBox(height: 10),
            // Info chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: const [
                  _InfoChip(
                      label: 'Tipo: Curso de Especialidad', icon: Icons.school),
                  _InfoChip(
                      label: 'Inicia: 14/05/2025', icon: Icons.calendar_today),
                  _InfoChip(label: 'Modalidad: Virtual', icon: Icons.computer),
                  _InfoChip(label: 'Organiza: CAPACITACION', icon: Icons.group),
                ],
              ),
            ),
            const SizedBox(height: 22),
            // Tabs
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TabBar(
                      labelColor: AppColors.granateConst,
                      unselectedLabelColor: Colors.black54,
                      indicatorColor: AppColors.granateConst,
                      indicatorWeight: 2,
                      tabs: const [
                        Tab(text: 'Horarios'),
                        Tab(text: 'Costos'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tab views
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height: 200,
                      child: TabBarView(
                        children: [
                          // Horarios view
                          Column(
                            children: [
                              // Header row
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.granateConst,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Día',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle(context)
                                            .bold14(color: Colors.white),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Hora',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle(context)
                                            .bold14(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Rows
                              const Divider(height: 1),
                              const _ScheduleRow(
                                  day: 'Viernes', hour: '19:00 - 22:00'),
                              const Divider(height: 1),
                              const _ScheduleRow(
                                  day: 'Miércoles', hour: '19:00 - 22:00'),
                              const Divider(height: 1),
                            ],
                          ),
                          // Costos placeholder
                          Center(
                            child: Text(
                              'Detalles de costos aquí',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // ...existing code...
          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: BtnPrimaryInk(
            text: 'Matricularme',
            onTap: () {
            },
          )
          ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _InfoChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 253, 187, 187),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textBasic(context)),
          const SizedBox(width: 4),
          Text(
            label,
          ),
        ],
      ),
    );
  }
}

class _ScheduleRow extends StatelessWidget {
  final String day;
  final String hour;
  const _ScheduleRow({required this.day, required this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              day,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              hour,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
