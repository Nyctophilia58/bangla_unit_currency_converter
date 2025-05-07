double convertHeight(double value, String from, String to) {
  const meters = {
    'Feet': 0.3048,
    'Meters': 1.0,
    'Inches': 0.0254,
    'Centimeters': 0.01,
  };
  return value * meters[from]! / meters[to]!;
}
