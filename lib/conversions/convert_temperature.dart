double convertTemperature(double value, String from, String to) {
  if (from == to) return value;

  double celsius;
  if (from == 'Celsius') celsius = value;
  else if (from == 'Fahrenheit') celsius = (value - 32) * 5 / 9;
  else celsius = value - 273.15;

  if (to == 'Celsius') return celsius;
  else if (to == 'Fahrenheit') return (celsius * 9 / 5) + 32;
  else return celsius + 273.15;
}