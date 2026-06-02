import '../helpers/database_helper.dart';
import '../models/employee_model.dart';

class EmployeeService {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insert(Employee employee) async {
    final db = await dbHelper.database;
    return db.insert('employees', employee.toMap());
  }

  Future<List<Employee>> getAll() async {
    final db = await dbHelper.database;

    final result = await db.query('employees');

    return result.map((e) => Employee.fromMap(e)).toList();
  }

  Future<int> update(Employee employee) async {
    final db = await dbHelper.database;

    return db.update(
      'employees',
      employee.toMap(),
      where: 'id=?',
      whereArgs: [employee.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await dbHelper.database;

    return db.delete('employees', where: 'id=?', whereArgs: [id]);
  }
}
