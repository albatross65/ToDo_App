import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/todoItem.dart';
import 'model.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = Todo.todoList();
  List<Todo> foundtodo = [];
  final todoController = TextEditingController();

  @override
  void initState() {
    foundtodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff55AD9B),
        appBar: _buildAppBar(),
        body: Column(
          children: [
            searchBox(),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40, bottom: 20, left: 20),
                    child: Text(
                      'All ToDos',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Color(0xffC0E6BA),
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 6.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  for (Todo todo in foundtodo.reversed)
                    ToDoItem(
                      todo: todo,
                      ontodoChanged: _handletodoChange,
                      ondeleteItem: _deletetodoChange,
                    ),
                ],
              ),
            ),
            addNewToDoTextField(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xff55AD9B),
      centerTitle: true,
      title: Text(
        'ToDo App',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.5,
          color: Color(0xff95D2B3),
          shadows: [
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 6.0,
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
        color: Color(0xffC0E6BA),
        iconSize: 25,
      ),
      actions: [
        Container(
          width: 40,
          height: 40,
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            child: Image.network('https://images.playground.com/5057c33e88f14d789cec90f3463bfa01.jpeg'),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ],
    );
  }

  void _handletodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deletetodoChange(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void addtodoItem(String todo) {
    setState(() {
      todoList.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
    todoController.clear();
  }

  void runfilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todoText!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundtodo=results;
    });
  }

  Widget searchBox() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xffC0E6BA),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) =>runfilter(value) ,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.black38, size: 30),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(18),
        ),
      ),
    );
  }

  Widget addNewToDoTextField() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xffC0E6BA),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: TextField(
                controller: todoController,
                decoration: InputDecoration(
                  hintText: 'Add a new ToDo item',
                  hintStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,fontSize: 20
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 10), // Add space between TextField and Button
          ElevatedButton(
            child: Text(
              '+',
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              addtodoItem(todoController.text);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffC0E6BA),
              minimumSize: Size(60, 70),
              elevation: 10,
              shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Colors.black, // Border color
                  width: 2, // Border width
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
