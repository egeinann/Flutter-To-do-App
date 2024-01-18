import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo_app/constans/color.dart';
import 'package:todo_app/constans/tasktype.dart';
import 'package:todo_app/headeritem.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screens/add_new_task.dart';
import 'package:todo_app/service/todo_service.dart';
import 'package:todo_app/todoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> todo = [
    Task(description: "Study COMP117", isCompleted: false, title: "Study Lessons", type: TaskType.note),
    Task(description: "Attend to party", isCompleted: false, title: "Go to party", type: TaskType.calendar),
    Task(description: "Run 5 kilometers", isCompleted: false, title: "Run 5K", type: TaskType.contest)
  ];

  List<Task> completed=[
    Task(description: "Attend to party", isCompleted: false, title: "Go to party", type: TaskType.calendar),
    Task(description: "Run 5 kilometers", isCompleted: false, title: "Run 5K", type: TaskType.contest)
  ];

  void addNewTask(Task newTask){ // addNewTask ekranındaki save buttonu ile alakalı
    setState(() {
      todo.add(newTask); // setstate dedik ve todo listesine cartımızı ekliyoruz 
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService(); // servis işlemi
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
      home: SafeArea(// bildirim panelinin arkasıbda çalışmak istemiyorsan her zaman safeArea kullan
        child: Scaffold(
          backgroundColor: HexColor(backgroundcolor),
          body: Column(
            children: [
              // HEADER ***
              const HeaderItem(), // herşey HeaderItem.dart'ta yazıyor
              //TOP COLUMN ***
              Expanded(// wrapwidget diyip expanded yazdık scroll yukarı aşa kaysın diye
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: SingleChildScrollView(
                      // aşa yukarı kayması için bunu ekledik
                      child: FutureBuilder(
                        future: todoService.getUncompletedTodos(), // snapshot'u mu method'tan al dedik
                        builder: (context, snapshot) { // veriyi çektiğimiz saatteki görüntüsü
                        if(snapshot.data == null){
                          return CircularProgressIndicator();
                        }
                        else{
                          return ListView.builder(
                          //ListView 'in amacı todo'nun içindeki input kadar kart widgeti döndürüyoruz
                          primary:false, // hemen üstte SingleChildScroll... var diye bunu ekledik
                          shrinkWrap:true, // hemen üstte SingleChildScroll... var diye bunu ekledik
                          itemCount: snapshot.data!.length, // sadece data varsa bunun lenght'ini itemCount'a eşitle
                          itemBuilder: (context, index) {
                            return TodoItem(task: snapshot.data![index]); // buara method kullandık - title'nin içine yukarıdaki string todo'yu attık ve burada kullandık
                          }
                        );
                        }
                      }
                      ),
                      ),
                ),
              ),
              // COMPLETED TEXT ***
              const Padding(
                padding: EdgeInsets.only(left:25), // (ilk baş alt satırı oku) sadece sol taraftan 20 birim boşluk bırak
                child: Align(// (ilk baş alt satırı oku) burayı da wrapWidget'ledik ve Padding ekledik
                    alignment: Alignment.centerLeft, // (ilk baş alt satırı oku) ve sonra bu Text'i sola çektik
                    child:Text("Competed",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20)) //text'i yazdık, sonra wrapWidget diyip Align ekledik
                    ),
              ),
              // BOTTOM COLUMN ***              
              Expanded(
                // wrapwidget diyip expanded yazdık scroll yukarı aşa kaysın diye
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: SingleChildScrollView(
                      // aşa yukarı kayması için bunu ekledik
                      child: FutureBuilder(
                        future: todoService.getcompletedTodos(), // snapshot'u mu method'tan al dedik
                        builder: (context, snapshot) { // veriyi çektiğimiz saatteki görüntüsü
                        if(snapshot.data == null){
                          return CircularProgressIndicator();
                        }
                        else{
                          return ListView.builder(
                          //ListView 'in amacı todo'nun içindeki input kadar kart widgeti döndürüyoruz
                          primary:false, // hemen üstte SingleChildScroll... var diye bunu ekledik
                          shrinkWrap:true, // hemen üstte SingleChildScroll... var diye bunu ekledik
                          itemCount: snapshot.data!.length, // sadece data varsa bunun lenght'ini itemCount'a eşitle
                          itemBuilder: (context, index) {
                            return TodoItem(task: snapshot.data![index]); // buara method kullandık - title'nin içine yukarıdaki string todo'yu attık ve burada kullandık
                          }
                        );
                        }
                      }
                      ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(// bu navigator satırı tuşa basınca başka bir ekran çağarma olayı
                    builder: (context) =>AddNewTaskScreen( addNewTask: (newTask) => addNewTask(newTask),), // tuşa basınca AddNewTaskScreen ekranı açılsın dedik
                  ));
                },
                child: const Text("Add New Task"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
