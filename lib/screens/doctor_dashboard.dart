import 'package:flutter/material.dart';
import 'dart:async';
import 'doctor_profile_page.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  final List<Map<String, dynamic>> todayAppointments = [
    {
      'patientName': 'Sarah Johnson',
      'time': '9:00 AM',
      'type': 'Follow-up',
      'status': 'Confirmed',
      'patientImage': 'https://randomuser.me/api/portraits/women/32.jpg',
      'age': '28',
      'gender': 'Female',
      'symptoms': 'Chest pain, shortness of breath',
    },
    {
      'patientName': 'Michael Chen',
      'time': '10:30 AM',
      'type': 'New Patient',
      'status': 'Confirmed',
      'patientImage': 'https://randomuser.me/api/portraits/men/45.jpg',
      'age': '35',
      'gender': 'Male',
      'symptoms': 'High blood pressure, headaches',
    },
    {
      'patientName': 'Emily Davis',
      'time': '2:00 PM',
      'type': 'Emergency',
      'status': 'Pending',
      'patientImage': 'https://randomuser.me/api/portraits/women/67.jpg',
      'age': '42',
      'gender': 'Female',
      'symptoms': 'Severe abdominal pain',
    },
    {
      'patientName': 'Robert Wilson',
      'time': '3:30 PM',
      'type': 'Routine Check',
      'status': 'Confirmed',
      'patientImage': 'https://randomuser.me/api/portraits/men/23.jpg',
      'age': '55',
      'gender': 'Male',
      'symptoms': 'Annual physical examination',
    },
  ];

  final List<Map<String, dynamic>> recentPatients = [
    {
      'name': 'Sarah Johnson',
      'lastVisit': '2 days ago',
      'nextAppointment': 'Today 9:00 AM',
      'image': 'https://randomuser.me/api/portraits/women/32.jpg',
      'condition': 'Hypertension',
      'medications': ['Lisinopril', 'Amlodipine'],
    },
    {
      'name': 'Michael Chen',
      'lastVisit': '1 week ago',
      'nextAppointment': 'Today 10:30 AM',
      'image': 'https://randomuser.me/api/portraits/men/45.jpg',
      'condition': 'Diabetes Type 2',
      'medications': ['Metformin', 'Glipizide'],
    },
    {
      'name': 'Emily Davis',
      'lastVisit': '3 days ago',
      'nextAppointment': 'Today 2:00 PM',
      'image': 'https://randomuser.me/api/portraits/women/67.jpg',
      'condition': 'Asthma',
      'medications': ['Albuterol', 'Fluticasone'],
    },
  ];

  final List<Map<String, dynamic>> medicalTools = [
    {
      'name': 'Patient Records',
      'icon': Icons.folder,
      'color': Colors.blue,
      'description': 'Access patient medical history',
    },
    {
      'name': 'Prescriptions',
      'icon': Icons.medication,
      'color': Colors.green,
      'description': 'Write and manage prescriptions',
    },
    {
      'name': 'Lab Results',
      'icon': Icons.science,
      'color': Colors.orange,
      'description': 'View laboratory test results',
    },
    {
      'name': 'Imaging',
      'icon': Icons.photo_camera,
      'color': Colors.purple,
      'description': 'X-rays, MRIs, and scans',
    },
    {
      'name': 'Referrals',
      'icon': Icons.people,
      'color': Colors.red,
      'description': 'Refer patients to specialists',
    },
    {
      'name': 'Notes',
      'icon': Icons.note_add,
      'color': Colors.teal,
      'description': 'Clinical notes and observations',
    },
  ];

  final List<Map<String, dynamic>> quickStats = [
    {
      'title': 'Today\'s Appointments',
      'value': '8',
      'icon': Icons.calendar_today,
      'color': Colors.blue,
    },
    {
      'title': 'Pending Reports',
      'value': '3',
      'icon': Icons.assignment,
      'color': Colors.orange,
    },
    {
      'title': 'Emergency Cases',
      'value': '1',
      'icon': Icons.emergency,
      'color': Colors.red,
    },
    {
      'title': 'Messages',
      'value': '12',
      'icon': Icons.message,
      'color': Colors.green,
    },
  ];

  final ScrollController _appointmentScrollController = ScrollController();
  final ScrollController _patientScrollController = ScrollController();
  Timer? _appointmentAutoScrollTimer;
  Timer? _patientAutoScrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll(_appointmentScrollController, todayAppointments.length, (timer) => _appointmentAutoScrollTimer = timer);
    _startAutoScroll(_patientScrollController, recentPatients.length, (timer) => _patientAutoScrollTimer = timer);
  }

  void _startAutoScroll(ScrollController controller, int itemCount, void Function(Timer) setTimer) {
    setTimer(Timer.periodic(Duration(seconds: 4), (timer) {
      if (!controller.hasClients) return;
      double maxScroll = controller.position.maxScrollExtent;
      double current = controller.offset;
      double cardWidth = MediaQuery.of(context).size.width * 0.8 + 20;
      double next = current + cardWidth;
      
      if (next >= maxScroll) {
        controller.animateTo(0, duration: Duration(milliseconds: 800), curve: Curves.easeOut);
      } else {
        controller.animateTo(next, duration: Duration(milliseconds: 800), curve: Curves.easeOut);
      }
    }));
  }

  @override
  void dispose() {
    _appointmentAutoScrollTimer?.cancel();
    _patientAutoScrollTimer?.cancel();
    _appointmentScrollController.dispose();
    _patientScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isDesktop = width >= 1024;
    final cardWidth = isMobile ? width * 0.8 : isTablet ? width * 0.45 : 350.0;

    int quickStatsCrossAxisCount = isDesktop ? 4 : isTablet ? 3 : 2;
    double quickStatsAspectRatio = isMobile ? 1.2 : isTablet ? 2.0 : 2.5;
    int toolsCrossAxisCount = isDesktop ? 4 : isTablet ? 3 : 2;
    double toolsAspectRatio = isMobile ? 1.2 : 1.5;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorProfilePage(
                        doctor: {
                          'name': 'Dr. Sarah Lee',
                          'specialty': 'Cardiologist',
                          'image': 'https://randomuser.me/api/portraits/women/44.jpg',
                          'email': 'sarah.lee@medical.com',
                          'phone': '+1 (555) 123-4567',
                          'about': 'Experienced cardiologist with 10+ years in patient care.',
                        },
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
                    ),
                    SizedBox(height: 12),
                    Text('Dr. Sarah Lee', style: TextStyle(color: Colors.white, fontSize: 20)),
                    Text('Cardiologist', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Patients'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Appointments'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.medical_services),
              title: Text('Medical Records'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Doctor Dashboard'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You have 3 new notifications.')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You have 5 unread messages.')),
              );
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick Stats
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: quickStatsCrossAxisCount,
                      childAspectRatio: quickStatsAspectRatio,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: quickStats.length,
                    itemBuilder: (context, index) {
                      final stat = quickStats[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(isMobile ? 8 : 12),
                                decoration: BoxDecoration(
                                  color: stat['color'].withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(stat['icon'], color: stat['color'], size: isMobile ? 20 : 24),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      stat['value'],
                                      style: TextStyle(
                                        fontSize: isMobile ? 18 : 24,
                                        fontWeight: FontWeight.bold,
                                        color: stat['color'],
                                      ),
                                    ),
                                    Text(
                                      stat['title'],
                                      style: TextStyle(
                                        fontSize: isMobile ? 10 : 12,
                                        color: Colors.grey[600],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Today's Appointments
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    'Today\'s Appointments',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                ),
                SizedBox(
                  height: isMobile ? 260 : 220,
                  child: ListView.builder(
                    controller: _appointmentScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: todayAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = todayAppointments[index];
                      return AppointmentCard(appointment: appointment, width: cardWidth);
                    },
                  ),
                ),

                // Recent Patients
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    'Recent Patients',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                ),
                SizedBox(
                  height: isMobile ? 220 : 180,
                  child: ListView.builder(
                    controller: _patientScrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: recentPatients.length,
                    itemBuilder: (context, index) {
                      final patient = recentPatients[index];
                      return PatientCard(patient: patient, width: cardWidth);
                    },
                  ),
                ),

                // Medical Tools
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                  child: Text(
                    'Medical Tools',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: toolsCrossAxisCount,
                      childAspectRatio: toolsAspectRatio,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: medicalTools.length,
                    itemBuilder: (context, index) {
                      final tool = medicalTools[index];
                      return MedicalToolCard(tool: tool);
                    },
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Map<String, dynamic> appointment;
  final double width;

  const AppointmentCard({super.key, required this.appointment, required this.width});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: width,
      margin: EdgeInsets.only(left: 20, right: 8, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 10.0 : 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(appointment['patientImage']),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['patientName'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue[800],
                        ),
                      ),
                      Text(
                        '${appointment['age']} years, ${appointment['gender']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: appointment['status'] == 'Confirmed' ? Colors.green[50] : Colors.orange[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: appointment['status'] == 'Confirmed' ? Colors.green[200]! : Colors.orange[200]!,
                    ),
                  ),
                  child: Text(
                    appointment['status'],
                    style: TextStyle(
                      fontSize: 10,
                      color: appointment['status'] == 'Confirmed' ? Colors.green[600] : Colors.orange[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.blue, size: 16),
                SizedBox(width: 4),
                Text(
                  appointment['time'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[700],
                  ),
                ),
                SizedBox(width: 16),
                Icon(Icons.category, color: Colors.grey[600], size: 16),
                SizedBox(width: 4),
                Text(
                  appointment['type'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              'Symptoms: ${appointment['symptoms']}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Starting consultation with ${appointment['patientName']}')),
                        );
                      },
                      child: Text('Start Consultation', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Viewing medical records for ${appointment['patientName']}')),
                        );
                      },
                      child: Text('View Records', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  final Map<String, dynamic> patient;
  final double width;

  const PatientCard({super.key, required this.patient, required this.width});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      width: width,
      margin: EdgeInsets.only(left: 20, right: 8, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 10.0 : 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(patient['image']),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue[800],
                        ),
                      ),
                      Text(
                        'Last visit: ${patient['lastVisit']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Condition: ${patient['condition']}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Medications: ${patient['medications'].join(', ')}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4),
            Text(
              'Next: ${patient['nextAppointment']}',
              style: TextStyle(
                fontSize: 11,
                color: Colors.blue[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Flexible(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Viewing full profile for ${patient['name']}')),
                        );
                      },
                      child: Text('View Profile', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sending message to ${patient['name']}')),
                        );
                      },
                      child: Text('Message', style: TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MedicalToolCard extends StatelessWidget {
  final Map<String, dynamic> tool;

  const MedicalToolCard({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening ${tool['name']}')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 10.0 : 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(isMobile ? 10 : 16),
                decoration: BoxDecoration(
                  color: tool['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  tool['icon'],
                  color: tool['color'],
                  size: isMobile ? 28 : 32,
                ),
              ),
              SizedBox(height: 8),
              Text(
                tool['name'],
                style: TextStyle(
                  fontSize: isMobile ? 13 : 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2),
              Text(
                tool['description'],
                style: TextStyle(
                  fontSize: isMobile ? 10 : 11,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 