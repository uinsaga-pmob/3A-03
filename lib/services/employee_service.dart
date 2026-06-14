import 'package:pabrik_kayu/helpers/database_helper.dart';
import 'package:pabrik_kayu/models/employee_model.dart';

class EmployeeService {
  final db = DatabaseHelper.instance;

  // CREATE
  Future<int> save(EmployeeModel employee) async {
    return await db.insert('employees', employee.toMap());
  }

  // READ ALL
  Future<List<EmployeeModel>> getAll() async {
    final result = await db.getAll('employees');

    return result.map((e) => EmployeeModel.fromMap(e)).toList();
  }

  // READ BY ID
  Future<EmployeeModel?> getById(int id) async {
    final result = await db.getById('employees', id);

    if (result == null) return null;

    return EmployeeModel.fromMap(result);
  }

  // UPDATE
  Future<int> update(EmployeeModel employee) async {
    // Pengaman: Jika id null, langsung kembalikan 0 (gagal update) tanpa bikin aplikasi crash
    if (employee.id == null) return 0;

    return await db.update('employees', employee.id!, employee.toMap());
  }

  // DELETE
  Future<int> delete(int id) async {
    return await db.delete('employees', id);
  }
}
