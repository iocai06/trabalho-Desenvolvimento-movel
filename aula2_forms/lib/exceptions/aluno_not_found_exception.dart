// aluno_not_found_exception.dart

// extends = herança de Classe
// implements = implementação de Interface
//        (contrato/assinaturas de métodos)
class AlunoNotFoundException implements Exception {
  // valor = pode ser RA ou Nome
  final String idOuValor;
  final bool isId;

  const AlunoNotFoundException(this.idOuValor, {this.isId = true});

  @override
  String toString() {
    return isId
        ? 'Aluno com ID [$idOuValor] não localizado'
        : 'Aluno com RA ou Nome [$idOuValor] não localizado';
  }
}
