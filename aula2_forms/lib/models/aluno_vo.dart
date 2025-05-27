// aluno_vo.dart

import 'package:aula2_forms/enums/curso_enum.dart';
import 'package:aula2_forms/enums/sexo_enum.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class AlunoVO {
  final String id; // uuid
  final String ra;
  final String nomeCompleto;
  final String email;
  final DateTime dataNascimento;
  final SexoEnum sexo;
  final CursoEnum curso;
  final bool matriculado;

  // {} = permite que parâmetros sejam informados por nome
  // required = torna um parâmetro obrigatório
  // AlunoVO(ra: '123', nomeCompleto: 'Guilherme' ...);
  AlunoVO({
    required this.ra,
    required this.nomeCompleto,
    required this.email,
    required this.dataNascimento,
    required this.sexo,
    required this.curso,
    required this.matriculado,
    String? id,
  }) : id = id ?? uuid.v4(); // ulid = MongoDB ObjectId

  int get idade {
    final now = DateTime.now();
    int idade = now.year - dataNascimento.year;
    if (now.month < dataNascimento.month ||
        (now.month == dataNascimento.month && now.day < dataNascimento.day)) {
      idade--;
    }
    return idade;
  }

  // map = mapa = estrutura dados baseada em chave (key) e valor (value)
  //     os valores (values) são indexados pelas chaves (keys)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ra': ra,
      'nomeCompleto': nomeCompleto,
      'email': email,
      'dataNascimento': dataNascimento.toIso8601String(),
      'sexo': sexo.index,
      'curso': curso.index,
      'matriculado': matriculado,
    };
  }

  // palavra reservada "factory" = método com nome que funciona
  //         como um construtor (ou uma fábrica de objetos/instâncias)
  factory AlunoVO.fromMap(Map<String, dynamic> map) {
    return AlunoVO(
      id: map['id'],
      ra: map['ra'],
      nomeCompleto: map['nomeCompleto'],
      email: map['email'],
      dataNascimento: DateTime.parse(map['dataNascimento']), // ISO-8601
      sexo: SexoEnum.values[map['sexo']],
      curso: CursoEnum.values[map['curso']],
      matriculado: map['matriculado']
    );
  }

  // toMap = conversão para ser usada em banco de dados (INSERT | UPDATE)
  // fromMap = conversão para ser usada em banco de dados (SELECT)
}
