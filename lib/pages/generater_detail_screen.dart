import 'package:flutter/material.dart';
import 'models.dart';
import 'preview_screen.dart';
import 'scan_history.dart';

class GenerateDetailScreen extends StatefulWidget {
  final String type;
  const GenerateDetailScreen({super.key, required this.type});

  @override
  State<GenerateDetailScreen> createState() => _GenerateDetailScreenState();
}

class _GenerateDetailScreenState extends State<GenerateDetailScreen> {
  static const accent = Color(0xFFFFC107);
  static const bgColor = Color(0xFF232323);

  // Controllers for all possible fields
  final _controllers = <String, TextEditingController>{};

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _ctrl(String key) => _controllers.putIfAbsent(key, () => TextEditingController());

  IconData _iconForType(String t) {
    switch (t) {
      case 'Business': return Icons.business;
      // case 'WhatsApp': return Icons.whatsapp;
      case 'Twitter': return Icons.alternate_email;
      case 'Email': return Icons.email;
      case 'Instagram': return Icons.camera_alt;
      case 'Text': return Icons.text_fields;
      case 'Website': return Icons.language;
      case 'Wi-Fi': return Icons.wifi;
      case 'Event': return Icons.event;
      case 'Contact': return Icons.person;
      case 'Location': return Icons.location_on;
      case 'Telephone': return Icons.phone;
      default: return Icons.qr_code;
    }
  }

  List<Widget> _fieldsForType(BuildContext context) {
    InputDecoration deco(String hint) => InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFF232323),
      hintStyle: const TextStyle(color: Colors.white54),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: accent, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );

    switch (widget.type) {
      case 'Business':
        return [
          Row(
            children: [
              Expanded(child: TextField(controller: _ctrl('companyName'), decoration: deco('Company Name'))),
              const SizedBox(width: 12),
              Expanded(child: TextField(controller: _ctrl('industry'), decoration: deco('Industry'))),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: TextField(controller: _ctrl('phone'), decoration: deco('Enter phone'))),
              const SizedBox(width: 12),
              Expanded(child: TextField(controller: _ctrl('email'), decoration: deco('Enter email'))),
            ],
          ),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('website'), decoration: deco('Enter website')),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('address'), decoration: deco('Enter address')),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: TextField(controller: _ctrl('city'), decoration: deco('Enter city'))),
              const SizedBox(width: 12),
              Expanded(child: TextField(controller: _ctrl('country'), decoration: deco('Enter country'))),
            ],
          ),
        ];
      case 'WhatsApp':
        return [TextField(controller: _ctrl('number'), decoration: deco('WhatsApp Number'))];
      case 'Twitter':
        return [TextField(controller: _ctrl('username'), decoration: deco('Enter twitter username'))];
      case 'Email':
        return [TextField(controller: _ctrl('email'), decoration: deco('Enter email address'))];
      case 'Instagram':
        return [TextField(controller: _ctrl('username'), decoration: deco('Enter Instagram username'))];
      case 'Text':
        return [TextField(controller: _ctrl('text'), decoration: deco('Text'))];
      case 'Website':
        return [TextField(controller: _ctrl('url'), decoration: deco('Website URL'))];
      case 'Wi-Fi':
        return [
          TextField(controller: _ctrl('network'), decoration: deco('Network')),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('password'), decoration: deco('Password')),
        ];
      case 'Event':
        return [
          TextField(controller: _ctrl('name'), decoration: deco('Event Name')),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('startDateTime'), decoration: deco('Start Date and Time')),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('endDateTime'), decoration: deco('End Date and Time')),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('location'), decoration: deco('Event Location')),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('description'), decoration: deco('Description')),
        ];
      case 'Contact':
        return [
          Row(
            children: [
              Expanded(child: TextField(controller: _ctrl('firstName'), decoration: deco('First Name'))),
              const SizedBox(width: 12),
              Expanded(child: TextField(controller: _ctrl('lastName'), decoration: deco('Last Name'))),
            ],
          ),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('company'), decoration: deco('Company')),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('job'), decoration: deco('Job')),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: TextField(controller: _ctrl('phone'), decoration: deco('Phone'))),
              const SizedBox(width: 12),
              Expanded(child: TextField(controller: _ctrl('email'), decoration: deco('Email'))),
            ],
          ),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('website'), decoration: deco('Website')),
          const SizedBox(height: 12),
          TextField(controller: _ctrl('address'), decoration: deco('Address')),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: TextField(controller: _ctrl('city'), decoration: deco('City'))),
              const SizedBox(width: 12),
              Expanded(child: TextField(controller: _ctrl('country'), decoration: deco('Country'))),
            ],
          ),
        ];
      case 'Location':
        return [TextField(controller: _ctrl('location'), decoration: deco('Location'))];
      case 'Telephone':
        return [TextField(controller: _ctrl('phoneNumber'), decoration: deco('Phone number'))];
      default:
        return [TextField(controller: _ctrl('value'), decoration: deco('Value'))];
    }
  }

  void _onGenerate() {
    final t = widget.type;
    dynamic model;
    String qrData = '';
    switch (t) {
      case 'Business':
        model = BusinessQR(
          companyName: _ctrl('companyName').text,
          industry: _ctrl('industry').text,
          phone: _ctrl('phone').text,
          email: _ctrl('email').text,
          website: _ctrl('website').text,
          address: _ctrl('address').text,
          city: _ctrl('city').text,
          country: _ctrl('country').text,
        );
        qrData = '${model.companyName}\n${model.industry}\n${model.phone}\n${model.email}\n${model.website}\n${model.address}\n${model.city}\n${model.country}';
        break;
      case 'WhatsApp':
        model = WhatsAppQR(number: _ctrl('number').text);
        qrData = 'https://wa.me/${model.number}';
        break;
      case 'Twitter':
        model = TwitterQR(username: _ctrl('username').text);
        qrData = 'https://twitter.com/${model.username}';
        break;
      case 'Email':
        model = EmailQR(email: _ctrl('email').text);
        qrData = 'mailto:${model.email}';
        break;
      case 'Instagram':
        model = InstagramQR(username: _ctrl('username').text);
        qrData = 'https://instagram.com/${model.username}';
        break;
      case 'Text':
        model = TextQR(text: _ctrl('text').text);
        qrData = model.text;
        break;
      case 'Website':
        model = WebsiteQR(url: _ctrl('url').text);
        qrData = model.url;
        break;
      case 'Wi-Fi':
        model = WifiQR(network: _ctrl('network').text, password: _ctrl('password').text);
        qrData = 'WIFI:S:${model.network};T:WPA;P:${model.password};;';
        break;
      case 'Event':
        model = EventQR(
          name: _ctrl('name').text,
          startDateTime: DateTime.tryParse(_ctrl('startDateTime').text) ?? DateTime.now(),
          endDateTime: DateTime.tryParse(_ctrl('endDateTime').text) ?? DateTime.now(),
          location: _ctrl('location').text,
          description: _ctrl('description').text,
        );
        qrData = '${model.name}\n${model.startDateTime}\n${model.endDateTime}\n${model.location}\n${model.description}';
        break;
      case 'Contact':
        model = ContactQR(
          firstName: _ctrl('firstName').text,
          lastName: _ctrl('lastName').text,
          company: _ctrl('company').text,
          job: _ctrl('job').text,
          phone: _ctrl('phone').text,
          email: _ctrl('email').text,
          website: _ctrl('website').text,
          address: _ctrl('address').text,
          city: _ctrl('city').text,
          country: _ctrl('country').text,
        );
        qrData = '${model.firstName} ${model.lastName}\n${model.company}\n${model.job}\n${model.phone}\n${model.email}\n${model.website}\n${model.address}\n${model.city}\n${model.country}';
        break;
      case 'Location':
        model = TextQR(text: _ctrl('location').text);
        qrData = model.text;
        break;
      case 'Telephone':
        model = PhoneQR(phoneNumber: _ctrl('phoneNumber').text);
        qrData = model.phoneNumber;
        break;
      default:
        model = TextQR(text: _ctrl('value').text);
        qrData = model.text;
    }
    // Save created QR to history as 'Create'
    try {
      // Import ScanHistory at the top if not already
      // ignore: unused_import
      
    } catch (_) {}
    // Actually add to ScanHistory
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    // (for hot reload safety)
    // Add to history
    // Use add method from ScanHistory singleton
    // (import is at the top in real code)
    // Add to history
    // ignore: undefined_prefixed_name
    ScanHistory().add(qrData, type: 'Create');
    // Navigate to preview screen with qrData
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PreviewScreen(data: qrData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.type, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
          child: Card(
            color: const Color(0xFF232323),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: accent, width: 2),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_iconForType(widget.type), color: accent, size: 48),
                  const SizedBox(height: 18),
                  ..._fieldsForType(context),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      onPressed: _onGenerate,
                      child: const Text('Generate QR Code'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}