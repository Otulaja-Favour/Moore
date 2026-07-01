// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/assets.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/login_screen.dart';
import 'package:moove/screens/signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<_OnboardingPage> _pages = [
    _OnboardingPage(
      image: AppAssets.onboarding1,
      title: 'Seamless Onboarding',
      description:
          'Set up budgets effortlessly to manage your expenses. Take control of your money with ease.',
    ),
    _OnboardingPage(
      image: AppAssets.onboarding2,
      title: 'Effortless Transactions',
      description:
          'Experience seamless financial transactions with Moore. Managing your money has never been this easy.',
    ),
    _OnboardingPage(
      image: AppAssets.onboarding3,
      title: 'Simplify Daily Spending',
      description:
          'Moore makes managing your daily expenses a breeze. Stay in control of your day-to-day spending with our user-friendly tools.',
    ),
    _OnboardingPage(
      image: AppAssets.onboarding4,
      title: 'Invest Smarter',
      description:
          'Discover a simpler way to invest. Our platform is built to be easy and rewarding.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) => setState(() => _currentPage = index);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.onboardingBg,
        child: Stack(
          clipBehavior: Clip.none,
          children: [

            // ── Half-circle — top-right, smaller, higher up ──
            Positioned(
              right: -size.width * 0.10,
              top: size.height * 0.08,
              width: size.width * 0.36,
              height: size.width * 0.36,
              child: Image.asset(
                AppAssets.onboardingAngle,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),

            // ── Backdrop — from illustration zone all the way to screen bottom,
            //    goes UNDER the button container (Stack order handles layering) ──
            Positioned(
              left: 0,
              right: 0,
              top: size.height * 0.19,
              bottom: 0,
              child: Image.asset(
                AppAssets.onboardingBackdrop,
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),

            // ── Main content column ──
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // Space above progress bar
                  const SizedBox(height: 10),

                  // Progress bars
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: List.generate(_pages.length, (i) {
                        return Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 350),
                            height: 2.5,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: i <= _currentPage
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.30),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Logo + Moore label
                  Column(
                    children: [
                      Image.asset(
                        AppAssets.logo2,
                        height: 46,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 4),
                     
                    ],
                  ),

                  // PageView — swipe works on mobile AND web/Chrome
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      physics: const ClampingScrollPhysics(),
                      allowImplicitScrolling: true,
                      itemCount: _pages.length,
                      itemBuilder: (_, i) => _PageContent(
                        page: _pages[i],
                        screenSize: size,
                      ),
                    ),
                  ),

                  // ── Button container — darker rounded box ──
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                    decoration: const BoxDecoration(
                      color: AppColors.onboardingContainer,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // "I already have an account" — outlined pill
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.borderDarkOutline,
                                width: 1.5,
                              ),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const MooreText(
                              'I already have an account',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textLightPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // "Open account" — lighter blue solid pill
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const SignUpScreen()),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.onboardingBtnOpen,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const MooreText(
                              'Open account',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textLightPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Single page content
// ─────────────────────────────────────────────
class _PageContent extends StatelessWidget {
  final _OnboardingPage page;
  final Size screenSize;

  const _PageContent({required this.page, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Illustration
        Expanded(
          flex: 11,
          child: SvgPicture.asset(
            page.image,
            fit: BoxFit.contain,
            placeholderBuilder: (_) => const Center(
              child: CircularProgressIndicator(
                color: Colors.white38,
                strokeWidth: 2,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: MooreText(
            page.title,
            fontSize: screenSize.height > 700 ? 26 : 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textLightPrimary,
            textAlign: TextAlign.center,
          ),
        ),

        const SizedBox(height: 10),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: MooreText(
            page.description,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.textLightMuted,
            textAlign: TextAlign.center,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Data model
// ─────────────────────────────────────────────
class _OnboardingPage {
  final String image;
  final String title;
  final String description;

  const _OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}
