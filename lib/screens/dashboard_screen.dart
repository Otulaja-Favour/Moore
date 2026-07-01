// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:moove/components/custom_text.dart';
import 'package:moove/constants/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentNavIndex = 0;
  bool _balanceVisible = true;
  bool _promoBannerVisible = true;
  int _promoDotIndex = 0;

  final String _userName = 'Oluwabunmi';
  final String _userInitials = 'TC';
  final String _balance = '₦2,905,215.23';
  final String _accountLabel = 'Wallet Account';

  final List<Map<String, dynamic>> _transactions = [
    {
      'name': 'Timothy Campbell',
      'date': 'From 12/09/2023 · To: 13/09/2023',
      'amount': '+₦150,000.00',
      'isCredit': true,
      'initials': 'TC',
    },
    {
      'name': 'Samuel Darasimi',
      'date': 'Today, 14:22',
      'amount': '-₦150,000.00',
      'isCredit': false,
      'initials': 'SD',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ── Gradient Header ──
          _buildHeader(context),

          // ── Body ──
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promo banner
                  if (_promoBannerVisible) _buildPromoBanner(),

                  const SizedBox(height: 8),
                  // Swipe hint
                  Center(
                    child: MooreText(
                      'Swipe up to view more transactions',
                      fontSize: 11,
                      color: AppColors.textDarkPlaceholder,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Transactions
                  _buildTransactionList(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Bottom Nav ──
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ─────────────────────────────────────────────
  // GRADIENT HEADER
  // ─────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2F54EB), Color(0xFF7B3FE4), Color(0xFF091442)],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: avatar + name, icons
              Row(
                children: [
                  // Avatar circle
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.teal[400],
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: MooreText(
                      _userInitials,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MooreText(
                          'Hi, $_userName',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        // Tier badge
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const MooreText(
                            'Tier 1',
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action icons
                  IconButton(
                    icon: const Icon(Icons.grid_view_rounded,
                        color: Colors.white, size: 22),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.search,
                        color: Colors.white, size: 22),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.more_vert,
                        color: Colors.white, size: 22),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Switch Account
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      MooreText(
                        'Switch Account',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.keyboard_arrow_down,
                          color: Colors.white, size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Balance row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MooreText(
                      _balanceVisible ? _balance : '₦ ••••••••',
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _balanceVisible = !_balanceVisible),
                    child: Icon(
                      _balanceVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white70,
                      size: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              MooreText(
                _accountLabel,
                fontSize: 12,
                color: Colors.white60,
              ),
              const SizedBox(height: 24),

              // Quick actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _quickAction(Icons.add_circle_outline, 'Add Money'),
                  _quickAction(Icons.signal_cellular_alt, 'Airtime'),
                  _quickAction(Icons.wifi_outlined, 'Data'),
                  _quickAction(Icons.receipt_long_outlined, 'Bills'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          MooreText(
            label,
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // PROMO BANNER (WhatsApp Banking)
  // ─────────────────────────────────────────────
  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WhatsApp icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF25D366),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.chat, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MooreText(
                      'WhatsApp Banking',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDarkPrimary,
                    ),
                    const SizedBox(height: 4),
                    MooreText(
                      'Manage your banking effortlessly! Check your balance, transfer funds, and purchase airtime directly through WhatsApp.',
                      fontSize: 12,
                      color: AppColors.textDarkSecondary,
                      height: 1.45,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _promoBannerVisible = false),
                child: const Icon(Icons.close,
                    size: 18, color: AppColors.textDarkSecondary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (i) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: i == _promoDotIndex ? 16 : 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: i == _promoDotIndex
                      ? AppColors.primary
                      : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // TRANSACTION LIST
  // ─────────────────────────────────────────────
  Widget _buildTransactionList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: _transactions.map((tx) => _buildTxItem(tx)).toList(),
      ),
    );
  }

  Widget _buildTxItem(Map<String, dynamic> tx) {
    final isCredit = tx['isCredit'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isCredit
                  ? Colors.green.withOpacity(0.12)
                  : Colors.red.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: MooreText(
              tx['initials'] as String,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isCredit ? Colors.green[700]! : Colors.red[700]!,
            ),
          ),
          const SizedBox(width: 12),
          // Name + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MooreText(
                  tx['name'] as String,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDarkPrimary,
                ),
                const SizedBox(height: 3),
                MooreText(
                  tx['date'] as String,
                  fontSize: 11,
                  color: AppColors.textDarkSecondary,
                ),
              ],
            ),
          ),
          // Amount
          MooreText(
            tx['amount'] as String,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isCredit ? Colors.green[700]! : Colors.red[700]!,
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  // BOTTOM NAV BAR
  // ─────────────────────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.swap_horiz_rounded, 'label': 'Transfer'},
      {'icon': Icons.card_giftcard_outlined, 'label': 'Rewards'},
      {'icon': Icons.sports_esports_outlined, 'label': 'Games'},
      {'icon': Icons.more_horiz, 'label': 'More'},
    ];

    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(color: AppColors.borderLight, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final isActive = i == _currentNavIndex;
          return GestureDetector(
            onTap: () => setState(() => _currentNavIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    items[i]['icon'] as IconData,
                    size: 22,
                    color: isActive
                        ? AppColors.primary
                        : AppColors.textDarkSecondary,
                  ),
                  const SizedBox(height: 4),
                  MooreText(
                    items[i]['label'] as String,
                    fontSize: 10,
                    fontWeight:
                        isActive ? FontWeight.w700 : FontWeight.w400,
                    color: isActive
                        ? AppColors.primary
                        : AppColors.textDarkSecondary,
                  ),
                  const SizedBox(height: 2),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isActive ? 16 : 0,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
