// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Магазин';

  @override
  String get addToCart => 'Добавить';

  @override
  String get cart => 'Корзина';

  @override
  String get total => 'Итого';

  @override
  String get checkout => 'Оформить заказ';

  @override
  String get darkTheme => 'Тёмная тема';

  @override
  String get language => 'Язык';

  @override
  String get menu => 'Меню';

  @override
  String get search => 'Поиск';

  @override
  String get goToCart => 'Перейти в корзину';

  @override
  String get added => 'Товар добавлен в корзину';
}
