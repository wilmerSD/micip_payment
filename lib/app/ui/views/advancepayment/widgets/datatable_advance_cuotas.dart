import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DatatableAdvanceCuotas extends StatelessWidget {
  const DatatableAdvanceCuotas({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 300,
      headingRowHeight: 56,
      headingRowColor: MaterialStateProperty.all(const Color(0xFF7A0C0C)), // Color granate
      headingTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      border: TableBorder(
        horizontalInside: BorderSide(color: Colors.grey.shade300),
      ),
      columns: const [
        DataColumn2(
          label: Text('#'),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text('Categoria'),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text('Cuota'),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text('Importe'),
          size: ColumnSize.S,
        ),
      ],
      rows: const [
        DataRow(
          cells: [
            DataCell(Text('1')),
            DataCell(Text('Ordinario')),
            DataCell(Text('septiembre - 2025')),
            DataCell(Text('S/. 20')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('2')),
            DataCell(Text('Ordinario')),
            DataCell(Text('Octubre - 2025')),
            DataCell(Text('S/. 20')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('3')),
            DataCell(Text('Ordinario')),
            DataCell(Text('Noviembre - 2025')),
            DataCell(Text('S/. 20')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('4')),
            DataCell(Text('Ordinario')),
            DataCell(Text('Diciembre - 2025')),
            DataCell(Text('S/. 20')),
          ],
        ),
      ],
    );
  }
}
