import 'package:flutter/material.dart';

class myTile extends StatelessWidget {
  const myTile({
    super.key,
    required this.index,
    required this.name,
    required this.addedDate,
    required this.onRemove,
    required this.onTap
  });

  final int index;
  final String name;
  final String addedDate;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (Icon(Icons.auto_stories)),
      title: Text(name),
      titleTextStyle: const TextStyle(
          fontSize: 16,
          color: Colors.lightBlueAccent,
          fontWeight: FontWeight.w600),
      subtitle: Text("Added: $addedDate"),
      dense: true,
      trailing: IconButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (context)=>
                    AlertDialog(
                      title: Text('Are You Sure?'),
                      content: Text('Removing your task will remove its progress forever'),
                      actions: [
                        TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')
                        ),
                        TextButton(
                            onPressed: onRemove,
                            child: Text('Remove')
                        )
                      ],
                    )
            );
          },
          icon: Icon(Icons.remove)
      ),
      onTap: onTap,
    );
  }
}
