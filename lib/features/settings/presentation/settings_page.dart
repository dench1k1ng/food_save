import 'package:flutter/material.dart';
import 'package:food_save/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

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

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: Text("Тёмная тема"),
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          ListTile(
            title: Text("Язык"),
            subtitle: Text(widget.selectedLanguage),
            trailing: Icon(Icons.arrow_drop_down),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text("Русский"),
                        onTap: () {
                          widget.onLanguageChanged("Русский");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text("English"),
                        onTap: () {
                          widget.onLanguageChanged("English");
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
