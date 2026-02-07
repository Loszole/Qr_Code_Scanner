
// Phone QR
class PhoneQR {
  String phoneNumber;
  PhoneQR({required this.phoneNumber});
}

// Business QR
class BusinessQR {
  String companyName;
  String industry;
  String phone;
  String email;
  String website;
  String address;
  String city;
  String country;
  BusinessQR({
    required this.companyName,
    required this.industry,
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
    required this.city,
    required this.country,
  });
}

// WhatsApp QR
class WhatsAppQR {
  String number;
  WhatsAppQR({required this.number});
}

// Twitter QR
class TwitterQR {
  String username;
  TwitterQR({required this.username});
}

// Email QR
class EmailQR {
  String email;
  EmailQR({required this.email});
}

// Instagram QR
class InstagramQR {
  String username;
  InstagramQR({required this.username});
}

// Text QR
class TextQR {
  String text;
  TextQR({required this.text});
}

// Website QR
class WebsiteQR {
  String url;
  WebsiteQR({required this.url});
}

// Wi-Fi QR
class WifiQR {
  String network;
  String password;
  WifiQR({required this.network, required this.password});
}

// Event QR
class EventQR {
  String name;
  DateTime startDateTime;
  DateTime endDateTime;
  String location;
  String description;
  EventQR({
    required this.name,
    required this.startDateTime,
    required this.endDateTime,
    required this.location,
    required this.description,
  });
}

// Contact QR
class ContactQR {
  String firstName;
  String lastName;
  String company;
  String job;
  String phone;
  String email;
  String website;
  String address;
  String city;
  String country;
  ContactQR({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.job,
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
    required this.city,
    required this.country,
  });
}