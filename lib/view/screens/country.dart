class Country {
  String name;
  List<String> cities;
  Country(this.name, this.cities);
}

List<Country> countries = [
  Country('فلسطين', ['غزة', 'رفح', 'خانيونس', 'دير البلح', 'النصيرات']),
  Country('السعودية', ['جدة', 'الدمام', 'مكة', 'الطائف', 'ام قرص']),
  Country('الامارات', ['دبي', 'عجمان', 'الشارقة']),
];
