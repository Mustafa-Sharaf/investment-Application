import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ProcessModel.dart';

class ProcessController extends GetxController {
  var operations = <ProcessModel>[].obs;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;


  @override
  void onInit() {
    super.onInit();
    fetchOperations();
  }

  Future<void> fetchOperations() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('operations')
        .orderBy('date', descending: true)
        .get();

    operations.value = snapshot.docs.map((doc) {
      final data = doc.data();
      return ProcessModel(
        id: doc.id,
        category: data['category'],
        amount: (data['amount'] as num).toDouble(),
        date: DateTime.parse(data['date']),
        currency: data['currency'] ?? 'USD',
      );
    }).toList();
  }


  Future<void> deleteOperation(int index) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final operation = operations[index];

    operations.removeAt(index);

    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('operations')
          .doc(operation.id)
          .delete();

    } catch (e) {
      operations.insert(index, operation);
      Get.snackbar('خطأ', 'فشل حذف العملية من الخادم');
    }
  }


  /*Future<void> updateOperation(int index, ProcessModel updated) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final old = operations[index];

    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('operations')
        .where('category', isEqualTo: old.category)
        .where('amount', isEqualTo: old.amount)
        .where('date', isEqualTo: old.date.toIso8601String())
        .get();

    if (snapshot.docs.isNotEmpty) {
      final docRef = snapshot.docs.first.reference;
      await docRef.update({
        'category': updated.category,
        'amount': updated.amount,
        'date': updated.date.toIso8601String(),
      });
    }
    operations[index] = updated;
  }*/
  Future<void> updateOperation(int index, ProcessModel updated) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final old = operations[index];

    final docRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('operations')
        .doc(old.id);

    await docRef.update({
      'category': updated.category,
      'amount': updated.amount,
      'date': updated.date.toIso8601String(),
      'currency': updated.currency,
    });

    operations[index] = updated;
  }


  double sumAmount([List<ProcessModel>? data]) {
    final list = data ?? operations;
    return list.fold(0.0, (sum, item) => sum + item.amount);
  }


}
