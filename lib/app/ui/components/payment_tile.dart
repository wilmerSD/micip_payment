import 'package:cip_payment_web/app/ui/components/payment/popup_download_option.dart';
import 'package:cip_payment_web/core/theme/app_colors.dart';
import 'package:cip_payment_web/core/theme/app_text_style.dart';
import 'package:cip_payment_web/domain/entities/speciality.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class PaymentTile extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback ontap;
  final String textSecond;
  final String textThird;
  final bool popup;
  final String? receiptNumber;
  final String? date;
  final String? name;
  final String? dni;
  final double? subtotal;
  final String? typePay;
  final Speciality? speciality;
  final String? enabledUntil;

  const PaymentTile(
    this.title,
    this.text,
    this.ontap,
    this.textSecond,
    this.textThird,
    this.popup, {
    super.key,
    this.receiptNumber,
    this.date,
    this.name,
    this.dni,
    this.subtotal,
    this.speciality,
    this.typePay,
    this.enabledUntil,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' $title',
          style: AppTextStyle(context).bold16(
              fontWeight: FontWeight.w500, color: AppColors.textBasic(context)),
        ),
        Container(
          // height: 70.0,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(92, 249, 249, 250),
              border:
                  Border.all(color: const Color.fromRGBO(232, 242, 250, 1))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text,
                        style: AppTextStyle(context).bold15(
                            fontWeight: FontWeight.w300,
                            color: AppColors.textBasic(context)),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        height: 15.0,
                        width: 1.0,
                        color: AppColors.grayBlue,
                      ),
                      Text(textSecond,
                          style: AppTextStyle(context).bold15(
                              fontWeight: FontWeight.w300,
                              color: AppColors.textBasic(context))),
                    ],
                  ),
                  Text(textThird,
                      style: AppTextStyle(context).bold15(
                          fontWeight: FontWeight.w300,
                          color: AppColors.textBasic(context)))
                ],
              ),
              popup
                  ? PopupDownloadOption(receiptNumber ?? '', date ?? '',
                      name ?? '', dni ?? '', subtotal ?? 0, typePay ?? '', speciality, enabledUntil)
                  : IconButton(
                      onPressed: ontap,
                      icon: const Icon(
                        Bootstrap.download,
                        color: AppColors.secondConst,
                      ),
                    )
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}
