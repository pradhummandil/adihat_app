import 'package:flutter/material.dart';
import "fetch_data.dart";

class PatientDetailsScreen extends StatefulWidget {
  final String patientId;

  const PatientDetailsScreen({super.key, required this.patientId});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final PatientDatabase _patientDatabase = PatientDatabase();
  Map<String, dynamic>? patientData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPatientData();
  }

  Future<void> _fetchPatientData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final data = await _patientDatabase.getPatientProfile(widget.patientId);

      setState(() {
        patientData = data;
        print(patientData);
        isLoading = false;
        if (data == null) {
          errorMessage = 'Patient not found';
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching patient data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLandscape = screenWidth > screenHeight;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Patient Details'),
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchPatientData,
          ),
        ],
      ),
      body: _buildBody(isTablet, isLandscape, screenWidth),
    );
  }

  Widget _buildBody(bool isTablet, bool isLandscape, double screenWidth) {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.blue[600],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Loading patient data...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: isTablet ? 80 : 64,
                color: Colors.red[400],
              ),
              SizedBox(height: 16),
              Text(
                errorMessage!,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  color: Colors.red[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchPatientData,
                child: Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 32 : 24,
                    vertical: isTablet ? 16 : 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (patientData == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_off,
                size: isTablet ? 80 : 64,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16),
              Text(
                'No patient found with ID: ${widget.patientId}',
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = isTablet ? 24.0 : 16.0;
        final maxWidth = isTablet ? 1000.0 : double.infinity;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(padding),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                children: [
                  _buildPersonalInfoCard(isTablet, constraints.maxWidth),
                  SizedBox(height: 16),
                  _buildDiseasesSection(isTablet, constraints.maxWidth),
                  SizedBox(height: 16),
                  if (patientData!['emergencyContacts'] != null)
                    _buildEmergencyContactsCard(isTablet, constraints.maxWidth),
                  if (patientData!['emergencyContacts'] != null)
                    SizedBox(height: 16),
                  _buildMetadataCard(isTablet, constraints.maxWidth),
                  SizedBox(height: 24), // Bottom padding
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPersonalInfoCard(bool isTablet, double maxWidth) {
    final personalInfo = patientData?['personalInfo'] ?? {};

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: isTablet ? 40 : 30,
                  backgroundColor: Colors.blue[100],
                  child: Icon(
                    Icons.person,
                    size: isTablet ? 40 : 30,
                    color: Colors.blue[600],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: isTablet ? 22 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        personalInfo['name'] ?? 'N/A',
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildResponsiveInfoGrid([
              _buildInfoItem('Blood Group', personalInfo['bloodGroup'] ?? 'N/A',
                  Icons.water_drop),
              _buildInfoItem(
                  'Phone',
                  personalInfo['phone']?.isNotEmpty == true
                      ? personalInfo['phone']
                      : 'Not provided',
                  Icons.phone),
              _buildInfoItem('Date of Birth',
                  personalInfo['dateOfBirth'] ?? 'N/A', Icons.cake),
            ], isTablet, maxWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildDiseasesSection(bool isTablet, double maxWidth) {
    final diseases = patientData!['diseases'] as List? ?? [];

    if (diseases.isEmpty) {
      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
          child: Column(
            children: [
              Icon(
                Icons.medical_services,
                size: isTablet ? 48 : 40,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16),
              Text(
                'No diseases recorded',
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: diseases.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> disease = entry.value;
        return Padding(
          padding:
              EdgeInsets.only(bottom: index < diseases.length - 1 ? 16 : 0),
          child: _buildDiseaseCard(disease, isTablet, maxWidth),
        );
      }).toList(),
    );
  }

  Widget _buildDiseaseCard(
      Map<String, dynamic> disease, bool isTablet, double maxWidth) {
    final medicines = disease['medicines'] as List? ?? [];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.medical_services,
                    color: Colors.red[600], size: isTablet ? 28 : 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Disease: ${disease['name'] ?? 'Unnamed'}',
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Medicines:',
              style: TextStyle(
                fontSize: isTablet ? 18 : 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 12),
            if (medicines.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  'No medicines prescribed',
                  style: TextStyle(
                    fontSize: isTablet ? 14 : 12,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            else
              ...medicines
                  .where((medicine) => medicine['name']?.isNotEmpty == true)
                  .map((medicine) =>
                      _buildMedicineItem(medicine, isTablet, maxWidth))
                  .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineItem(
      Map<String, dynamic> medicine, bool isTablet, double maxWidth) {
    final timing = medicine['timing'] as Map<String, dynamic>? ?? {};
    final activeTimings = timing.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(isTablet ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medication,
                  color: Colors.green[600], size: isTablet ? 20 : 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  medicine['name'] ?? 'Unnamed Medicine',
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 14,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              if (medicine['quantity'] != null &&
                  medicine['quantity'].toString().isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Qty: ${medicine['quantity']}',
                    style: TextStyle(
                      fontSize: isTablet ? 12 : 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
            ],
          ),
          if (activeTimings.isNotEmpty) ...[
            SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: activeTimings
                  .map((timing) => Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          timing,
                          style: TextStyle(
                            fontSize: isTablet ? 11 : 9,
                            color: Colors.green[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmergencyContactsCard(bool isTablet, double maxWidth) {
    final emergencyContacts = patientData!['emergencyContacts'] as List? ?? [];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emergency,
                    color: Colors.orange[600], size: isTablet ? 28 : 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Emergency Contacts',
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (emergencyContacts.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Text(
                  'No emergency contacts available',
                  style: TextStyle(
                    fontSize: isTablet ? 14 : 12,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            else
              ...emergencyContacts
                  .map((contact) => Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person,
                                color: Colors.orange[600],
                                size: isTablet ? 20 : 16),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    contact['name'] ?? 'Unknown',
                                    style: TextStyle(
                                      fontSize: isTablet ? 14 : 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (contact['phone'] != null)
                                    Text(
                                      contact['phone'],
                                      style: TextStyle(
                                        fontSize: isTablet ? 12 : 10,
                                        color: Colors.grey[600],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                            if (contact['phone'] != null)
                              IconButton(
                                icon: Icon(Icons.phone,
                                    color: Colors.orange[600],
                                    size: isTablet ? 20 : 16),
                                onPressed: () {
                                  // Add phone call functionality here
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Calling ${contact['phone']}'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ))
                  .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataCard(bool isTablet, double maxWidth) {
    final savedTimestamp = patientData!['savedAt'];
    final lastModified = patientData!['lastModified'];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isTablet ? 24.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline,
                    color: Colors.grey[600], size: isTablet ? 28 : 24),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Record Information',
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildResponsiveInfoGrid([
              _buildInfoItem('Patient ID', widget.patientId, Icons.badge),
              _buildInfoItem(
                  'Last Modified', _formatDateTime(lastModified), Icons.edit),
            ], isTablet, maxWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveInfoGrid(
      List<Widget> items, bool isTablet, double maxWidth) {
    // Determine grid columns based on screen size
    int crossAxisCount;
    if (maxWidth > 800) {
      crossAxisCount = 3;
    } else if (maxWidth > 600) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 1;
    }

    if (crossAxisCount == 1) {
      return Column(
        children: items
            .map((item) => Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: item,
                ))
            .toList(),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      childAspectRatio: 2.5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 12,
      children: items,
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[600], size: 18),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fixed timestamp formatting methods to handle both int and String types
  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'N/A';

    try {
      DateTime date;
      if (timestamp is int) {
        // Handle integer timestamp (seconds or milliseconds)
        if (timestamp > 1000000000000) {
          // Milliseconds
          date = DateTime.fromMillisecondsSinceEpoch(timestamp);
        } else {
          // Seconds
          date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
        }
      } else if (timestamp is String) {
        // Handle string timestamp
        final parsedInt = int.tryParse(timestamp);
        if (parsedInt != null) {
          if (parsedInt > 1000000000000) {
            date = DateTime.fromMillisecondsSinceEpoch(parsedInt);
          } else {
            date = DateTime.fromMillisecondsSinceEpoch(parsedInt * 1000);
          }
        } else {
          // Try parsing as DateTime string
          date = DateTime.parse(timestamp);
        }
      } else {
        return timestamp.toString();
      }

      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      print('Error formatting timestamp: $e');
      return timestamp.toString();
    }
  }

  String _formatDateTime(dynamic dateTimeStr) {
    if (dateTimeStr == null) return 'N/A';

    try {
      DateTime date;
      if (dateTimeStr is String) {
        date = DateTime.parse(dateTimeStr);
      } else if (dateTimeStr is int) {
        if (dateTimeStr > 1000000000000) {
          date = DateTime.fromMillisecondsSinceEpoch(dateTimeStr);
        } else {
          date = DateTime.fromMillisecondsSinceEpoch(dateTimeStr * 1000);
        }
      } else {
        return dateTimeStr.toString();
      }

      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      print('Error formatting datetime: $e');
      return dateTimeStr.toString();
    }
  }
}
