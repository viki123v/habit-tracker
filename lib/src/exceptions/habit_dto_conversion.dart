class HabitDtoConversionException implements Exception{
  final String _msg; 
  String get msg => _msg;

  const HabitDtoConversionException({required this._msg});
}