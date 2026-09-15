import 'package:flutter/material.dart';

import '../../../../app/config/app_colors.dart';
import '../../../../core/providers/app_state_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppState.instance,
      builder: (context, _) {
        final appState = AppState.instance;
        final isDark = appState.isDarkMode;

        return Scaffold(
          appBar: AppBar(title: Text(appState.tr('profile_title'))),
          body: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 600));
            },
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                children: [
                  // User Profile Header with Image passport.png
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.primaryGradient,
                              ),
                              child: ClipOval(
                                child: SizedBox(
                                  width: 96,
                                  height: 96,
                                  child: Image.asset(
                                    'assets/images/passport.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const CircleAvatar(
                                        radius: 48,
                                        backgroundColor:
                                            AppColors.surfaceSubtle,
                                        child: Icon(
                                          Icons.person,
                                          size: 48,
                                          color: AppColors.primary,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppColors.accent,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          appState.isEnglish ? 'Md. Rayhan' : 'মোঃ রায়হান',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${appState.tr('manager')} • ${appState.tr('mess_name')}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Preference Settings Section (Dark Theme & Language Toggle)
                  _buildSettingsSection(
                    context: context,
                    title: appState.isEnglish
                        ? 'Preferences & Customization'
                        : 'পছন্দ ও কাস্টমাইজেশন',
                    items: [
                      _buildTile(
                        context,
                        icon: Icons.dark_mode_rounded,
                        title: appState.tr('dark_mode'),
                        subtitle: isDark
                            ? (appState.isEnglish
                                  ? 'Dark Theme Active'
                                  : 'ডার্ক মোড চালু')
                            : (appState.isEnglish
                                  ? 'Light Theme Active'
                                  : 'লাইট মোড চালু'),
                        trailing: Switch.adaptive(
                          value: isDark,
                          activeTrackColor: AppColors.primary,
                          onChanged: (val) {
                            appState.toggleTheme(val);
                          },
                        ),
                      ),
                      _buildTile(
                        context,
                        icon: Icons.translate_rounded,
                        title: appState.tr('language'),
                        subtitle: appState.isEnglish ? 'English' : 'বাংলা',
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextButton(
                            onPressed: () {
                              appState.toggleLanguage();
                            },
                            child: Text(
                              appState.isEnglish ? 'বাংলা' : 'English',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Mess Management Options
                  _buildSettingsSection(
                    context: context,
                    title: appState.isEnglish
                        ? 'Mess Management'
                        : 'মেস ম্যানেজমেন্ট',
                    items: [
                      _buildTile(
                        context,
                        icon: Icons.home_work_rounded,
                        title: appState.isEnglish
                            ? 'Mess Profile & Fees'
                            : 'মেস প্রোফাইল ও সদস্য ফি',
                        onTap: () {},
                      ),
                      _buildTile(
                        context,
                        icon: Icons.calculate_rounded,
                        title: appState.isEnglish
                            ? 'Meal Rate & Rules Settings'
                            : 'মিল রেট ও রুলস সেটিংস',
                        onTap: () {},
                      ),
                      _buildTile(
                        context,
                        icon: Icons.file_download_rounded,
                        title: appState.tr('download_report'),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Account & Logout Options
                  _buildSettingsSection(
                    context: context,
                    title: appState.isEnglish
                        ? 'Account & Security'
                        : 'অ্যাকাউন্ট ও নিরাপত্তা',
                    items: [
                      _buildTile(
                        context,
                        icon: Icons.notifications_active_rounded,
                        title: appState.isEnglish
                            ? 'Notifications & Reminders'
                            : 'নোটিফিকেশন ও রিমাইন্ডার',
                        onTap: () {},
                      ),
                      _buildTile(
                        context,
                        icon: Icons.lock_rounded,
                        title: appState.isEnglish
                            ? 'Change Password'
                            : 'পাসওয়ার্ড পরিবর্তন',
                        onTap: () {},
                      ),
                      _buildTile(
                        context,
                        icon: Icons.logout_rounded,
                        title: appState.tr('logout'),
                        color: AppColors.error,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingsSection({
    required BuildContext context,
    required String title,
    required List<Widget> items,
  }) {
    final isDark = AppState.instance.isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: isDark
                ? AppColors.darkTextSecondary
                : AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 10),
        Material(
          color: Theme.of(context).cardTheme.color,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isDark ? AppColors.darkBorder : AppColors.border,
              width: 0.8,
            ),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Color? color,
    Widget? trailing,
  }) {
    final isDark = AppState.instance.isDarkMode;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (color ?? AppColors.primary).withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color ?? AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color:
              color ??
              (isDark ? AppColors.darkTextPrimary : AppColors.textPrimary),
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
            )
          : null,
      trailing:
          trailing ??
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: isDark ? AppColors.darkTextSecondary : AppColors.textLight,
          ),
      onTap: onTap,
    );
  }
}
