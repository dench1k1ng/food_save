import 'package:flutter/material.dart';
import 'package:food_save/core/theme/app_colors.dart';
import 'package:food_save/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:food_save/core/theme/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  final String selectedLanguage;
  final Function(String) onLanguageChanged;

  const SettingsPage({
    Key? key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizations = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDarkMode ? AppColors.darkBackground : AppColors.background,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: Text(
              localizations.darkTheme, // локализованный текст
              style: TextStyle(
                color: isDarkMode ? AppColors.darkText : AppColors.textDark,
              ),
            ),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text(
              localizations.language,
              style: TextStyle(
                color: isDarkMode ? AppColors.darkText : AppColors.textDark,
              ),
            ),
            subtitle: Text(
              widget.selectedLanguage,
              style: TextStyle(
                color:
                    isDarkMode ? AppColors.darkTextLight : AppColors.textLight,
              ),
            ),
            trailing: const Icon(Icons.arrow_drop_down),
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor:
                    isDarkMode ? AppColors.darkCard : AppColors.card,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text('Русский'),
                        onTap: () {
                          widget.onLanguageChanged('Русский');
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text('English'),
                        onTap: () {
                          widget.onLanguageChanged('English');
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
