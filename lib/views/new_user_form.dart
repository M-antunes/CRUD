import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_simulator/models/user.dart';
import 'package:register_simulator/provider/users.dart';

class NewUserForm extends StatefulWidget {
  // const NewUserForm({Key? key}) : super(key: key);

  @override
  _NewUserFormState createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Form"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                Provider.of<Users>(context, listen: false).put(
                  User(
                      id: _formData['id'],
                      name: _formData['name']!,
                      email: _formData['email']!,
                      avatarUrl: _formData['avatarUrl']),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Nome Inválido.";
                  }
                  if (value.trim().length < 3) {
                    return 'Nome pequeno demais. Mínimo de 3 caracteres.';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "E-mail"),
                onSaved: (value) => _formData['email'] = value!,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor insira um e-mail válido.";
                  }
                  if (value.trim().contains('.com') == false) {
                    return 'Por favor insira um e-mail válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "URL do Avatar"),
                onSaved: (value) => _formData['avatarUrl'] = value!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
