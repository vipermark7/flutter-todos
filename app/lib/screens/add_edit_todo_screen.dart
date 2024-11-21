// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';

class AddEditTodoScreen extends StatefulWidget {
  final TodoModel? existingTodo;

  const AddEditTodoScreen({Key? key, this.existingTodo}) : super(key: key);

  @override
  _AddEditTodoScreenState createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;

  @override
  void initState() {
    super.initState();
    // Initialize with existing todo data if editing
    _title = widget.existingTodo?.title ?? '';
    _description = widget.existingTodo?.description ?? '';
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final todoProvider = Provider.of<TodoProvider>(context, listen: false);

      if (widget.existingTodo == null) {
        // Add new todo
        todoProvider.addTodo(
          TodoModel(
            title: _title,
            description: _description,
          ),
        );
      } else {
        // Update existing todo
        todoProvider.updateTodo(
          TodoModel(
            id: widget.existingTodo!.id,
            title: _title,
            description: _description,
            createdAt: widget.existingTodo!.createdAt,
          ),
        );
      }

      // Return to previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingTodo == null ? 'Add Todo' : 'Edit Todo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
                maxLength: 50,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(
                  labelText: 'Description (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                maxLength: 200,
                onSaved: (value) => _description = value ?? '',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                    widget.existingTodo == null ? 'Add Todo' : 'Update Todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
