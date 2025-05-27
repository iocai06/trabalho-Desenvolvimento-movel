import 'package:flutter/material.dart';
import '../model/professor.dart';
import '../repository/professor_repository.dart';

class ProfessorForm extends StatefulWidget {
  @override
  _ProfessorFormState createState() => _ProfessorFormState();
}

class _ProfessorFormState extends State<ProfessorForm> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _genero = 'Masculino';
  bool _ativo = false;
  double _experiencia = 0;
  List<String> _disciplinasSelecionadas = [];
  DateTime _dataNascimento = DateTime.now();

  final List<String> _disciplinas = [
    'Matemática',
    'Português',
    'História',
    'Geografia',
    'Ciências'
  ];

  Future<void> _selecionarDataNascimento(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataNascimento,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dataNascimento) {
      setState(() {
        _dataNascimento = picked;
      });
    }
  }

  void _salvarProfessor() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Professor novoProfessor = Professor(
        nome: _nome,
        genero: _genero,
        ativo: _ativo,
        experiencia: _experiencia,
        disciplinas: _disciplinasSelecionadas,
        dataNascimento: _dataNascimento,
      );
      ProfessorRepository.adicionar(novoProfessor);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Professor'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o nome' : null,
                onSaved: (value) => _nome = value!,
              ),
              SizedBox(height: 16.0),
              Text('Gênero'),
              RadioListTile(
                title: Text('Masculino'),
                value: 'Masculino',
                groupValue: _genero,
                onChanged: (value) {
                  setState(() {
                    _genero = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text('Feminino'),
                value: 'Feminino',
                groupValue: _genero,
                onChanged: (value) {
                  setState(() {
                    _genero = value.toString();
                  });
                },
              ),
              SizedBox(height: 16.0),
              SwitchListTile(
                title: Text('Ativo'),
                value: _ativo,
                onChanged: (value) {
                  setState(() {
                    _ativo = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Experiência: ${_experiencia.toInt()} anos'),
              Slider(
                value: _experiencia,
                min: 0,
                max: 40,
                divisions: 40,
                label: _experiencia.toInt().toString(),
                onChanged: (value) {
                  setState(() {
                    _experiencia = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Disciplinas'),
              Wrap(
                spacing: 8.0,
                children: _disciplinas.map((disciplina) {
                  return FilterChip(
                    label: Text(disciplina),
                    selected: _disciplinasSelecionadas.contains(disciplina),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _disciplinasSelecionadas.add(disciplina);
                        } else {
                          _disciplinasSelecionadas.remove(disciplina);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              ListTile(
                title: Text(
                    'Data de Nascimento: ${_dataNascimento.day}/${_dataNascimento.month}/${_dataNascimento.year}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _selecionarDataNascimento(context),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _salvarProfessor,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
