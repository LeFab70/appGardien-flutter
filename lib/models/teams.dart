import 'package:country_picker/country_picker.dart';

class Teams {
  final String id;
  final String name;
  final String urlLogo;
  final String managerName;
  final Country country; //Lié au package country_picker

  Teams({
    required this.name,
    required this.id,
    required this.urlLogo,
    required this.managerName,
    required this.country,
  });
}
