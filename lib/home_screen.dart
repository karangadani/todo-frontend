import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/todo_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TodoController todoController = Get.find<TodoController>();
    TextEditingController textEditingController = TextEditingController();

    addTodo(bool isEdit, int id) {
      if (isEdit == true) {
        textEditingController.text = todoController.todos
            .firstWhere((element) => element.id == id)
            .body!;
      }
      Get.dialog(
        Dialog(
          child: Material(
            child: Container(
              height: 150,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text('Add Todo'),
                  TextField(
                    decoration: const InputDecoration(hintText: 'Enter todo'),
                    controller: textEditingController,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      if (isEdit) {
                        todoController.updateTodo(
                            id, textEditingController.text);
                      } else {
                        todoController.addTodo(textEditingController.text);
                      }
                    },
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(isEdit ? 'Update' : 'Add'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo app'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodo(false, 0);
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(child: Obx(
              () {
                if (todoController.todos.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async => todoController.getTodos(),
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: todoController.todos.value.length,
                        itemBuilder: (context, index) => Dismissible(
                              background: Container(
                                color: Colors.green,
                                child: const Icon(Icons.edit),
                              ),
                              key: Key(todoController.todos.value[index].id
                                  .toString()),
                              onDismissed: (direction) {},
                              confirmDismiss: (direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  addTodo(true,
                                      todoController.todos.value[index].id!);
                                } else {
                                  return todoController.deleteTodo(
                                      todoController.todos.value[index].id!);
                                }
                              },
                              secondaryBackground: Container(
                                color: Colors.red,
                                child: const Icon(Icons.delete),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        todoController.todos.value[index].body!,

                                        style: TextStyle(
                                          decoration: todoController.todos.value[index].isComplete! ? TextDecoration.lineThrough : null,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Checkbox(
                                          value: todoController
                                              .todos.value[index].isComplete,
                                          onChanged: (val) {
                                            todoController.toggleTodo(todoController
                                              .todos.value[index].id!);
                                          },
                                        ))
                                  ],
                                ),
                              ),
                            )),
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
