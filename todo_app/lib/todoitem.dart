import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';

class TodoItem extends StatefulWidget {// A
  const TodoItem({super.key,required this.task});
  final Todo task;
  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isCheck = false; // B
  @override
  Widget build(BuildContext context) {
    return Card(
      color:widget.task.completed! == true ?Colors.deepPurple[200]: Colors.white, // checkBox seçili olduğunda = arkaplan grey olacak, değilse beyaz olcak
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(// yan yana widgetler ekleneceği için row kullanıldı
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /* TODO FireBase işlemlerinde düzelt
              widget.task.type == TaskType.note
              ? Image.asset("lib/assest/images/Category.png")
              : widget.task.type == TaskType.contest ? Image.asset("lib/assest/images/Category3.png") : Image.asset("lib/assest/images/Category2.png"), // burası aslında if
              */
              Image.asset("lib/assest/images/Category.png"),
              Expanded(
                child: Column(
                  children: [
                    Text(
                    widget.task.todo!, // buraya bunu ekledik ve yukarıda "C" ile işaretlenmiş yeri ekledik // bu title'nin olayı string todo'nun içindeki indexleri bunun içine alıcaz
                    style: TextStyle(
                    decoration:widget.task.completed! ? TextDecoration.lineThrough: TextDecoration.none,
                    fontWeight: FontWeight.bold, fontSize: 20)
                    ),
                    Text("User: ${widget.task.userId!}") // anasayfada kartların içindeki 2. yazılar // interpolation yaptık
                  ],
                ),
              ),
              Checkbox(
                  value: isCheck,
                  onChanged: (val) => {
                        setState(() {
                          widget.task.completed = !widget.task.completed!;
                          isCheck =val!; // bu satırda hata vard ı yukarda "B" ile işaretlenmiş olan yeri ekledik
                        })
                      }
                      )
            ],
          ),
        ));
  }
}
