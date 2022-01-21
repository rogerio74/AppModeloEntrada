import 'package:firebase_database/firebase_database.dart';

class AppModeloDatabase {
  final DatabaseReference _databaseref =
      FirebaseDatabase.instance.ref('app_modelo');

  Future<void> _saveNumero(String child, int numeroPasta) async {
    await _databaseref.update({
      child: numeroPasta,
    });
  }

  Future<int> _getNumero(String child) async {
    DatabaseEvent event = await _databaseref.child(child).once();
    DataSnapshot snapshot = event.snapshot;
    String value = snapshot.value!.toString();
    int valorPasta = int.tryParse(value)!;
    return valorPasta;
  }

  Future<int> incrementNumero(String child, int numero) async {
    int ultimoNumero = await _getNumero(child);

    if (child == 'num_pasta') {
      ultimoNumero++;
    } else {
      ultimoNumero += numero;
    }
    await _saveNumero(child, ultimoNumero);
    return ultimoNumero;
  }
}

final AppModeloDatabase database = AppModeloDatabase();
