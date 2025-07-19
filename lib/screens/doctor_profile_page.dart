import 'package:flutter/material.dart';

class DoctorProfilePage extends StatelessWidget {
  final Map<String, dynamic> doctor;
  const DoctorProfilePage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Profile'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 12 : 32),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: isMobile ? 48 : 60,
                        backgroundImage: NetworkImage(doctor['image'] ?? ''),
                      ),
                      SizedBox(height: 16),
                      Text(
                        doctor['name'] ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 22 : 26, color: Colors.blue[800]),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        doctor['specialty'] ?? '',
                        style: TextStyle(fontSize: isMobile ? 16 : 18, color: Colors.blueGrey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                // Contact Information
                Text('Contact Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 17 : 20, color: Colors.blue[900])),
                SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 12 : 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Text(doctor['phone'] ?? '', style: TextStyle(fontSize: isMobile ? 14 : 16)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Expanded(child: Text(doctor['email'] ?? '', style: TextStyle(fontSize: isMobile ? 14 : 16))),
                          ],
                        ),
                        if (doctor['location'] != null) ...[
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.blue, size: 20),
                              SizedBox(width: 8),
                              Expanded(child: Text(doctor['location'], style: TextStyle(fontSize: isMobile ? 14 : 16))),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18),
                // Education & Languages
                Text('Education & Languages', style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 17 : 20, color: Colors.blue[900])),
                SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 12 : 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.school, color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Text('Education', style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(width: 8),
                            Expanded(child: Text(doctor['education'] ?? '', style: TextStyle(fontSize: isMobile ? 14 : 16))),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.language, color: Colors.blue, size: 20),
                            SizedBox(width: 8),
                            Text('Languages', style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(width: 8),
                            Expanded(child: Text((doctor['languages'] as List?)?.join(', ') ?? '', style: TextStyle(fontSize: isMobile ? 14 : 16))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18),
                // About
                Text('About', style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 17 : 20, color: Colors.blue[900])),
                SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 12 : 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info, color: Colors.blue, size: 20),
                        SizedBox(width: 8),
                        Expanded(child: Text(doctor['about'] ?? '', style: TextStyle(fontSize: isMobile ? 14 : 16))),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18),
                // Services Offered
                Text('Services Offered', style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 17 : 20, color: Colors.blue[900])),
                SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 12 : 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var service in (doctor['services'] as List? ?? []))
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Row(
                              children: [
                                Icon(Icons.medical_services, color: Colors.blue, size: 18),
                                SizedBox(width: 8),
                                Expanded(child: Text(service, style: TextStyle(fontSize: isMobile ? 14 : 16))),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18),
                // Working Hours
                if (doctor['workingHours'] != null) ...[
                  Text('Working Hours', style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 17 : 20, color: Colors.blue[900])),
                  SizedBox(height: 8),
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(isMobile ? 12 : 18),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.blue, size: 20),
                          SizedBox(width: 8),
                          Expanded(child: Text(doctor['workingHours'], style: TextStyle(fontSize: isMobile ? 14 : 16))),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 