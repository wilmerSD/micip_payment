import 'dart:async';
import 'package:cip_payment_web/app/models/response_menu_model.dart';
import 'package:cip_payment_web/app/ui/views/dashboard/dashboard_view.dart';
import 'package:cip_payment_web/app/ui/views/layout/routeDataTemporary.dart';
import 'package:cip_payment_web/app/ui/views/layout/widgets/page_found.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/courses/course_view.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/historypay/payment_history_view.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/manage_quota_view.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/person/person_view.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/myprofile_view.dart';
import 'package:cip_payment_web/core/helpers/keys.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';


class LayoutProvider with ChangeNotifier {
  //INSTANCES
  FocusNode focusNode = FocusNode();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  //VARIABLES
  List<ResponseMenuOptionsModel> options = [];
  String menuRouteName = '';
  bool isCollapsed = false;
  bool isShowDownAvatar = false;
  Timer? timer;
  Timer? timerToExpire;
  bool isLogOut = false;
  int minutesSesion = 720;
  String roleUser = '0';
  String nameUser = "Hola que talco";
  // String nameRolUser = "";
  ValueNotifier<String> nameRolUser = ValueNotifier("Gerente");

  //FUNCTIONS
  /* 📌 Para inicializar funciones */
  Future<void> initialize(BuildContext context) async {
    await load(context);
    await _getinformationUser();
  }

  /* 📌 Para obtener el rol del usuario y segun ello ocultar vistas (provisional) */
  Future<void> _getinformationUser() async {
    try {
      roleUser = await secureStorage.read(key: Keys.kIdRole) ?? '';
      nameUser = await secureStorage.read(key: Keys.kNameUser) ?? '';
      nameRolUser.value = await secureStorage.read(key: Keys.kIdRole) ?? '';

      // nameRolUser = await secureStorage.read(key: Keys.kIdRole) ?? '';
      // nameRolUser = SesionDataTemporary.data["nameRol"];
    } catch (e) {}
  }

  /* 📌  */
  Future<void> listenRoute() async {
    int count = 0;
    
    //   web.window.onHashChange.listen((event) {
    //   count++;
    //   final route = "/${web.window.location.hash}";
    //   if (count == 1) {
    //     String myroute = validateRoute(route);
    //     RouteDataTemporary.currentRoute = myroute;
    //     setActive(myroute);
    //     Future.delayed(const Duration(milliseconds: 1300), () {
    //       web.window.history.pushState(null, '', myroute);
    //       count = 0;
    //     });
    //   }
    // });
  }

  /* 📌 Seguridad - Validar rutas */
  String validateRoute(String myroute, BuildContext context) {
    String resultRoute = AppRoutesName.UNKNOW;
    switch (myroute) {
      //HOME
      case AppRoutesName.DASHBOARD:
        resultRoute = AppRoutesName.DASHBOARD;
        context.go(AppRoutesName.DASHBOARD);
        break;

      //SEGURIDAD
      case AppRoutesName.PROFILE:
        resultRoute = AppRoutesName.PROFILE;
        context.go(AppRoutesName.PROFILE);
        break;

      default:
    }
    return resultRoute;
  }

  /* 📌 Drawer con items y subItems */
  Future<void> load(BuildContext context) async {
    options = [
      //HOME
      ResponseMenuOptionsModel(        
        route: AppRoutesName.DASHBOARD,
        nameOption: "Inicio",
        iconOption:
            const Icon(Iconsax.home_outline, color: Colors.white, size: 20),
        isDesplegable: false,
        isActive: true,
        isDesplegated: false,
        isChild: false,
      ),

      //MI PERFIL
      ResponseMenuOptionsModel(
        route: AppRoutesName.PROFILE,
        nameOption: "Mis datos",
        iconOption: const Icon(Iconsax.profile_circle_outline,
            color: Colors.white, size: 20.0),
        isDesplegable: false,
        isActive: false,
        isDesplegated: false,
        isChild: false,
      ),

      //SEGURIDAD
      ResponseMenuOptionsModel(
          route: "/seguridad",
          nameOption: "Seguridad",
          iconOption: const Icon(Icons.security, color: Colors.white, size: 20),
          isDesplegable: true,
          isActive: false,
          isDesplegated: false,
          isChild: false,
          child: [
            ResponseMenuOptionsModel(
                isObscure: false,
                route: AppRoutesName.PERSON,
                nameOption: "Colegiados",
                iconOption: const CircleSubItem(),
                isDesplegable: false,
                isActive: false,
                isDesplegated: false,
                isChild: true),
          ].where((element) => !element.isObscure!).toList()),

      //MANTENEDORES
      ResponseMenuOptionsModel(
          isObscure: false,
          route: "/mantenedores",
          nameOption: "Mantenedores",
          iconOption:
              const Icon(Iconsax.receipt_square_outline,
                  color: Colors.white, size: 20),
          isDesplegable: true,
          isActive: false,
          isDesplegated: false,
          isChild: false,
          child: [
            ResponseMenuOptionsModel(
                isObscure: false,
                route: AppRoutesName.COURSES,
                nameOption: "Cursos",
                iconOption: const CircleSubItem(),
                isDesplegable: false,
                isActive: false,
                isDesplegated: false,
                isChild: true),
            ResponseMenuOptionsModel(
                isObscure: false,
                route: AppRoutesName.MANAGEQUOTA,
                nameOption: "Administrar Cuotas",
                iconOption: const CircleSubItem(),
                isDesplegable: false,
                isActive: false,
                isDesplegated: false,
                isChild: true),
          ].where((element) => !element.isObscure!).toList()),

      //REPORTES
      ResponseMenuOptionsModel(
          isObscure: roleUser == '1',
          route: "/reportes",
          nameOption: "Reportes",
          iconOption:
              const Icon(Iconsax.presention_chart_outline,
                  color: Colors.white, size: 20),
          isDesplegable: true,
          isActive: false,
          isDesplegated: false,
          isChild: false,
          child: [
            ResponseMenuOptionsModel(
                isObscure: false,
                route: AppRoutesName.PAYMENTHISTORY,
                nameOption: "Historial de pagos",
                iconOption: const CircleSubItem(),
                isDesplegable: false,
                isActive: false,
                isDesplegated: false,
                isChild: true),
          ].where((element) => !element.isObscure!).toList()),
    ].where((element) => !element.isObscure!).toList();
    notifyListeners();
  }

  /* 📌  */
  void handleBlur() {
    isShowDownAvatar = !isShowDownAvatar;
    notifyListeners();
  }

  /* 📌  */
  void startTimer() {
    timer?.cancel();
    // timer = Timer(Duration(minutes: minutesSesion), logoutUser);
  }

  /* 📌  */
  /* void startTimerToExpire() {
    timerToExpire?.cancel();
    timerToExpire = Timer(SesionDataTemporary.timeToExpire, () {
      if (!isLogOut) {
        refreshToken(); 
      }
    });
  } */

  // void logoutUser() {
  //   /* loginout(); */
  //   HelpersComponents.getModal(
  //     Get.context!,
  //     ResultDialog(
  //       type: 4,
  //       title: "Aviso de sesión expirada",
  //       subTitle: messageErrorUnauthorize,
  //       doubleButton: false,
  //       aceptText: "Aceptar",
  //       onTapAcept: () async {
  //         /* Get.offAllNamed(AppRoutesName.LOGIN); */
  //         loginout();
  //       },
  //     ),
  //   );
  // }

  /* 📌  */
  /* void refreshToken() async {
    try {
      final response = await _loginRepository.refreshToken(
          RequestRefreshTokenTDPmodel(
              refreshToken: SesionDataTemporary.currentRefreshToken));
      if (response.state == true) {
        final bridge = response.token!.accessToken;
        String payloadBase64 = bridge!.split('.')[1];
        SesionDataTemporary.data = jsonDecode(utf8.decode(base64Url.decode(
            payloadBase64.padRight((payloadBase64.length + 3) & ~3, '='))));
        SesionDataTemporary.currentToken = response.token!.accessToken!;
        SesionDataTemporary.currentRefreshToken = response.token!.refreshToken!;
        SesionDataTemporary.init();
        await StorageService.deleteAll();
        await StorageService.set(
          key: Keys.KeyToken,
          value: bridge,
        );
        startTimerToExpire();
        load();
      }
    } catch (error) {}
  } */

  /* 📌  */
  /* void logoutUser() {
    logout(true);
    HelpersComponents.getModal(
      Get.context!,
      ResultDialog(
        type: 4,
        title: "Aviso de sesión expirada",
        subTitle: messageErrorUnauthorize,
        doubleButton: false,
        aceptText: "Aceptar",
        onTapAcept: () async {
          //Get.offAllNamed(AppRoutes.LOGIN);
        },
      ),
    );
  } */

  /* 📌  */
  void setDesplegated(String route) {
    ResponseMenuOptionsModel option =
        options.firstWhere((element) => element.route == route);
    int index = options.indexWhere((element) => element.route == route);
    option.isDesplegated = !option.isDesplegated!;
    options[index] = option;
    notifyListeners();
  }

  /* 📌  */
  void collapseAll() {
    for (var i = 0; i < options.length; i++) {
      ResponseMenuOptionsModel option = options[i];
      option.isDesplegated = false;
      options[i] = option;
    }
    notifyListeners();
  }

  /* 📌  */
  void setActive(String route) {
    options = activeOption(route, options);
    RouteDataTemporary.currentRoute = route;
    notifyListeners();
    // if (!Responsive.isDesktop(Get.context!)) {
    //   Get.back();
    // }
  }

  /* 📌  */
  List<ResponseMenuOptionsModel> activeOption(
      String route, List<ResponseMenuOptionsModel> list) {
    List<ResponseMenuOptionsModel> myListTemporal = list
        .map((element) => element.route == route
            ? createOption(element, true, route)
            : createOption(element, false, route))
        .toList();
    return myListTemporal;
  }

  /* 📌  */
  ResponseMenuOptionsModel createOption(
      ResponseMenuOptionsModel element, bool state, String route) {
    return ResponseMenuOptionsModel(
        route: element.route,
        nameOption: element.nameOption,
        iconOption: element.iconOption,
        isDesplegable: element.isDesplegable,
        isActive: state,
        isDesplegated: element.isDesplegated,
        isChild: element.isChild,
        child: element.child == null
            ? null
            : activeOption(route, element.child ?? []));
  }

  /* 📌  */
  void collapseMenu() {
    isCollapsed = !isCollapsed;
  }

  /* 📌  */
  /*  void logout(bool auto) async {
    if (!auto) {
      Get.offAllNamed(AppRoutes.LOGIN);
      GRecaptchaV3.showBadge();
    }
    isLogOut = true;
    String value = await StorageService.get(Keys.KeyToken);
    try {
      final response = await _loginRepository.logoutAutenticathion(
          RequestLogoutTdPmodel(
              vusuario: SesionDataTemporary.data["vusuario"], token: value));
      if (response == true) {
        cleanDataSesion();
      }
    
    } catch (e) {}
  }
 */

  /* 📌 Para cerrar sesión */
  loginout() async {
    // await StorageService.deleteAll();
    // cleanDataSesion();
    // Get.offAllNamed(AppRoutesName.LOGIN);
    /* html.window.location.replace('/#/login'); */
    /* html.window.location.href = "/#/login"; */
    /* html.window.history.replaceState(null, '', '/#/login'); */
    /* html.window.history.pushState(null, '', "/#/login"); */

    /* html.window.history.replaceState(null, '', '/#/login'); */
    /* html.window.history.pushState(null, '', "/#/login"); */
    /* html.window.location.href = "/#/login"; */
  }

  /*  void changePassword(bool auto) async {
    if (!auto) {
      /* Get.offAllNamed(AppRoutes.CHANGEPASS);
      GRecaptchaV3.showBadge();
    }
    isLogOut = true;
    String value = await StorageService.get(Keys.KeyToken); */
    try {
     /*  final response = await _loginRepository.logoutAutenticathion(
          RequestLogoutTdPmodel(
              vusuario: SesionDataTemporary.data["vusuario"], token: value));
      if (response == true) {
        cleanDataSesion();
      } */
    
    } catch (e) {}
  } */

  /* 📌  */
  // void cleanDataSesion() async {
  //   /* await StorageService.deleteAll(); */
  //   SesionDataTemporary.reset();
  // }

  /* 📌 Segun la pagina que seleccionemos nos redirigira a su vista */
  Widget setScreen() {
    switch (RouteDataTemporary.currentRoute) {
      case AppRoutesName.DASHBOARD:
        return const DashboardView();
      case AppRoutesName.PROFILE:
        return const MyprofileView();
      case AppRoutesName.PERSON:
        return const PersonView();
      case AppRoutesName.COURSES:
        return const CourseView();
      case AppRoutesName.PAYMENTHISTORY:
        return const PaymentHistoryView();
      case AppRoutesName.MANAGEQUOTA:
        return const ManageQuotaView();
      case AppRoutesName.UNKNOW:
        return const Center(
          child: PageNotFound(message: "No se encontró la página solicitada"),
        );
      default:
        return const Center(
          child: PageNotFound(message: "No se encontró la página solicitada"),
        );
    }
    
  }

  /* 📌 Para los titulos de cada vista */
  String setNavBarTitle() {
    switch (RouteDataTemporary.currentRoute) {
      case AppRoutesName.DASHBOARD:
        return "Inicio";
      case AppRoutesName.PROFILE:
        return "Mi pefil";
      case AppRoutesName.PERSON:
        return "Colegiados";
      case AppRoutesName.COURSES:
        return "Cursos";
      case AppRoutesName.MYPAYMENTS:
        return "Mis pagos";
      case AppRoutesName.PAYMENTHISTORY:
        return "Historial de pagos";
      case AppRoutesName.MANAGEQUOTA:
        return "Administrar cuotas";
      case AppRoutesName.UNKNOW:
        return "Página desconocida";
      default:
        return "Página desconocida";
    }
  }
}

/* 📌 Pequeños circulos de los subItems */
class CircleSubItem extends StatelessWidget {
  const CircleSubItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.only(left: 15.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
    );
  }
}
