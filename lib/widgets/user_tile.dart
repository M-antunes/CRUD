import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:register_simulator/models/user.dart';
import 'package:register_simulator/provider/users.dart';
import 'package:register_simulator/routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl!.isEmpty
        ? CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl!),
          );
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.green[800],
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red[400],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Delete user?"),
                    content: Text("Are you sure?"),
                    actions: [
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () {
                          Provider.of<Users>(context, listen: false)
                              .remove(user);
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('No'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
