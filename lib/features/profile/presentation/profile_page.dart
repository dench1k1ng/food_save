import 'package:flutter/material.dart';
import 'package:food_save/core/theme/theme_provider.dart';
import 'package:food_save/core/widgets/avatar_widget.dart';
import 'package:food_save/features/settings/presentation/settings_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;

  ProfilePage({required this.name, required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _avatar;
  late String _name;
  late String _email;
  String _address = "г. Москва, ул. Примерная, д. 1";
  bool _isDarkMode = false;
  String _selectedLanguage = "Русский";

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _email = widget.email;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _avatar = File(pickedFile.path);
      });
    }
  }

  void _editField(String field, String initialValue, Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Редактировать $field"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Отмена"),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: Text("Сохранить"),
          ),
        ],
      ),
    );
  }

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SettingsPage(
          selectedLanguage: _selectedLanguage,
          onLanguageChanged: (language) {
            setState(() {
              _selectedLanguage = language;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Профиль"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarWidget(avatar: _avatar, onImagePicked: _pickImage),
              SizedBox(height: 20),
              Text(
                _name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                _email,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkMode
                      ? Colors.grey[900] // Темный фон в тёмной теме
                      : Colors.white, // Светлый фон в светлой теме
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Адрес",
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        _address,
                        style: TextStyle(
                          color: Provider.of<ThemeProvider>(context).isDarkMode
                              ? Colors.grey[400]
                              : Colors.black87,
                        ),
                      ),
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.green[700],
                      ),
                      onTap: () => _editField("Адрес", _address, (value) {
                        setState(() {
                          _address = value;
                        });
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: Icon(Icons.camera_alt),
                label: Text("Сделать фото"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
