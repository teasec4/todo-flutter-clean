import 'package:flutter/material.dart';

class TodosPage extends StatefulWidget {
  final String projectId;
  const TodosPage({super.key, required this.projectId});
  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo")),
      body: Container(
        child: Center(
          child: Text("Project number - ${widget.projectId}")
        )
      ),
    );
  }
}
