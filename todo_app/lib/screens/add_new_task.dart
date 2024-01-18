import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constans/color.dart';
import 'package:todo_app/constans/tasktype.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/todo_service.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key, required this.addNewTask}); // buraya addNewTask'ı required ettik

  final void Function(Task newTask) addNewTask; // save'ye basınca listeye cart eklemek için fonksiyon yardımı ile ekledik ve yukarı required ettik

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  TextEditingController titleController=TextEditingController(); // controller'ler bunlar
  TextEditingController userIdController=TextEditingController(); // her bir text kutusu için ayrı controller
  TextEditingController timeController=TextEditingController(); // text içerisindeki yazdığımız input'ları alabilmemiz için statefullwidget içerisinde oluşturdugumuz değişken tipi
  TextEditingController descriptionController=TextEditingController();

  TodoService todoService= TodoService();

  TaskType taskType = TaskType.note; // catogory'leri seçme olayı default hali note olsun dedik - buradan onTap widgetlerinin içine gidip setState işlemlerini yapcıaz

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backgroundcolor),
        body:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height / 10, // container için ekranın 10'da 1'ini kullan
                decoration: const BoxDecoration(image: DecorationImage(image:AssetImage("lib/assest/images/add_new_task_header.png"),fit:BoxFit.cover)), // mor alan
                child:Row( // yan yana bir şeyler ekleyecmz için Row dedik
                  children: [
                    IconButton(onPressed: (){Navigator.of(context).pop();}, icon: const Icon(Icons.close),iconSize: 40,color:Colors.white), // Çarpı iconu işlevi ve style'ları
                    const Expanded(child: Text("Add new task",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 20),)) // başlık ve style'ları
                  ],
                )
              ),
              // TASK TITLE *****
              const Padding(padding:EdgeInsets.only(top:10),child: Text("Task title")),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40), //  yazı yazılan yer: yukarı aşağı 20 birim boşluk verdik, sağdan soldan 40 birim boşluk verdik
                child: TextField(controller: titleController,decoration: const InputDecoration(filled: true,fillColor: Colors.white)) // yazı yazdığımız alan ve işlevselliği true olarak ayarladık
              ),
              // CATEGORY *****
              Padding(
                padding: const EdgeInsets.only(top:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Category"),
                    GestureDetector(
                      onTap: (){ // icona tıklayınca ne olsun
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar( // snackBar aşağıda bize mesaj verir
                          duration: Duration(milliseconds: 500), // 500 milisny olsun dedik
                          content: Text("Category selected") // mesajda bu yazsın
                          )
                        );
                        setState(() {
                          taskType=TaskType.note; // burada yukarıda tanımladığımız taskType'yi set ediyoruz
                        });
                      },
                      child: Image.asset("lib/assest/images/Category.png"), // icon foto
                    ),
                    GestureDetector(
                      onTap: (){ // icona tıklayınca ne olsun
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar( // snackBar aşağıda bize mesaj verir
                          duration: Duration(milliseconds: 500), // 500 milisny olsun dedik
                          content: Text("Category selected") // mesajda bu yazsın
                          )
                        );
                        setState(() {
                          taskType=TaskType.calendar; // burada yukarıda tanımladığımız taskType'yi set ediyoruz
                        });
                      },
                      child: Image.asset("lib/assest/images/Category2.png"), // icon foto
                    ),
                    GestureDetector(
                      onTap: (){ // icona tıklayınca ne olsun
                        ScaffoldMessenger.of(context).showSnackBar( const SnackBar( // snackBar aşağıda bize mesaj verir
                          duration: Duration(milliseconds: 500), // 500 milisny olsun dedik
                          content: Text("Category selected") // mesajda bu yazsın
                          )
                        );
                        setState(() {
                          taskType=TaskType.contest; // burada yukarıda tanımladığımız taskType'yi set ediyoruz
                        });
                      },
                      child: Image.asset("lib/assest/images/Category3.png"), // icon foto
                    )
                  ],
                ),
              ),
              // DATE VE TIME *****
               Padding(
                padding: const EdgeInsets.only(top:10),
                 child: Row( // yan yana yazıcaz ondan row dedik
                  children: [
                    Expanded( // Expanded dedik. ekranı 2'ye böldük sağ-sol olarak
                      child: Column(
                        children: [
                          const Text("User ID"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20), //TextField'ın yanlardan 20'şer birim boşluk bırakmasını sağladık
                            child: TextField(controller: userIdController,decoration: const InputDecoration(filled: true,fillColor: Colors.white)) // controller ekledik çünkü kontrol etcez yukarıda tanımlamıştk
                          ) // 23:15
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Time"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(controller: timeController,decoration: const InputDecoration(filled: true,fillColor: Colors.white)) // controller ekledik çünkü kontrol etcez yukarıda tanımlamıştk
                            ) // 23:15
                        ],
                      ),
                    )
                  ],
                  ),
               ),
              // NOTES *****
              const Padding(
                padding: EdgeInsets.only(top:10),
                child: Text("Description")
                ),
               SizedBox(
                height: 300, // yükseklik
                child: TextField(controller: descriptionController, expands:true,maxLines:null,decoration: const InputDecoration(filled: true,fillColor: Colors.white,isDense: true))// controller ekledik çünkü kontrol etcez yukarıda tanımlamıştk
              ),
              // SAVE BUTTON *****
              ElevatedButton(onPressed: (){
                saveTodo();
                Task newtask= Task(description: descriptionController.text, isCompleted: false, title: titleController.text, type: taskType); // en yukarıda required ettikten sorna bunu ekledik
                widget.addNewTask(newtask); // 1 üst satırda değişkenlerimizi oluşturduk artık bunu button içinde çağırabiliiriz
                Navigator.pop(context); // save'ye basınca bizi pop ediyo ve home ekranın gönderiyor
              }, child: const Text("Save"))
            ],
          ),
        )
      ),
    );
  }
  // SAVE KISMI ****
  void saveTodo(){ // add new tasks sayfasından aldığımız inputlara göre (yani kullanıcıdan aldığımız veriler) 1 tane todo objesi oluşturmak
    Todo newTodo = Todo(id: -1, todo: titleController.text, completed: false, userId: int.parse(userIdController.text));
    todoService.addTodo(newTodo); // todo_service.dart'ta kurduğumuz methodu burayla ilişkilendirdik
  }
}
