import 'package:flutter/material.dart';
import 'model.dart';

class ToDoItem extends StatelessWidget {
  final Todo todo;
  final ontodoChanged;
  final ondeleteItem;

  const ToDoItem({super.key, required this.todo,required this.ontodoChanged,required this.ondeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          ontodoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Color(0xff95D2B3),
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.black,
        ),
        title: Text(
          todo.todoText ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.black,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 8),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Color(0xffF00000), borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 20,
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              ondeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
