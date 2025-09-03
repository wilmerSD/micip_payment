import 'package:cip_payment_web/app/ui/views/advancepayment/advancepayment_view.dart';
import 'package:cip_payment_web/app/ui/views/certificateskill/certificateskill_view.dart';
import 'package:cip_payment_web/app/ui/views/dashboard/dashboard_view.dart';
import 'package:cip_payment_web/app/ui/views/home/home_view.dart';
import 'package:cip_payment_web/app/ui/views/iepi/detail_course.dart';
import 'package:cip_payment_web/app/ui/views/layout/layout_view.dart';
import 'package:cip_payment_web/app/ui/views/login/login_view.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/courses/course_view.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/historypay/payment_history_view.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/managequota/manage_quota_view.dart';
import 'package:cip_payment_web/app/ui/views/manteiners/person/person_view.dart';
import 'package:cip_payment_web/app/ui/views/monthlyfees/monthlyfees_view.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/myprofile_view.dart';
import 'package:cip_payment_web/app/ui/views/myprofile/widgets/reset_pass.dart';
import 'package:cip_payment_web/app/ui/views/proofnodebt/proofnodebt_view.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/recover_pass_code.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/recover_pass_email.dart';
import 'package:cip_payment_web/app/ui/views/recoverpass/widgets/recover_pass_reset.dart';
import 'package:cip_payment_web/app/ui/views/splash/splash_view.dart';
import 'package:cip_payment_web/routes/app_routes_name.dart';
import 'package:go_router/go_router.dart';

/// 🌍 Configuración de go_router
final GoRouter appRouter = GoRouter(
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

    // GoRoute(
    //   path: '/profile/:id',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return ProfileView(id: id);
    //   },
    // ),
  ],
);
