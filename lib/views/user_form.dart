import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_simulator/models/user.dart';
import 'package:register_simulator/provider/users.dart';

class UserForm extends StatefulWidget {
  // const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id!;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl!;
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    _loadFormData(user);

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
                initialValue: _formData['name']!,
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
                initialValue: _formData['email']!,
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
                initialValue: _formData['avatarUrl']!,
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
