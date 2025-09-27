import 'package:flutter/material.dart';

class AppColors {
  //General
  static Color backgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(28, 28, 28, 1) //dark
        : const Color.fromRGBO(255, 255, 255, 1); //light
  }
  

  static Color cardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(58, 58, 62, 1) //dark
        : const Color.fromRGBO(255, 255, 255, 1); //light
  }

  static Color primary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(227, 30, 36, 1) //dark
        : const Color.fromRGBO(227, 30, 36, 1); //light
  }

  static Color secondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(215, 181, 109, 1) //dark
        : const Color.fromRGBO(215, 181, 109, 1); //light
  }

  static Color textQuaternaryBasic(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(230, 230, 230, 1) //dark
        : const Color.fromRGBO(109, 108, 108, 1); //light
  } 

  static Color headerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(28, 28, 28, 1) //dark
        : const Color.fromRGBO(255, 255, 255, 1); //light
  }

  static Color shadowAppBarColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(70, 70, 70, 1) //dark
        :const Color.fromRGBO(239, 239, 239, 1); //light
  }

  static Color popUpColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(66, 66, 66, 1) //dark
        : const Color.fromRGBO(255, 255, 255, 1); //light
  }

  static Color drawerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(84, 18, 20, 1) //dark
        : const Color.fromRGBO(205, 46, 46, 1); //light
  }

  static Color rowTableFirstColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(61, 61, 61, 1) //dark
        : const Color.fromRGBO(255, 255, 255, 1); //light
  }

  static Color rowTableSecColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(79, 79, 79, 1) //dark
        : const Color.fromRGBO(247, 247, 247, 1); //light
  }
  //Textos

  static Color textBasic(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 253, 253, 253) //dark
        : const Color.fromARGB(255, 0, 0, 0); //light
  }

  static Color textTittleContent(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromARGB(255, 253, 253, 253) //dark
        : const Color.fromRGBO(102, 94, 94, 1); //light
  }

    static Color textCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(255, 255, 255, 1) //dark
        : const Color.fromRGBO(28, 28, 28, 1); //light
  }

  static Color textTittleAlert(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(255, 216, 214, 1) //dark
        : const Color.fromARGB(27, 21, 61, 1); //light
  }
  static Color fillTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color.fromRGBO(113, 113, 113, 1) //dark
        : const Color.fromRGBO(246, 247, 249, 1); //light
  }
  
  //Colores constantes
  static const Color primaryConst = Color.fromRGBO(227, 30, 36, 1);
  // static const Color drawerColor = Color.fromRGBO(205, 46, 46, 1);
  static const Color secondConst = Color.fromRGBO(215, 181, 109, 1);
  static const Color thirdConst = Color.fromRGBO(42, 42, 41, 1);
  static const Color quaternaryConst = Color.fromRGBO(109, 108, 108, 1);
  static const Color granateConst = Color.fromRGBO(108, 14, 16, 1);
  static const Color textDataTableBasic = Color.fromRGBO(36, 36, 36, 1);
  static const Color inputcolors = Color.fromRGBO(99, 99, 105, 1.0);
  
  static const Color warningColor = Color.fromRGBO(242, 140, 3, 1.0);
  static const Color red = Color.fromRGBO(231, 44, 49, 1.0);
  static const Color orange = Color.fromRGBO(242, 140, 3, 1.0);
  static const Color grayLight = Color.fromRGBO(230, 230, 241, 1);
  static const Color grayBlue = Color.fromRGBO(125, 126, 138, 1);
  static const Color radiusMap = Color.fromRGBO(38, 52, 113, 0.219);
  static const Color grey = Color.fromRGBO(71, 71, 73, 1);
  static const Color blueRecoverPass = Color.fromRGBO(0, 85, 184, 1);
  static const Color grayMiddle = Color.fromRGBO(147, 147, 178, 1);
  static const Color grayDesactivate = Color.fromRGBO(135, 135, 135, 1);
  //----------------------------------------------------------------
  static const Color validationTimely = Color.fromRGBO(0, 196, 140, 1);
  static const Color validationMissing = Color.fromRGBO(231, 44, 49, 1);
  static const Color validationLate = Color.fromRGBO(239, 202, 102, 1);
  static const Color validationJustified = Color.fromRGBO(242, 140, 3, 1);

  static const Color stateActive = Color.fromRGBO(0, 188, 75, 1);
  static const Color stateInactive = Color.fromRGBO(255, 60, 49, 1);

  //----------------------------------------------------------------
  static const Color degradedInitial = Color.fromARGB(255, 247, 85, 45);
  static const Color shadowButton = Color.fromARGB(137, 71, 70, 70);
  static const Color logoBad = Color.fromARGB(255, 244, 55, 22);
  static const Color logoRight = Color.fromARGB(255, 76, 201, 170);
  static const Color degradedStart = Color.fromRGBO(237, 128, 26, 1);
  static const Color blueDark = Color.fromRGBO(38, 52, 113, 1);
  static const Color modalBarrier = Color.fromARGB(33, 87, 85, 85);
  static const Color contentNotification = Color.fromRGBO(247, 248, 253, 1);
  static const Color redLoading = Color.fromRGBO(230, 0, 0, 0.8);
  static const Color black = Color.fromRGBO(27, 21, 61, 1.0);

  static const Color grayDark = Color.fromRGBO(47, 46, 65, 1);
  static const Color light = Color.fromRGBO(239, 239, 239, 1.0);
  static const Color green = Color.fromRGBO(76, 175, 80, 1);
  static const Color yellow = Color.fromRGBO(255, 235, 59, 1);
  //-----------
  static const Color purpleCustom = Color.fromRGBO(53, 43, 200, 1);
  static const Color blueCustom = Color.fromRGBO(47, 119, 234, 1);

  static const Color borderForm = Color.fromRGBO(230, 230, 241, 1);

  static const Color green02 = Color.fromRGBO(0, 166, 90, 1);
  static const Color green03 = Color.fromRGBO(0, 166, 90, 0.65);
  static const Color orangeCustom = Color.fromRGBO(221, 75, 57, 1);
  static const Color purpleCustomLoading = Color.fromRGBO(53, 43, 200, 0.8);
  static const Color blueCustomLoading = Color.fromRGBO(47, 119, 234, 0.8);
  static const Color giftColor = Color.fromRGBO(223, 240, 216, 1.0);
  static const Color noConectionColor = Color.fromRGBO(246, 185, 278, 1.0);

  static const Color graySchedule = Color.fromARGB(255, 243, 243, 243);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      primaryConst,
      primaryConst,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient coursesGradient = LinearGradient(
    colors: [
      primaryConst,
      Color.fromRGBO(125, 17, 20, 1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  //---
  static const LinearGradient primaryGradientLoading = LinearGradient(
    colors: [
      redLoading,
      redLoading,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradientLoading = LinearGradient(
      colors: [green03, green03],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  //----------------------------------------------------------------
  static const String mapStyles = '''[
    {
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#f5f5f5"
        }
      ]
    },
    {
      "elementType": "labels.icon",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#616161"
        }
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#f5f5f5"
        }
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#bdbdbd"
        }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#eeeeee"
        }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#e5e5e5"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#9e9e9e"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#ffffff"
        }
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#dadada"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#616161"
        }
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#9e9e9e"
        }
      ]
    },
    {
      "featureType": "transit.line",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#e5e5e5"
        }
      ]
    },
    {
      "featureType": "transit.station",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#eeeeee"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#c9c9c9"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#9e9e9e"
        }
      ]
    }
  ]''';
}
