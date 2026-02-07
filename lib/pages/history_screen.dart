import 'package:flutter/material.dart';
import 'scan_history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // Move variables inside the State class
  int _tabIndex = 0;

  void _openSettings() {
    Navigator.of(context).pushNamed('/settings');
  }

  void _deleteItem(int index) {
    ScanHistory().removeAt(index);
    // ScanHistory should ideally extend ChangeNotifier for AnimatedBuilder to work
    setState(() {}); 
  }

  // Helper methods moved out of build()
  String _monthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour;
    final ampm = dt.hour >= 12 ? 'pm' : 'am';
    final min = dt.minute.toString().padLeft(2, '0');
    return '$hour:$min $ampm';
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF232323);
    const accent = Color(0xFFFFC107);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text('History', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: _openSettings,
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Switcher
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildTab(0, 'Scan', accent),
                const SizedBox(width: 8),
                _buildTab(1, 'Create', accent),
              ],
            ),
          ),
          // List Area
          Expanded(
            child: AnimatedBuilder(
              animation: ScanHistory(), // Ensure ScanHistory extends ChangeNotifier
              builder: (context, _) {
                final allEntries = ScanHistory().entries;
                final entries = allEntries.where((e) =>
                  (_tabIndex == 0 && (e.type == 'Scan' || e.type == 'Data')) ||
                  (_tabIndex == 1 && e.type == 'Create')
                ).toList();
                if (entries.isEmpty) {
                  return const Center(
                    child: Text('No history yet.', 
                      style: TextStyle(color: Colors.white54)),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  itemCount: entries.length,
                  itemBuilder: (context, i) {
                    final item = entries[i];
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF292929),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Icon(Icons.qr_code, color: accent, size: 28),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.value,
                                  style: const TextStyle(
                                    color: Colors.white, 
                                    fontWeight: FontWeight.w600, 
                                    fontSize: 15
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text(
                                      item.type,
                                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${item.dateTime.day.toString().padLeft(2, '0')} '
                                      '${_monthName(item.dateTime.month)} ${item.dateTime.year}, '
                                      '${_formatTime(item.dateTime)}',
                                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: accent, size: 24),
                            onPressed: () => _deleteItem(i),
                            tooltip: 'Delete',
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Refactored Tab building logic for cleaner code
  Widget _buildTab(int index, String label, Color accent) {
    final isSelected = _tabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tabIndex = index),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: isSelected ? accent : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: accent, width: 2),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : accent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}