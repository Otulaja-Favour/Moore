import 'package:flutter/material.dart';
import 'package:moove/components/custom_button.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/components/placeholder_illustrations.dart';
import 'package:moove/constants/colors.dart';
import 'package:moove/screens/signup_screen.dart';
import 'package:moove/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Seamless Onboarding',
      'description': 'Set up budgets effortlessly to manage your expenses. Take control of your money with ease.',
    },
    {
      'title': 'Effortless Transactions',
      'description': 'Experience seamless financial transactions with Moore. Managing your money has never been this easy.',
    },
    {
      'title': 'Simplify Daily Spending',
      'description': 'Moore makes managing your daily expenses a breeze. Stay in control of your day-to-day spending with our user friendly tools.',
    },
    {
      'title': 'Invest Smarter',
      'description': 'Discover a simpler way to invest. Our platform is built to be easy and rewarding.',
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background Layer Asset (Aligned to the right edge as a crescent ornament)
            Positioned(
              right: -size.width * 0.12,
              top: size.height * 0.28,
              width: size.width * 0.4,
              height: size.width * 0.4,
              child: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  'assest/img/backgroundonabordlayer.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 16),
              // Top Indicator Bars (4 segments)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: List.generate(
                    _onboardingData.length,
                    (index) => Expanded(
                      child: Container(
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: _currentPage == index 
                              ? Colors.white 
                              : Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Moore Logo (White Theme)
              Image.asset(
                'assest/img/logo.png',
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Stylized Small M Logo (Fallback)
                    SizedBox(
                      height: 24,
                      width: 26,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Container(
                              width: 5.5,
                              height: 19,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 7.5,
                            bottom: 0,
                            child: Container(
                              width: 5.5,
                              height: 13,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 5.5,
                              height: 19,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const MooreText(
                      'Moore',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textLightPrimary,
                      letterSpacing: 0.8,
                    ),
                  ],
                ),
              ),
              // Middle Swiper (PageView)
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    final data = _onboardingData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 1),
                          // Responsive Vector Illustration wrapped in Expanded
                          Expanded(
                            flex: 6,
                            child: OnboardingIllustration(pageIndex: index),
                          ),
                          const Spacer(flex: 1),
                          // Title
                          MooreText(
                            data['title']!,
                            fontSize: size.height > 700 ? 24 : 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textLightPrimary,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          // Subtitle Description
                          Flexible(
                            flex: 3,
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: MooreText(
                                data['description']!,
                                fontSize: size.height > 700 ? 14 : 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textLightMuted,
                                textAlign: TextAlign.center,
                                height: 1.4,
                              ),
                            ),
                          ),
                          const Spacer(flex: 1),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Action Buttons Bottom Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 1. "I already have an account" button
                    MooreButton(
                      text: 'I already have an account',
                      isOutlined: true,
                      onPressed: _navigateToLogin,
                    ),
                    const SizedBox(height: 12),
                    // 2. "Open account" button
                    MooreButton(
                      text: 'Open account',
                      isOutlined: false,
                      backgroundColor: Colors.white.withOpacity(0.12),
                      borderColor: Colors.transparent,
                      textColor: Colors.white,
                      onPressed: _navigateToSignUp,
                    ),
                    const SizedBox(height: 8),
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
