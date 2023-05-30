import 'package:database/database/controllers/user_db_controller.dart';
import 'package:database/models/response_process.dart';
import 'package:database/utils/extension.dart';
import 'package:database/utils/helper.dart';
import 'package:database/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  bool _obscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.login,
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.login_title,
              style: GoogleFonts.cairo(
                fontSize: 22.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppLocalizations.of(context)!.login_subtitle,
              style: GoogleFonts.cairo(
                  fontSize: 18.sp,
                  color: Colors.black38,
                  height: 1.h,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            AppTextField(
              textInputType: TextInputType.emailAddress,
              hintText: AppLocalizations.of(context)!.email,
              prefixIcon: Icons.email,
              controller: _emailEditingController,
            ),
            SizedBox(height: 15.h),
            AppTextField(
              textInputType: TextInputType.text,
              hintText: AppLocalizations.of(context)!.password,
              prefixIcon: Icons.lock,
              obscure: _obscureText,
              controller: _passwordEditingController,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _performLogin();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 44.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.login,
                style: GoogleFonts.cairo(fontSize: 16.sp),
              ),
            ),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.register_below),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register_screen');
                  },
                  child: Text(AppLocalizations.of(context)!.register_create),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context,
        message: AppLocalizations.of(context)!.error_data, error: true);
    return false;
  }

  Future<void> _login() async {
    ///TODO : Call database login function
    ProcessResponses processResponses = await UserDbController().login(
        email: _emailEditingController.text,
        password: _passwordEditingController.text);
    if (processResponses.success) {
      Navigator.pushReplacementNamed(context, '/products_screen');
    }
    context.showSnackBar(
        message: processResponses.message, error: !processResponses.success);
  }
}
