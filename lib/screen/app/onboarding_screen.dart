import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../pref/shared_pref.dart';
import '../../provider/language_provider.dart';
import '../../widget/on_boarding_content.dart';
import '../../widget/page_view_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  late PageController _pageController;
  late String _language;

  @override
  void initState() {
    super.initState();
    _language = SharedPerfController().language;
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _selectedLanguage();
          },
          icon: const Icon(Icons.language),
        ),
        actions: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Visibility(
              visible: _currentPage < 2,
              child: TextButton(
                onPressed: () {
                  _pageController.animateToPage(2,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOutBack);
                },
                child: Text(AppLocalizations.of(context)!.skip),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                onPageChanged: (int currentPage) {
                  setState(() {
                    _currentPage = currentPage;
                  });
                },
                children: [
                  OnBoardingContent(
                    AppLocalizations.of(context)!.welcome,
                    image: 'image_1',
                  ),
                  OnBoardingContent(
                    AppLocalizations.of(context)!.add,
                    image: 'image_2',
                  ),
                  OnBoardingContent(
                    AppLocalizations.of(context)!.enjoy,
                    image: 'image_3',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pageViewIndicator(
                  isCurrentPage: _currentPage == 0 ? true : false,
                  endMargin: 15,
                ),
                pageViewIndicator(
                  isCurrentPage: _currentPage == 1 ? true : false,
                  endMargin: 15,
                ),
                pageViewIndicator(
                  isCurrentPage: _currentPage == 2 ? true : false,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (_currentPage != 0) {
                        _pageController.previousPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOutBack);
                      }
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_currentPage < 2) {
                        _pageController.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOutBack);
                      }
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Visibility(
              visible: _currentPage == 2,
              maintainSize: true,
              maintainState: true,
              maintainAnimation: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.h, 3.w),
                          blurRadius: 3.r),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        Color(0XFF537FE7),
                        Color(0XFFE9F8F9),
                      ],
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.h),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login_screen');
                    },
                    child: Text(AppLocalizations.of(context)!.enjoy_now),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  void _selectedLanguage() async {
    String? langCode = await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.change_language,
                          style: GoogleFonts.cairo(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              height: 1.h),
                        ),
                        Text(
                          AppLocalizations.of(context)!.selected_language,
                          style: GoogleFonts.cairo(
                            color: Colors.black87,
                            fontWeight: FontWeight.w300,
                            fontSize: 14.sp,
                          ),
                        ),
                        const Divider(),
                        RadioListTile<String>(
                            title: Text(
                              'English',
                              style: GoogleFonts.cairo(
                                fontSize: 18.sp,
                              ),
                            ),
                            value: 'en',
                            groupValue: _language,
                            onChanged: (String? value) {
                              setState(() {
                                if (value != null) {
                                  _language = value;
                                }
                              });
                              Navigator.pop(context, 'en');
                            }),
                        RadioListTile<String>(
                          title: Text(
                            'العربية',
                            style: GoogleFonts.cairo(
                              fontSize: 18.sp,
                            ),
                          ),
                          value: 'ar',
                          groupValue: _language,
                          onChanged: (String? value) {
                            setState(() {
                              if (value != null) {
                                _language = value;
                              }
                            });
                            Navigator.pop(context, 'ar');
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        });
    if (langCode != null) {
      Provider.of<LanguageProvider>(context, listen: false).changeLanguage();
    }
  }
}
