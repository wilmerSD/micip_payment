import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PaymentData {
  final String label;
  final double value;
  final Color color;
  PaymentData(this.label, this.value, this.color);
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PaymentData> data = [
      PaymentData('A', 70, Color(0xFF00C48C)), // verde
      PaymentData('B', 50, Color(0xFFFF647C)), // rojo
      PaymentData('C', 60, Color(0xFFB0A9C1)), // gris
      PaymentData('D', 40, Color(0xFFFFA800)), // naranja
      PaymentData('E', 80, Color(0xFFD72660)), // fucsia
      PaymentData('F', 90, Color(0xFFB5B867)), // verde oliva
      PaymentData('G', 100, Color(0xFF5B8CFF)), // azul
      PaymentData('H', 60, Color(0xFF222222)), // negro
    ];

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total de pagos - periodo ENERO',
            style: TextStyle(
              color: Color(0xFFB0A9C1),
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '124',
            style: TextStyle(
              color: Color(0xFF002147),
              fontSize: 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                axisLine: const AxisLine(width: 0),
                labelStyle: TextStyle(fontSize: 0), // Oculta etiquetas
              ),
              primaryYAxis: NumericAxis(
                isVisible: false,
                minimum: 0,
                maximum: 100,
              ),
              series: <CartesianSeries>[
                ColumnSeries<PaymentData, String>(
                  dataSource: data,
                  xValueMapper: (PaymentData pd, _) => pd.label,
                  yValueMapper: (PaymentData pd, _) => pd.value,
                  pointColorMapper: (PaymentData pd, _) => pd.color.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30),
                  width: 0.5,
                  spacing: 0.2,
                  dataLabelSettings: DataLabelSettings(isVisible: false),
                  trackColor: Color(0xFFF8F4EA),
                  isTrackVisible: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: data.map((d) => Column(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: d.color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 4),
              ],
            )).toList(),
          ),
        ],
      ),
    );
  }
}