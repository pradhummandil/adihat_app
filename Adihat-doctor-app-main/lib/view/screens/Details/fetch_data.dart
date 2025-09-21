import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PatientDatabase {
  /// Fetch patient profile from Firestore
  Future<Map<String, dynamic>?> getPatientProfile(String pid) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('patients')
          .doc(pid)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting patient profile: $e');
      return null;
    }
  }

  //
  // /// Get emergency contacts from Firestore
  // Future<List<Map<String, dynamic>>> getEmergencyContacts() async {
  //   try {
  //     final data = await getPatientProfile();
  //     if (data != null && data['emergencyContacts'] != null) {
  //       return List<Map<String, dynamic>>.from(data['emergencyContacts']);
  //     }
  //     return [];
  //   } catch (e) {
  //     print('Error getting emergency contacts: $e');
  //     return [];
  //   }
  // }
  //
  // /// Get all medicines from all diseases
  // Future<List<Map<String, dynamic>>> getAllMedicines() async {
  //   try {
  //     final data = await getPatientProfile();
  //     if (data != null && data['diseases'] != null) {
  //       List<Map<String, dynamic>> allMedicines = [];
  //
  //       for (var disease in data['diseases']) {
  //         String diseaseName = disease['name'] ?? 'Unknown Disease';
  //         if (disease['medicines'] != null) {
  //           for (var medicine in disease['medicines']) {
  //             allMedicines.add({
  //               'name': medicine['name'] ?? 'Unknown Medicine',
  //               'quantity': medicine['quantity'] ?? '1',
  //               'disease': diseaseName,
  //               'timing': medicine['timing'] ?? {},
  //             });
  //           }
  //         }
  //       }
  //       return allMedicines;
  //     }
  //     return [];
  //   } catch (e) {
  //     print('Error getting all medicines: $e');
  //     return [];
  //   }
  // }
  //
  // /// Get today's medications with automatic status updates
  // Future<List<Map<String, dynamic>>> getTodaysMedications() async {
  //   try {
  //     final allMedicines = await getAllMedicines();
  //     List<Map<String, dynamic>> todaysMedications = [];
  //     final today = DateTime.now();
  //     final todayString =
  //         '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
  //
  //     for (var medicine in allMedicines) {
  //       Map<String, dynamic> timing = medicine['timing'] ?? {};
  //
  //       // Check if medicine should be taken in morning
  //       if (timing['morning'] == true) {
  //         String status =
  //         MedicineStatusService.getMedicineStatus({'morning': true});
  //         Map<String, dynamic> morningMedicine = {
  //           'time': 'Morning',
  //           'timing':
  //           timing['beforeMeal'] == true ? 'Before Meal' : 'After Meal',
  //           'medicine': '${medicine['name']} — ${medicine['quantity']}',
  //           'disease': medicine['disease'],
  //           'status': status,
  //           'takenTime': '',
  //           'date': todayString,
  //         };
  //
  //         todaysMedications.add(morningMedicine);
  //
  //         // Add to missed medicines if status is missed
  //         if (status == 'missed') {
  //           await MedicineStatusService.addMissedMedicine(morningMedicine);
  //         }
  //       }
  //
  //       // Check if medicine should be taken in afternoon
  //       if (timing['afternoon'] == true) {
  //         String status =
  //         MedicineStatusService.getMedicineStatus({'afternoon': true});
  //         Map<String, dynamic> afternoonMedicine = {
  //           'time': 'Afternoon',
  //           'timing':
  //           timing['beforeMeal'] == true ? 'Before Meal' : 'After Meal',
  //           'medicine': '${medicine['name']} — ${medicine['quantity']}',
  //           'disease': medicine['disease'],
  //           'status': status,
  //           'takenTime': '',
  //           'date': todayString,
  //         };
  //
  //         todaysMedications.add(afternoonMedicine);
  //
  //         // Add to missed medicines if status is missed
  //         if (status == 'missed') {
  //           await MedicineStatusService.addMissedMedicine(afternoonMedicine);
  //         }
  //       }
  //
  //       // Check if medicine should be taken in evening
  //       if (timing['evening'] == true) {
  //         String status =
  //         MedicineStatusService.getMedicineStatus({'evening': true});
  //         Map<String, dynamic> eveningMedicine = {
  //           'time': 'Evening',
  //           'timing':
  //           timing['beforeMeal'] == true ? 'Before Meal' : 'After Meal',
  //           'medicine': '${medicine['name']} — ${medicine['quantity']}',
  //           'disease': medicine['disease'],
  //           'status': status,
  //           'takenTime': '',
  //           'date': todayString,
  //         };
  //
  //         todaysMedications.add(eveningMedicine);
  //
  //         // Add to missed medicines if status is missed
  //         if (status == 'missed') {
  //           await MedicineStatusService.addMissedMedicine(eveningMedicine);
  //         }
  //       }
  //     }
  //
  //     return todaysMedications;
  //   } catch (e) {
  //     print('Error getting today\'s medications: $e');
  //     return [];
  //   }
  // }
}
