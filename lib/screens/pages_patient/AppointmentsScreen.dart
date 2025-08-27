import 'package:flutter/material.dart';

class Appointmentsscreen extends StatefulWidget {
  const Appointmentsscreen({super.key});

  @override
  State<Appointmentsscreen> createState() => _AppointmentsscreenState();
}

class _AppointmentsscreenState extends State<Appointmentsscreen> {
  int _selectedTab = 0; // 0: Upcoming, 1: Past

  // Sample appointment data
  final List<Map<String, dynamic>> _upcomingAppointments = [
    {
      'doctor': 'Dr. Sarah Johnson',
      'specialty': 'Cardiologist',
      'date': 'Today',
      'time': '2:30 PM',
      'clinic': 'City Heart Center',
      'address': '123 Medical Ave, Suite 405',
      'status': 'Confirmed',
      'statusColor': Colors.green,
      'image': 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'
    },
    {
      'doctor': 'Dr. Michael Chen',
      'specialty': 'Neurologist',
      'date': 'Tomorrow',
      'time': '10:00 AM',
      'clinic': 'NeuroCare Institute',
      'address': '456 Brain Street, Floor 2',
      'status': 'Scheduled',
      'statusColor': Colors.blue,
      'image': 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'
    },
    {
      'doctor': 'Dr. Emily Rodriguez',
      'specialty': 'Dermatologist',
      'date': 'Oct 25, 2023',
      'time': '4:15 PM',
      'clinic': 'Skin Health Center',
      'address': '789 Dermatology Lane',
      'status': 'Pending',
      'statusColor': Colors.orange,
      'image': 'https://images.unsplash.com/photo-1551601651-2a8555f1a136?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'
    },
  ];

  final List<Map<String, dynamic>> _pastAppointments = [
    {
      'doctor': 'Dr. James Wilson',
      'specialty': 'Orthopedist',
      'date': 'Oct 10, 2023',
      'time': '11:00 AM',
      'clinic': 'Bone & Joint Center',
      'address': '321 Ortho Street',
      'status': 'Completed',
      'statusColor': Colors.grey,
      'image': 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'
    },
    {
      'doctor': 'Dr. Lisa Park',
      'specialty': 'Dentist',
      'date': 'Sep 28, 2023',
      'time': '3:30 PM',
      'clinic': 'Bright Smile Dental',
      'address': '555 Tooth Avenue',
      'status': 'Completed',
      'statusColor': Colors.grey,
      'image': 'https://images.unsplash.com/photo-1622902046580-2b47f47f5471?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80'
    },
  ];

  // Function to handle booking a new appointment
  void _bookNewAppointment() {
    // Navigate to the booking screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BookingScreen(),
      ),
    ).then((value) {
      // This callback runs when you return from the booking screen
      // You could refresh appointments here if needed
      if (value != null && value == true) {
        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appointment booked successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment, bool isUpcoming) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(appointment['image']),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment['doctor'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        appointment['specialty'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: appointment['statusColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: appointment['statusColor'].withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    appointment['status'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: appointment['statusColor'],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Text(
                  appointment['date'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Text(
                  appointment['time'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    appointment['clinic'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (isUpcoming)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Reschedule action
                        _rescheduleAppointment(appointment);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: Text(
                        'Reschedule',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Cancel action
                        _cancelAppointment(appointment);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // View details action
                        _viewAppointmentDetails(appointment);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('View Details'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Book again action
                        _bookAgain(appointment);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Book Again'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Function to handle rescheduling an appointment
  void _rescheduleAppointment(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reschedule Appointment'),
          content: Text('Would you like to reschedule your appointment with ${appointment['doctor']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to rescheduling screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RescheduleScreen(appointment: appointment),
                  ),
                );
              },
              child: const Text('Reschedule'),
            ),
          ],
        );
      },
    );
  }

  // Function to handle canceling an appointment
  void _cancelAppointment(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Appointment'),
          content: Text('Are you sure you want to cancel your appointment with ${appointment['doctor']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Remove the appointment from the list
                setState(() {
                  _upcomingAppointments.remove(appointment);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Appointment with ${appointment['doctor']} has been canceled.'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Yes, Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Function to handle viewing appointment details
  void _viewAppointmentDetails(Map<String, dynamic> appointment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(appointment['image']),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment['doctor'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          appointment['specialty'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'Appointment Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildDetailRow(Icons.calendar_today, 'Date', appointment['date']),
              _buildDetailRow(Icons.access_time, 'Time', appointment['time']),
              _buildDetailRow(Icons.location_on, 'Clinic', appointment['clinic']),
              _buildDetailRow(Icons.place, 'Address', appointment['address']),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  // Function to handle booking the same appointment again
  void _bookAgain(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Book Again'),
          content: Text('Would you like to book another appointment with ${appointment['doctor']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to booking screen with pre-filled doctor info
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingScreen(doctor: appointment),
                  ),
                );
              },
              child: const Text('Book Now'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAppointmentsList(List<Map<String, dynamic>> appointments, bool isUpcoming) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 60,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              isUpcoming ? 'No upcoming appointments' : 'No past appointments',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isUpcoming 
                ? 'Book an appointment to get started' 
                : 'Your completed appointments will appear here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
            if (isUpcoming) 
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: _bookNewAppointment,
                  child: const Text('Book Your First Appointment'),
                ),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(appointments[index], isUpcoming);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
            onTap: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            // Upcoming Appointments Tab
            Column(
              children: [
                Expanded(
                  child: _upcomingAppointments.isEmpty
                      ? _buildAppointmentsList(_upcomingAppointments, true)
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              _buildAppointmentsList(_upcomingAppointments, true),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                ),
                // Book New Appointment Button
                if (_upcomingAppointments.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        )
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _bookNewAppointment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text('Book New Appointment'),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            
            // Past Appointments Tab
            _pastAppointments.isEmpty
                ? _buildAppointmentsList(_pastAppointments, false)
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        _buildAppointmentsList(_pastAppointments, false),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// Placeholder screens for booking and rescheduling
class BookingScreen extends StatelessWidget {
  final Map<String, dynamic>? doctor;
  
  const BookingScreen({super.key, this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (doctor != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Booking with ${doctor!['doctor']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    doctor!['specialty'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              )
            else
              const Text(
                'Select a Doctor',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            // Here you would add your booking form fields
            const SizedBox(height: 16),
            const Text('Select Date:'),
            const SizedBox(height: 8),
            const Text('Select Time:'),
            const SizedBox(height: 8),
            // More form fields would go here
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Process booking and return to previous screen
                  Navigator.pop(context, true);
                },
                child: const Text('Confirm Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RescheduleScreen extends StatelessWidget {
  final Map<String, dynamic> appointment;
  
  const RescheduleScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reschedule Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reschedule with ${appointment['doctor']}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              appointment['specialty'],
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            // Here you would add your rescheduling form fields
            const SizedBox(height: 16),
            const Text('Select New Date:'),
            const SizedBox(height: 8),
            const Text('Select New Time:'),
            const SizedBox(height: 8),
            // More form fields would go here
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Process rescheduling and return to previous screen
                  Navigator.pop(context);
                },
                child: const Text('Reschedule Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}