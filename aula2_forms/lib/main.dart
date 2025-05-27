import 'package:flutter/material.dart';
import 'screens/professor_form.dart';
import 'screens/professor_list.dart';

void main() {
  runApp(TrabalhoDesenvolvimentoMovel());
}

class TrabalhoDesenvolvimentoMovel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trabalho Desenvolvimento Móvel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trabalho Desenvolvimento Móvel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Cadastrar Professor'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfessorForm()),
                );
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Listar Professores'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfessorList()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
