import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';

import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];
  Todo? todoDeletado;
  int? posicao;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Adicione uma tarefa',
                          labelText: 'Ex. Estudar flutter',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                        padding: EdgeInsets.all(14),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            String text = todoController.text;
                            Todo newTodo = Todo(
                              title: text,
                              dateTime: DateTime.now(),
                            );
                            todos.add(newTodo);
                          },
                        );
                        todoController.clear();
                      },
                      child: Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Todo todo in todos)
                        TodoListItem(
                          todo: todo,
                          onDelete: onDelete,
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Você tem ${todos.length} tarefas pendentes"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff00d7f3),
                      ),
                      onPressed: () {
                        showDeleteTodosConfirmationDialog();
                      },
                      child: Text("Limpar tudo"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onDelete(Todo todo) {
    todoDeletado = todo;
    posicao = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'A tarefa ${todo.title.toUpperCase()} foi removida',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          label: "Desfazer",
          onPressed: () {
            setState(() {
              todos.insert(posicao!, todoDeletado!);
            });
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Limpar tudo?"),
        content: Text("Você tem certeza que deseja apagar todas as tarefas?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar"),
            style: TextButton.styleFrom(primary: Color(0xff00d7f3)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllTodos();
            },
            child: Text(
              "Limpar tudo",
            ),
            style: TextButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
  }
}
