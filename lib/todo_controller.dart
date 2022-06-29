import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:todo_app/todo_model.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  getTodos() async {
    try {
      var response =
          await Dio().get('https://mighty-harbor-37805.herokuapp.com/notes');
      print(response.data);
      List data = response.data;
      todos.value = [];
      data.forEach((element) {
        todos.value.add(Todo.fromJson(element));
      });
      todos.refresh();
      // print(todos.value[2].body);
    } catch (e) {
      print(e);
    }
  }

  addTodo(String todo) async {
    try {
      var response = await Dio().post(
          'https://mighty-harbor-37805.herokuapp.com/note/create/',
          data: {"body": todo});
      if (response.statusCode == 200) {
        getTodos();
        Get.snackbar('Success', 'Todo Added');
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Dio Error');
    }
  }

  updateTodo(int id, String todo) async {
    try {
      var response = await Dio().put(
          'https://mighty-harbor-37805.herokuapp.com/note/$id/update/',
          data: {"body": todo});
      if (response.statusCode == 200) {
        getTodos();
        Get.snackbar('Success', 'Todo Updated');
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Dio Error');
    }
  }

  Future<bool> updateTodoComplete(int id, String str,bool todo) async {
    try {
      var response = await Dio().put(
          'https://mighty-harbor-37805.herokuapp.com/note/$id/update/',
          data: { "body":str,"complete": todo});
      if (response.statusCode == 200) {
        getTodos();
        Get.snackbar('Success', 'Todo Updated');
        return true;
      } else {
        Get.snackbar('Error', 'Something went wrong');
        return false;
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Dio Error');
      return false;
    }
  }

  toggleTodo(int id) async {
    // var bool = 
    var call = await updateTodoComplete(id,todos.value.firstWhere((element) => element.id == id).body! ,!todos.value.firstWhere((element) => element.id == id).isComplete!);
    if(call){

    todos.value.firstWhere((element) => element.id == id).isComplete = !todos.value.firstWhere((element) => element.id == id).isComplete!;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      var response = await Dio()
          .delete('https://mighty-harbor-37805.herokuapp.com/note/$id/delete/');
      if (response.statusCode == 200) {
        getTodos();
        Get.snackbar('Success', 'Todo Deleted');
        return true;
      } else {
        Get.snackbar('Error', 'Something went wrong');
        return false;
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Dio Error');
      return false;
    }
  }
}
