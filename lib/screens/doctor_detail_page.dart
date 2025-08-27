// import 'package:flutter/material.dart';

// class DoctorDetailPage extends StatefulWidget {
//   final Map<String, dynamic> doctor;
  
//   const DoctorDetailPage({super.key, required this.doctor});
  
//   @override
//   State<DoctorDetailPage> createState() => _DoctorDetailPageState();
// }

// class _DoctorDetailPageState extends State<DoctorDetailPage> {
//   String selectedDate = '';
//   String selectedTime = '';
  
//   final List<String> availableDates = [
//     'Today',
//     'Tomorrow',
//     'Dec 15, 2024',
//     'Dec 16, 2024',
//     'Dec 17, 2024',
//   ];
  
//   final List<String> availableTimes = [
//     '9:00 AM',
//     '10:00 AM',
//     '11:00 AM',
//     '2:00 PM',
//     '3:00 PM',
//     '4:00 PM',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Doctor Profile'),
//         backgroundColor: Colors.blue,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Doctor Header
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 20),
//                   CircleAvatar(
//                     radius: 60,
//                     backgroundImage: NetworkImage(widget.doctor['image']),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     widget.doctor['name'],
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     widget.doctor['specialty'],
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white70,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.star, color: Colors.amber, size: 20),
//                       SizedBox(width: 4),
//                       Text(
//                         '${widget.doctor['rating']}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                       Icon(Icons.location_on, color: Colors.white70, size: 16),
//                       SizedBox(width: 4),
//                       Text(
//                         widget.doctor['distance'],
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white70,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                 ],
//               ),
//             ),
            
//             // Doctor Details
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Contact Info
//                   _buildInfoSection(
//                     'Contact Information',
//                     [
//                       _buildInfoRow(Icons.phone, 'Phone', widget.doctor['phone']),
//                       _buildInfoRow(Icons.email, 'Email', widget.doctor['email']),
//                       _buildInfoRow(Icons.location_on, 'Location', widget.doctor['location']),
//                     ],
//                   ),
                  
//                   SizedBox(height: 20),
                  
//                   // Education & Languages
//                   _buildInfoSection(
//                     'Education & Languages',
//                     [
//                       _buildInfoRow(Icons.school, 'Education', widget.doctor['education']),
//                       _buildInfoRow(Icons.language, 'Languages', widget.doctor['languages'].join(', ')),
//                     ],
//                   ),
                  
//                   SizedBox(height: 20),
                  
//                   // About
//                   _buildInfoSection(
//                     'About',
//                     [
//                       _buildInfoRow(Icons.info, '', widget.doctor['about']),
//                     ],
//                   ),
                  
//                   SizedBox(height: 20),
                  
//                   // Services
//                   _buildInfoSection(
//                     'Services Offered',
//                     (widget.doctor['services'] as List<dynamic>).map((service) => 
//                       _buildInfoRow(Icons.medical_services, '', '• $service')
//                     ).toList(),
//                   ),
                  
//                   SizedBox(height: 20),
                  
//                   // Working Hours
//                   _buildInfoSection(
//                     'Working Hours',
//                     [
//                       _buildInfoRow(Icons.access_time, '', widget.doctor['workingHours']),
//                     ],
//                   ),
                  
//                   SizedBox(height: 20),
                  
//                   // Consultation Fee
//                   _buildInfoSection(
//                     'Consultation Fee',
//                     [
//                       _buildInfoRow(Icons.attach_money, '', widget.doctor['consultationFee']),
//                     ],
//                   ),
                  
//                   SizedBox(height: 30),
                  
//                   // Book Appointment Section
//                   if (widget.doctor['available'])
//                     _buildBookingSection(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   Widget _buildInfoSection(String title, List<Widget> children) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue[900],
//           ),
//         ),
//         SizedBox(height: 12),
//         Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 blurRadius: 8,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             children: children,
//           ),
//         ),
//       ],
//     );
//   }
  
//   Widget _buildInfoRow(IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: Colors.blue, size: 20),
//           SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (label.isNotEmpty)
//                   Text(
//                     label,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[600],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 Text(
//                   value,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildBookingSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Book Appointment',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue[900],
//           ),
//         ),
//         SizedBox(height: 16),
//         Container(
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.blue[50],
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.blue[200]!),
//           ),
//           child: Column(
//             children: [
//               // Date Selection
//               Row(
//                 children: [
//                   Icon(Icons.calendar_today, color: Colors.blue),
//                   SizedBox(width: 12),
//                   Text(
//                     'Select Date:',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.blue[900],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 12),
//               Wrap(
//                 spacing: 8,
//                 children: availableDates.map((date) => 
//                   ChoiceChip(
//                     label: Text(date),
//                     selected: selectedDate == date,
//                     onSelected: (selected) {
//                       setState(() {
//                         selectedDate = selected ? date : '';
//                       });
//                     },
//                     selectedColor: Colors.blue,
//                     labelStyle: TextStyle(
//                       color: selectedDate == date ? Colors.white : Colors.blue[900],
//                     ),
//                   ),
//                 ).toList(),
//               ),
              
//               SizedBox(height: 20),
              
//               // Time Selection
//               Row(
//                 children: [
//                   Icon(Icons.access_time, color: Colors.blue),
//                   SizedBox(width: 12),
//                   Text(
//                     'Select Time:',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.blue[900],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 12),
//               Wrap(
//                 spacing: 8,
//                 children: availableTimes.map((time) => 
//                   ChoiceChip(
//                     label: Text(time),
//                     selected: selectedTime == time,
//                     onSelected: (selected) {
//                       setState(() {
//                         selectedTime = selected ? time : '';
//                       });
//                     },
//                     selectedColor: Colors.blue,
//                     labelStyle: TextStyle(
//                       color: selectedTime == time ? Colors.white : Colors.blue[900],
//                     ),
//                   ),
//                 ).toList(),
//               ),
              
//               SizedBox(height: 24),
              
//               // Book Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     padding: EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: (selectedDate.isNotEmpty && selectedTime.isNotEmpty) ? () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Appointment booked with ${widget.doctor['name']} on $selectedDate at $selectedTime'),
//                         backgroundColor: Colors.green,
//                       ),
//                     );
//                     Navigator.pop(context);
//                   } : null,
//                   child: Text(
//                     'Book Appointment',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// } 