import 'package:flutter/material.dart';
import 'package:flutter_internals/keys/checkable_todo_item.dart';
// import 'package:flutter_internals/keys/todo_item.dart';

class Todo {
  const Todo(this.text, this.priority);

  final String text;
  final Priority priority;
}

class Keys extends StatefulWidget {
  const Keys({super.key});

  @override
  State<Keys> createState() {
    return _KeysState();
  }
}

class _KeysState extends State<Keys> {
  var _order = 'asc';
  final _todos = [
    const Todo(
      'Aearn Flutter',
      Priority.urgent,
    ),
    const Todo(
      'Practice Flutter',
      Priority.normal,
    ),
    const Todo(
      'Explore other courses',
      Priority.low,
    ),
  ];


  //Sắp xếp 
  List<Todo> get _orderedTodos {
    final sortedTodos =
        List.of(_todos); //Tạo ra bản sao của _todos bằng cách sử dụng List.of() nhằm đảm bảo danh sách gốc không bị ảnh hưởng
    sortedTodos.sort((a, b) {
      //Sắp xếp các phẩn tử với phương thức sort(),Hàm so sánh được truyền vào phương thức sort so sánh hai phần tử a và b dựa trên thuộc tính text của chúng
      final bComesAfterA = a.text.compareTo(b
          .text); //biến bComesAfterA LƯU KẾT QUẢ của việc so sánh a.text với b.text bằng phương thức compareTo
      return _order == 'asc'
          ? bComesAfterA
          : -bComesAfterA; //Nếu _order là 'asc', kết quả này sẽ được trả về như là kết quả của hàm so sánh. Ngược lại, nếu _order là 'desc', kết quả sẽ được đảo ngược bằng cách nhân với -1
    });
    return sortedTodos;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight, //đối số
          child: TextButton.icon(           //widget con
            onPressed: _changeOrder,
            icon: Icon(
              _order == 'asc' ? Icons.arrow_downward : Icons.arrow_upward,
            ),
            label: Text('Sort ${_order == 'asc' ? 'Descending' : 'Ascending'}'),
          ),
        ),
        Expanded(
          child: Column(
            // children: [
            //   // for (final todo in _orderedTodos) TodoItem(todo.text, todo.priority),
            //   for (final todo in _orderedTodos)
            //     TodoItem(
            //       todo.text,
            //       todo.priority,
            //     ),
            // ],
            children: _orderedTodos.map((todo) {
              return CheckableTodoItem(
                key: ValueKey(todo.text),   //Mỗi phần tử cần 1 key duy nhất
                todo.text,
                todo.priority,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
