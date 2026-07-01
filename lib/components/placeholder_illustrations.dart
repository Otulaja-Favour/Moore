import 'package:flutter/material.dart';
import 'package:moove/constants/colors.dart';

class OnboardingIllustration extends StatelessWidget {
  final int pageIndex;

  const OnboardingIllustration({
    super.key,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Respect both width and height constraints to prevent overflow in different aspect ratios
        final double maxAvailable = constraints.maxHeight == double.infinity 
            ? constraints.maxWidth 
            : (constraints.maxWidth < constraints.maxHeight 
                ? constraints.maxWidth 
                : constraints.maxHeight);
        final double size = maxAvailable * 0.9;
        
        return Center(
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
              // Background ambient circular gradient reflection
              Container(
                width: size * 0.9,
                height: size * 0.9,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0x33597EF7),
                      Color(0x00000000),
                    ],
                  ),
                ),
              ),
              // Floating ambient shapes (matching the Figma circles on the sides)
              Positioned(
                top: -size * 0.15,
                right: -size * 0.15,
                child: Container(
                  width: size * 0.35,
                  height: size * 0.35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.08), width: 1.5),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.05),
                        Colors.white.withOpacity(0.02),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -size * 0.05,
                left: -size * 0.1,
                child: Container(
                  width: size * 0.25,
                  height: size * 0.25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.0),
                  ),
                ),
              ),
              // Isometric platform base
              Positioned(
                bottom: size * 0.1,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(0.9)
                    ..rotateZ(-0.4),
                  alignment: FractionalOffset.center,
                  child: Container(
                    width: size * 0.65,
                    height: size * 0.65,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.gradientEnd.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(5, 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // The main active illustration item based on index
              Positioned(
                bottom: size * 0.18,
                child: _buildIllustrationContent(size),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  // List of onboarding asset paths matching the page indexes
  static const List<String> _onboardingAssets = [
    'assest/img/onboarding1.png',
    'assest/img/onboarding2.png',
    'assest/img/onboarding1.png', // Temporary fallback
    'assest/img/onboarding2.png', // Temporary fallback
  ];

  Widget _buildIllustrationContent(double parentSize) {
    if (pageIndex >= 0 && pageIndex < _onboardingAssets.length) {
      return Image.asset(
        _onboardingAssets[pageIndex],
        width: parentSize * 0.9,
        height: parentSize * 0.9,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => _buildFallbackVector(parentSize, pageIndex),
      );
    }
    return _buildFallbackVector(parentSize, pageIndex);
  }

  Widget _buildFallbackVector(double size, int index) {
    switch (index) {
      case 0:
        return _buildPhoneIllustration(size);
      case 1:
        return _buildWalletIllustration(size);
      case 2:
        return _buildCalendarIllustration(size);
      case 3:
      default:
        return _buildTreeIllustration(size);
    }
  }

  // 1. Smartphone illustration (Seamless Onboarding)
  Widget _buildPhoneIllustration(double size) {
    return Container(
      width: size * 0.32,
      height: size * 0.52,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 3.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(4, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            // Earpiece
            Container(
              width: size * 0.08,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            // Mobile app content placeholder
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar profile card
                    Row(
                      children: [
                        CircleAvatar(
                          radius: size * 0.035,
                          backgroundColor: Colors.green[100],
                          child: Icon(Icons.person, size: size * 0.04, color: Colors.green[700]),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(height: 6, color: Colors.grey[300], width: double.infinity),
                              const SizedBox(height: 4),
                              Container(height: 4, color: Colors.grey[200], width: size * 0.1),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Line blocks
                    Container(height: 6, color: Colors.grey[200], width: double.infinity),
                    const SizedBox(height: 6),
                    Container(height: 6, color: Colors.grey[200], width: double.infinity),
                    const SizedBox(height: 6),
                    Container(height: 6, color: Colors.grey[200], width: size * 0.15),
                    const Spacer(),
                    // Bottom green bar indicator
                    Container(
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.green[500],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Icon(Icons.check, color: Colors.white, size: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 2. Leather wallet illustration (Effortless Transactions)
  Widget _buildWalletIllustration(double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Cash bill peaking out
        Positioned(
          bottom: size * 0.18,
          child: Transform.rotate(
            angle: 0.15,
            child: Container(
              width: size * 0.22,
              height: size * 0.18,
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Center(
                child: Text(
                  '\$',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size * 0.06,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Wallet body
        Container(
          width: size * 0.38,
          height: size * 0.28,
          decoration: BoxDecoration(
            color: Colors.amber[800],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 15,
                offset: const Offset(4, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Inside pocket seam
              Positioned(
                top: 0,
                bottom: 0,
                left: size * 0.16,
                child: Container(
                  width: 3,
                  color: Colors.amber[900]?.withOpacity(0.5),
                ),
              ),
              // Golden clasp button
              Positioned(
                right: size * 0.04,
                top: size * 0.11,
                child: Container(
                  width: size * 0.05,
                  height: size * 0.05,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFD700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3. Calendar checklist card (Simplify Daily Spending)
  Widget _buildCalendarIllustration(double size) {
    return Container(
      width: size * 0.36,
      height: size * 0.36,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(4, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Red Header
          Container(
            height: size * 0.10,
            decoration: const BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              )),
            ),
          ),
          // Checklists
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCalendarRow(size, Colors.green, true),
                  _buildCalendarRow(size, Colors.orange, true),
                  _buildCalendarRow(size, Colors.grey[300]!, false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarRow(double size, Color color, bool checked) {
    return Row(
      children: [
        Container(
          width: size * 0.04,
          height: size * 0.04,
          decoration: BoxDecoration(
            color: checked ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: checked ? Colors.transparent : Colors.grey[400]!,
              width: 1,
            ),
          ),
          child: checked 
              ? const Icon(Icons.check, size: 8, color: Colors.white) 
              : null,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ],
    );
  }

  // 4. Money/Investment Tree illustration (Invest Smarter)
  Widget _buildTreeIllustration(double size) {
    return Container(
      width: size * 0.38,
      height: size * 0.38,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Trunk
          Positioned(
            bottom: 0,
            child: Container(
              width: 8,
              height: size * 0.22,
              decoration: BoxDecoration(
                color: Colors.brown[700],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          // Leaves (Green circle overlay)
          Positioned(
            top: 4,
            child: Container(
              width: size * 0.24,
              height: size * 0.24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
          ),
          // Gold Coins on leaves
          Positioned(
            top: size * 0.06,
            left: size * 0.11,
            child: _buildTreeCoin(size * 0.038),
          ),
          Positioned(
            top: size * 0.12,
            right: size * 0.12,
            child: _buildTreeCoin(size * 0.038),
          ),
          Positioned(
            top: size * 0.08,
            right: size * 0.18,
            child: _buildTreeCoin(size * 0.038),
          ),
          Positioned(
            top: size * 0.18,
            left: size * 0.14,
            child: _buildTreeCoin(size * 0.038),
          ),
        ],
      ),
    );
  }

  Widget _buildTreeCoin(double coinSize) {
    return Container(
      width: coinSize,
      height: coinSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFFFD700),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
    );
  }
}
