import 'package:flutter/material.dart';
import '../repository/professor_repository.dart';
import '../model/professor.dart';

class ProfessorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Professor> professores = ProfessorRepository.listar();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Professores'),
      ),
      body: ListView.builder(
        itemCount: professores.length,
        itemBuilder: (context, index) {
          final professor = professores[index];
          return ListTile(
            title: Text(professor.nome),
            subtitle: Text(
                'Gênero: ${professor.genero} | Experiência: ${professor.experiencia.toInt()} anos'),
            trailing: Icon(
              professor.ativo ? Icons.check_circle : Icons.cancel,
              color: professor.ativo ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
