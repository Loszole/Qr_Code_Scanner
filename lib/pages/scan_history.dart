import 'package:flutter/foundation.dart';

class ScanEntry {
  final String value;
  final String type;
  final DateTime dateTime;

  ScanEntry({required this.value, required this.type, required this.dateTime});
}

class ScanHistory extends ChangeNotifier {
  static final ScanHistory _instance = ScanHistory._internal();
  factory ScanHistory() => _instance;
  ScanHistory._internal();

  final List<ScanEntry> _entries = [];

  List<ScanEntry> get entries {
    // Only show the most recent scan for each unique value
    final seen = <String>{};
    final unique = <ScanEntry>[];
    for (final entry in _entries.reversed) {
      if (seen.add(entry.value)) {
        unique.add(entry);
      }
    }
    return unique;
  }

  void add(String value, {String type = 'Data'}) {
    _entries.add(ScanEntry(value: value, type: type, dateTime: DateTime.now()));
    notifyListeners();
  }

  void removeAt(int index) {
    if (index >= 0 && index < _entries.length) {
      _entries.removeAt(_entries.length - 1 - index); // reversed order
      notifyListeners();
    }
  }

  void clear() {
    _entries.clear();
    notifyListeners();
  }
}
