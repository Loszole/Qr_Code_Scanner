import 'package:flutter/material.dart';
import 'generater_detail_screen.dart';
import 'setting_screen.dart';

class GenerateScreen extends StatelessWidget {
  const GenerateScreen({super.key});

  void _openDetail(BuildContext context, String type) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GenerateDetailScreen(type: type),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFF232323);
    // final accent = const Color(0xFFFFC107); // Removed unused variable
    final iconColor = Colors.white;
    final items = [
      {'icon': Icons.text_fields, 'label': 'Text'},
      {'icon': Icons.language, 'label': 'Website'},
      {'icon': Icons.wifi, 'label': 'Wi-Fi'},
      {'icon': Icons.event, 'label': 'Event'},
      {'icon': Icons.person, 'label': 'Contact'},
      {'icon': Icons.business, 'label': 'Business'},
      {'icon': Icons.location_on, 'label': 'Location'},
      // {'icon': Icons.whatsapp, 'label': 'WhatsApp'},
      {'icon': Icons.email, 'label': 'Email'},
      {'icon': Icons.alternate_email, 'label': 'Twitter'},
      {'icon': Icons.camera_alt, 'label': 'Instagram'},
      {'icon': Icons.phone, 'label': 'Telephone'},
    ];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Text('Generate QR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingScreen()),
              );
            },
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, i) {
            final item = items[i];
            return GestureDetector(
              onTap: () => _openDetail(context, item['label'] as String),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF292929),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(31, 0, 0, 0),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'] as IconData, color: iconColor, size: 38),
                    const SizedBox(height: 12),
                    Text(
                      item['label'] as String,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Import the detail screen at the bottom to avoid circular import issues
