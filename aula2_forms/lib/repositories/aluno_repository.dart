// aluno_repository.dart (pacote/pasta "repositories")

// classe de repositório simula/emula uma tabela de ALUNOS (em memória)
import 'package:aula2_forms/enums/curso_enum.dart';
import 'package:aula2_forms/enums/sexo_enum.dart';
import 'package:aula2_forms/exceptions/aluno_not_found_exception.dart';
import 'package:aula2_forms/models/aluno_vo.dart';

// AlunoRepository()
class AlunoRepository {
  // design pattern (padrão de projeto) = Singleton (única instância da classe)
  // refactoring guru

  // 3. primeira e única instanciação do atributo '_instance'
  static final AlunoRepository _instance = AlunoRepository._internal();

  // 1. construtor privado (reduz o escopo à classe - não se pode chamar fora)
  AlunoRepository._internal();

  // 2. método de classe que funciona como construtor
  // retorna sempre a mesma referência (instância) que é o atributo '_instance'
  factory AlunoRepository() {
    return _instance;
  }

  // final Map<String, AlunoVO> _alunos = {}; // uuid : AlunoVO

  final Map<String, AlunoVO> _alunos = {
    '1': AlunoVO(
      id: '1',
      ra: '100',
      nomeCompleto: 'João Silva',
      email: 'joao.silva@email.com',
      dataNascimento: DateTime(2000, 5, 15),
      sexo: SexoEnum.masculino,
      curso: CursoEnum.analise,
      matriculado: true,
    ),
    '2': AlunoVO(
      id: '2',
      ra: '101',
      nomeCompleto: 'Maria Oliveira',
      email: 'maria.oliveira@email.com',
      dataNascimento: DateTime(1999, 8, 22),
      sexo: SexoEnum.feminino,
      curso: CursoEnum.medicina,
      matriculado: false,
    ),
  };

  void save(AlunoVO aluno) {
    // INSERT INTO ALUNOS (...) VALUES (...);
    // UPDATE ALUNOS SET RA = ? , ... WHERE ID = ?;
    _alunos[aluno.id] = aluno;
  }

  AlunoVO findById(String id) {
    if (!_alunos.containsKey(id)) {
      // se não foi possível encontrar aluno com id
      throw AlunoNotFoundException(id);
    }
    return _alunos[id]!;
  }

  List<AlunoVO> findByRaOrNome(String valor) {
    final String termo = valor.toLowerCase(); // case-insensitive
    final List<AlunoVO> alunos =
        _alunos.values
            .where(
              (aluno) =>
                  aluno.ra.toLowerCase().contains(termo) ||
                  aluno.nomeCompleto.toLowerCase().contains(termo),
            )
            .toList();

    if (alunos.isEmpty) {
      throw AlunoNotFoundException(valor, isId: false);
    }

    return alunos;
  }

  // SELECT * FROM ALUNOS;
  List<AlunoVO> findAll() {
    return _alunos.values.toList();
  }

  // DELETE FROM ALUNOS WHERE ID = ?;
  void deleteById(String id) {
    if (!_alunos.containsKey(id)) {
      throw AlunoNotFoundException(id);
    }
    _alunos.remove(id);
  }
}
