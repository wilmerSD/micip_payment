import 'package:cip_payment_web/app/providers/auth_provider.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:go_router/go_router.dart';
import 'package:cip_payment_web/app/ui/views/views.dart';
import 'package:provider/provider.dart';

/// 🌍 Configuración de go_router
final GoRouter appRouter = GoRouter(
  initialLocation: '/', // AppRoutesName.SPLASH, // tu pantalla inicial
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(
      path: AppRoutesName.LAYOUT,
      builder: (context, state) => const LayoutView(),
    ),
    GoRoute(
      path: AppRoutesName.LOGIN,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: AppRoutesName.HOME,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppRoutesName.PERSON,
      builder: (context, state) => const PersonView(),
    ),

    GoRoute(
      path: AppRoutesName.PROFILE,
      builder: (context, state) => const MyprofileView(),
    ),
    GoRoute(
      path: AppRoutesName.PERSONALDATA,
      builder: (context, state) => const PersonalData(),
    ),
    GoRoute(
      path: AppRoutesName.PERSONALCONTACT,
      builder: (context, state) => const PersonalContact(),
    ),
    GoRoute(
      path: AppRoutesName.PERSONALCOLLEGE,
      builder: (context, state) => const PersonalCollege(),
    ),

    GoRoute(
      path: AppRoutesName.RESETPASS,
      builder: (context, state) => const ResetPass(),
    ),

    GoRoute(
      path: AppRoutesName.COURSES,
      builder: (context, state) => const CourseView(),
    ),
    GoRoute(
      path: AppRoutesName.DETAILCOURSE,
      builder: (context, state) => const DetailCourse(),
    ),
    GoRoute(
      path: AppRoutesName.DASHBOARD,
      builder: (context, state) => const DashboardView(),
    ),
    GoRoute(
      path: AppRoutesName.PAYMENTHISTORY,
      builder: (context, state) => const PaymentHistoryView(),
    ),
    GoRoute(
      path: AppRoutesName.MANAGEQUOTA,
      builder: (context, state) => const ManageQuotaView(),
    ),

    GoRoute(
      path: AppRoutesName.RECOVERPASS,
      builder: (context, state) =>
          const RecoverPasswordEmail(), // la pantalla inicial
      routes: [
        GoRoute(
          path: AppRoutesName.RECOVERPASSCODE,
          builder: (context, state) => const RecoverPassCode(),
        ),
        GoRoute(
          path: AppRoutesName.RECOVERPASSNEW,
          builder: (context, state) => const RecoverPassReset(),
        ),
      ],
    ),

    //Pagos
    GoRoute(
      path: AppRoutesName.MONTHLYFEES,
      builder: (context, state) => const MonthlyfeesView(),
    ),
    GoRoute(
      path: AppRoutesName.CERTIFICATESKILL,
      builder: (context, state) => const CertificateSkillView(),
    ),
    GoRoute(
      path: AppRoutesName.PROOFNODEBT,
      builder: (context, state) => const ProofnodebtView(),
    ),
    GoRoute(
      path: AppRoutesName.ADVANCEPAYMENT,
      builder: (context, state) => const AdvancepaymentView(),
    ),

    //Vista de pago realizado
    GoRoute(
      path: AppRoutesName.PAYMENTGOOD,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final double amount = extra?['amount'] as double? ?? 0;
        final String title = extra?['title'] as String? ?? '';
        final int operationId = extra?['operationId'] as int? ?? 0;
        final String dateTime = extra?['dateTime'] as String? ?? '';
        return PaymentGood(operationId, dateTime, amount, title);
      },
    ),
    GoRoute(
      path: AppRoutesName.PAYMENTBAD,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final int operationId = extra?['operationId'] as int? ?? 0;
        final String dateTime = extra?['dateTime'] as String? ?? '';
        final String detailError = extra?['detailError'] as String? ?? '';
        return PaymentBad(operationId, dateTime, detailError);
      },
    ),

    // GoRoute(
    //   path: '/profile/:id',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return ProfileView(id: id);
    //   },
    // ),
  ],
  redirect: (context, state) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    // 🔹 Mientras carga, no redirijas nada
    if (auth.isLoading) return null;

    final loggedIn = auth.isLoggedIn;
    final loggingIn = state.uri.path == AppRoutesName.LOGIN; //'/login';

    // Si no está logueado y no está en /login -> redirigir a login
    if (!loggedIn && !loggingIn) return AppRoutesName.LOGIN; //'/login';

    // Si ya está logueado y está en /login -> mandarlo a home
    if (loggedIn && loggingIn) return AppRoutesName.HOME; //'/home';

    // Dejar pasar
    return null;
  },
);
