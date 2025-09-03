import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T) getLabel; // Función para extraer el texto a mostrar

  const CustomDropdownButton({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.getLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayLight, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: DropdownButton<T>(
        padding: const EdgeInsets.only(left: 10.0),
        // isDense: true,
        menuWidth: 180,
        // menuMaxHeight: 350.0,
        borderRadius: BorderRadius.circular(4.0),
        isExpanded: true,
        dropdownColor: const Color.fromARGB(255, 247, 247, 247),
        value: value,
        icon: Row(
          children: [
            Icon(Bootstrap.chevron_down, color: AppColors.primary(context)),
            const SizedBox(
              width: 12.0,
            ),
          ],
        ),
        iconSize: 23.0,
        elevation: 10,
        style: AppTextStyle(context).bold13(color: AppColors.textBasic(context)),
        underline: Container(
          height: 0,
          color: AppColors.grayBlue,
        ),
        onChanged: onChanged,
         items: items.map<DropdownMenuItem<T>>((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(getLabel(item), maxLines: 2,overflow: TextOverflow.ellipsis,), // Extrae el texto dinámicamente
        );
      }).toList(),
      ),
    );
  }
}
