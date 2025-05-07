double convertTime(double value, String from, String to) {
  const seconds = {
    'Seconds': 1.0,
    'Minutes': 60.0,
    'Hours': 3600.0,
    'Days': 86400.0,
  };
  return value * seconds[from]! / seconds[to]!;
}
