import 'package:cip_payment_web/app/ui/views/advancepayment/advancepayment_view.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/certificateskill_view.dart';
import 'package:cip_payment_web/app/ui/views/home/home_view.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_view.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/proofnodebt_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeProvider with ChangeNotifier {

 

  final Uri urlFaceboook = Uri.parse('https://www.facebook.com/cipcdlambayeque');
  final Uri urlInstagram = Uri.parse("https://www.instagram.com/cipcdlambayeque/#");
  final Uri urlYoutube = Uri.parse("https://www.youtube.com/channel/UCaY7W2Q0eD8flbcgjTxfwFA");
  final Uri urlX = Uri.parse("https://www.youtube.com/channel/UCaY7W2Q0eD8flbcgjTxfwFA");
  final Uri urlLinkedin = Uri.parse("https://www.linkedin.com/in/sistemascipcdl/");
  final Uri urlWhatsaap = Uri.parse("https://www.whatsapp.com/channel/0029VaIplD4CcW4jYC3Mps0s");
  final Uri urlComplaintsBook = Uri.parse("https://www.cip.org.pe/libro-de-reclamaciones/");
  
  Future<void> launchUrlProv(Uri link) async {
  if (!await launchUrl(link)) {
    throw Exception('Could not launch $link');
  }
}
}