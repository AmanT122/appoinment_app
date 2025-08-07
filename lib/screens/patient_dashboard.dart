import 'package:appoinment_app/screens/doctor_details.dart';
import 'package:flutter/material.dart';

class PatientDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: HealthDashboard(),
    );
  }
}

class HealthDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/patient_avatar.png'),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Aman Tiwari', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Patient ID: PX458792', style: TextStyle(fontSize: 12)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: 20, color: Colors.blue[700]),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text('8RWV+7XH, near Bassein Catholic Bank, Virar West',
                          style: TextStyle(fontSize: 14)),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Symptoms Section
            Text('Your Symptoms', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _SymptomChip(label: 'Chest Pain', icon: Icons.favorite_border, active: true),
                _SymptomChip(label: 'Headache', icon: Icons.psychology_outlined),
                _SymptomChip(label: 'Knee Pain', icon: Icons.directions_run_outlined),
                _SymptomChip(label: 'Add +', icon: Icons.add),
              ],
            ),
            
            SizedBox(height: 24),
            
            // Upcoming Appointment
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Upcoming Appointment', style: Theme.of(context).textTheme.headlineSmall),
                TextButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/appointments');
                  },
                  child: Text('View All', style: TextStyle(color: Colors.blue[700])),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[50]!, Colors.blue[100]!],
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/doctor1.jpg'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dr. Abhineet Pardesi', 
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('Orthopaedic Specialist', 
                            style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 16, color: Colors.blue[700]),
                            SizedBox(width: 4),
                            Text('Monday, 22 July', style: TextStyle(fontSize: 12)),
                            SizedBox(width: 16),
                            Icon(Icons.access_time, size: 16, color: Colors.blue[700]),
                            SizedBox(width: 4),
                            Text('10:00 AM', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
            
            SizedBox(height: 24),
            
            // Specialists Section
            Text('Specialists', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _SpecialistCard(
                    icon: Icons.healing, 
                    title: 'Orthopaedic',
                    color: Colors.orange[100]!,
                    iconColor: Colors.orange[800]!,
                  ),
                  _SpecialistCard(
                    icon: Icons.favorite, 
                    title: 'Cardiologist',
                    color: Colors.red[100]!,
                    iconColor: Colors.red[800]!,
                  ),
                  _SpecialistCard(
                    icon: Icons.child_care, 
                    title: 'Pediatrician',
                    color: Colors.blue[100]!,
                    iconColor: Colors.blue[800]!,
                  ),
                  _SpecialistCard(
                    icon: Icons.psychology, 
                    title: 'Psychiatrist',
                    color: Colors.purple[100]!,
                    iconColor: Colors.purple[800]!,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24),
            
            // Doctors Nearby Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Doctors Near You', style: Theme.of(context).textTheme.headlineSmall),
                TextButton(
                  onPressed: () {
             },
                  child: Text('View All', style: TextStyle(color: Colors.blue[700])),
                ),
              ],
            ),
            SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
              GestureDetector(
      onTap: () {
        // Navigate to the doctor details screen when tapped
         Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DoctorDetails(
        
      ),
    ),
  );
      },
      child: _DoctorCard(
        doctorName: 'Dr. Avani', 
        specialization: 'Orthopaedic', 
        distance: '2.2 km',
        image: 'assets/doctor2.jpg',
      ),
    ),
    GestureDetector(
      onTap: () {
        // Navigate to the doctor details screen when tapped
         Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DoctorDetails(
        
      ),
    ),
  );
      },
      child: _DoctorCard(
        doctorName: 'Dr. Murarskar', 
        specialization: 'Naturopathy', 
        distance: '1.5 km',
        image: 'assets/doctor3.jpg',
      ),
    ),
    GestureDetector(
      onTap: () {
        // Navigate to the doctor details screen when tapped
         Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DoctorDetails(
        
      ),
    ),
  );
      },
      child: _DoctorCard(
        doctorName: 'Dr. Kamal', 
        specialization: 'Dentist', 
        distance: '3.1 km',
        image: 'assets/doctor4.jpg',
      ),
    ),
    GestureDetector(
      onTap: () {
        // Navigate to the doctor details screen when tapped
          Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DoctorDetails(
        
      ),
    ),
  );
      },
      child: _DoctorCard(
        doctorName: 'Dr. Sharma', 
        specialization: 'General Physician', 
        distance: '0.8 km',
        image: 'assets/doctor5.jpg',
      ),
    ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class _SymptomChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;

  _SymptomChip({required this.label, required this.icon, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Colors.blue[50] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: active ? Colors.blue : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: active ? Colors.blue : Colors.grey),
          SizedBox(width: 4),
          Text(label, style: TextStyle(
            fontSize: 14,
            color: active ? Colors.blue : Colors.black,
          )),
        ],
      ),
    );
  }
}

class _SpecialistCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final Color iconColor;

  _SpecialistCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: iconColor),
          ),
          SizedBox(height: 8),
          Text(title, 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          SizedBox(height: 4),
          Text('12 Doctors', 
              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        ],
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final String distance;
  final String image;

  _DoctorCard({
    required this.doctorName,
    required this.specialization,
    required this.distance,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundImage: AssetImage(image),
            ),
            SizedBox(height: 12),
            Text(doctorName, 
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(specialization, 
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey),
                SizedBox(width: 4),
                Text(distance, 
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}