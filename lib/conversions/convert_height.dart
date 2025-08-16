double convertHeight(double value, String from, String to) {
  const meters = {
    'feet': 0.3048,
    'meters': 1.0,
    'inches': 0.0254,
    'centimeters': 0.01,
  };
  return value * meters[from]! / meters[to]!;
}
