import 'package:database/pref/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      bool result =
          SharedPerfController().getValue<bool>(PerfKeys.loggedIn.name) ??
              false;
      String route = result ? '/products_screen' : '/onboarding_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/splash.png',
          ),
          SizedBox(height: 10.h),
          Text(
            AppLocalizations.of(context)!.cart,
            style: GoogleFonts.montserrat(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0XFF0097B2),
            ),
          ),
        ],
      ),
    );
  }
}
