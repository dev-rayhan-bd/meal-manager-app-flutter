import 'package:flutter/material.dart';
import '../../../../app/config/app_colors.dart';
import '../../../../core/providers/app_state_provider.dart';
import '../../../../core/utils/formatters.dart';

/// Single Page Wrapper for Dashboard Screen.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DashboardHomeBody(),
    );
  }
}

/// Dashboard Home Body Content with Translations, Dark Theme, Overflow Fixes & Pull-to-Refresh.
class DashboardHomeBody extends StatelessWidget {
  const DashboardHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final appState = AppState.instance;

        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 800));
            },
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Top Header & User Greeting (Overflow Fixed)
                  _buildHeader(context, appState),
                  const SizedBox(height: 18),

                  // 2. Hero Gradient Overview Card (Overflow Fixed)
                  _buildHeroGradientCard(context, appState),
                  const SizedBox(height: 20),

                  // 3. Quick Actions Section (Equal Uniform Cards Fixed)
                  _buildQuickActions(context, appState),
                  const SizedBox(height: 22),

                  // 4. Summary Grid Stats Cards
                  _buildSectionHeader(
                    appState.tr('mess_overview'),
                    icon: Icons.insights_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryGrid(context, appState),
                  const SizedBox(height: 22),

                  // 5. Recent Activity Feed
                  _buildSectionHeader(
                    appState.tr('recent_activity'),
                    icon: Icons.history_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildRecentActivity(context, appState),
                  const SizedBox(height: 100), // Bottom padding for floating navbar
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 1. Top Greeting Header with Profile Photo & Responsive Overflow Fix
  Widget _buildHeader(BuildContext context, AppState appState) {
    return Row(
      children: [
        // Profile Avatar with User Image passport.png
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
          ),
          child: ClipOval(
            child: SizedBox(
              width: 44,
              height: 44,
              child: Image.asset(
                'assets/images/passport.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.primaryLight,
                    child: Icon(Icons.person, color: Colors.white, size: 24),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      appState.tr('greeting'),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text('👋', style: TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      appState.tr('mess_name'),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Notification Icon with Badge
        Stack(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: appState.isDarkMode ? AppColors.darkBorder : AppColors.border,
                  width: 0.8,
                ),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none_rounded,
                  color: Theme.of(context).iconTheme.color,
                  size: 22,
                ),
              ),
            ),
            Positioned(
              right: 9,
              top: 9,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.coral,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 2. Hero Gradient Overview Card with Responsive Overflow Protection
  Widget _buildHeroGradientCard(BuildContext context, AppState appState) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -25,
            top: -25,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              appState.tr('cash_in_hand'),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            color: Colors.amber,
                            size: 13,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${appState.tr('meal_rate')}: ৳৪০.৫০',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Formatters.formatCurrency(14450.00),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildHeroStat(
                        appState.tr('total_deposit'),
                        '৳২৩,০০০',
                        Icons.arrow_downward_rounded,
                        AppColors.accent,
                      ),
                      Container(height: 20, width: 1, color: Colors.white24),
                      _buildHeroStat(
                        appState.tr('total_expense'),
                        '৳৮,৫৫০',
                        Icons.arrow_upward_rounded,
                        AppColors.coral,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(
    String label,
    String value,
    IconData icon,
    Color badgeColor,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: badgeColor.withValues(alpha: 0.25),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 12),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 3. Quick Actions with 100% Uniform Equal Heights & No Wrapping Distortion
  Widget _buildQuickActions(BuildContext context, AppState appState) {
    final actions = [
      {
        'label': appState.tr('add_meal'),
        'icon': Icons.restaurant_rounded,
        'color': AppColors.primary,
        'bg': AppColors.primary.withValues(alpha: 0.12),
      },
      {
        'label': appState.tr('add_expense'),
        'icon': Icons.add_shopping_cart_rounded,
        'color': AppColors.secondary,
        'bg': AppColors.secondary.withValues(alpha: 0.12),
      },
      {
        'label': appState.tr('add_deposit'),
        'icon': Icons.move_to_inbox_rounded,
        'color': AppColors.accent,
        'bg': AppColors.accent.withValues(alpha: 0.12),
      },
      {
        'label': appState.tr('mess_calc'),
        'icon': Icons.receipt_long_rounded,
        'color': AppColors.coral,
        'bg': AppColors.coral.withValues(alpha: 0.12),
      },
    ];

    return Row(
      children: actions.map((item) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item['label']} tapped')),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 88, // Fixed uniform height for all 4 cards
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: appState.isDarkMode ? AppColors.darkBorder : AppColors.border,
                    width: 0.8,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: item['bg'] as Color,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Section Header helper
  Widget _buildSectionHeader(String title, {required IconData icon}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// 4. Summary Grid
  Widget _buildSummaryGrid(BuildContext context, AppState appState) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.4,
      children: [
        _ModernStatCard(
          title: appState.tr('total_meals'),
          value: '১৪২.৫ ${appState.tr('items')}',
          subtitle: appState.isEnglish ? 'This Month' : 'চলতি মাসে',
          icon: Icons.flatware_rounded,
          gradient: AppColors.primaryGradient,
        ),
        _ModernStatCard(
          title: appState.tr('total_expense'),
          value: '৳৮,৫৫০.০০',
          subtitle: appState.isEnglish ? 'Bazaar & Misc' : 'বাজার ও বিবিধ',
          icon: Icons.shopping_bag_rounded,
          gradient: AppColors.sunsetGradient,
        ),
        _ModernStatCard(
          title: appState.tr('active_members'),
          value: '৪ ${appState.isEnglish ? 'Members' : 'জন'}',
          subtitle: appState.isEnglish ? 'All Active' : 'সবাই অ্যাক্টিভ',
          icon: Icons.groups_rounded,
          gradient: AppColors.emeraldGradient,
        ),
        _ModernStatCard(
          title: appState.tr('meal_rate'),
          value: '৳৪০.৫০',
          subtitle: appState.isEnglish ? 'Per Meal Cost' : 'প্রতি মিলের দাম',
          icon: Icons.pie_chart_rounded,
          gradient: AppColors.oceanGradient,
        ),
      ],
    );
  }

  /// 5. Recent Activity Feed
  Widget _buildRecentActivity(BuildContext context, AppState appState) {
    final activities = [
      {
        'title': appState.isEnglish ? 'Bazaar Expense - Chicken & Eggs' : 'বাজারের খরচ - মুরগি ও ডিম',
        'person': 'তানভীর আহমেদ',
        'amount': '-৳১২৫০.০০',
        'time': appState.isEnglish ? 'Today, 1:30 PM' : 'আজ, দুপুর ১:৩০',
        'icon': Icons.shopping_cart_rounded,
        'color': AppColors.coral,
      },
      {
        'title': appState.isEnglish ? 'Mess Deposit Payment' : 'মেস ফি জমা প্রদান',
        'person': 'সাকিব হাসান',
        'amount': '+৳৩০০০.০০',
        'time': appState.isEnglish ? 'Yesterday, 7:15 PM' : 'গতকাল, সন্ধ্যা ৭:১৫',
        'icon': Icons.add_card_rounded,
        'color': AppColors.accent,
      },
      {
        'title': appState.isEnglish ? 'Lunch Meal Update' : 'আজকের দুপুরের মিল আপডেট',
        'person': 'মোঃ রায়হান (ম্যানেজার)',
        'amount': '৪ টি মিল',
        'time': appState.isEnglish ? 'Yesterday, 12:00 PM' : 'গতকাল, দুপুর ১২:০০',
        'icon': Icons.restaurant_menu_rounded,
        'color': AppColors.primary,
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: activities.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = activities[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: appState.isDarkMode ? AppColors.darkBorder : AppColors.border,
              width: 0.8,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (item['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${item['person']} • ${item['time']}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                item['amount'] as String,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: (item['amount'] as String).startsWith('+')
                      ? AppColors.accent
                      : ((item['amount'] as String).startsWith('-')
                          ? AppColors.coral
                          : Theme.of(context).textTheme.bodyLarge?.color),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Custom Modern Stat Card Component with Fitted Text
class _ModernStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final LinearGradient gradient;

  const _ModernStatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppState.instance.isDarkMode ? AppColors.darkBorder : AppColors.border,
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 14),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
