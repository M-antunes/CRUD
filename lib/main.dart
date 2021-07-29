import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_simulator/provider/users.dart';
import 'package:register_simulator/routes/app_routes.dart';
import 'package:register_simulator/views/new_user_form.dart';
import 'package:register_simulator/views/user_form.dart';
import 'package:register_simulator/views/user_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        routes: {
          AppRoutes.HOME: (_) => UserList(),
          AppRoutes.USER_FORM: (_) => UserForm(),
          AppRoutes.NEW_USER_FORM: (_) => NewUserForm(),
        },
      ),
    );
  }
}
