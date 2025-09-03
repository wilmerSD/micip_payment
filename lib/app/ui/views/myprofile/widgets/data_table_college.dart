import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DataTableCollege extends StatelessWidget {
  const DataTableCollege({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 300,
      headingRowHeight: 56,
      headingRowColor: WidgetStateProperty.all(AppColors.granateConst),
      headingTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      border: TableBorder(
        horizontalInside: BorderSide(color: Colors.grey.shade300),
      ),
      columns: const [
        DataColumn2(
          label: Text('Capítulo'),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text('Especialidad'),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text('Estado'),
          size: ColumnSize.S,
        ),
      ],
      rows: const [
        DataRow(
          cells: [
            DataCell(Text('Civil')),
            DataCell(Text('Civil')),
            DataCell(Text('Perteneciente')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Industrial ...')),
            DataCell(Text('Informática y de...')),
            DataCell(Text('-')),
          ],
        ),
      ],
    );
  }
}
