import '../model/professor.dart';

class ProfessorRepository {
  static final List<Professor> _professores = [];

  static void adicionar(Professor professor) {
    _professores.add(professor);
  }

  static List<Professor> listar() {
    return _professores;
  }
}
