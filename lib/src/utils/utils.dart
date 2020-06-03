bool isNumeric(String value) {
  if (value.isEmpty) return false;

  final number = num.tryParse(value);
  return (number != null) ? true : false;
}

String trimString (String value){
  return value.trim();
}

