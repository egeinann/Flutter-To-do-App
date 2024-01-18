// ***** Servis dediğimiz olay backEnd ile frontEnd arasındaki bağlantı katmanı *****

import 'dart:convert';
import 'package:http/http.dart' as http; // bunu yazdık response için
import 'package:todo_app/model/todo.dart';

class TodoService {
  final String url = "https://dummyjson.com/todos/"; // base url
  final String addurl = "https://dummyjson.com/todos/add"; // base add url (save için)

  // getUncompletedTodos
  Future<List<Todo>> getUncompletedTodos() async { // getTodos oluşturduk ve bu future döndürüyor async keywordu ile işaretlendi ve asenkron oldu
    final response = await http.get(Uri.parse(url)); // yuakrıdaki url'e get isteği yaptık ve await diyerek gelmesini bekledik.
    List<dynamic> resp = jsonDecode(response.body)["todos"]; // json içindeki body'yi alıyor (url'yi biliyor)
    List<Todo> todos=List.empty(growable: true); // todos'un kaç tane elemanı olacağını bilmediğimiz için boş liste oluşturduk ve growable: true dedik listeye ekleme yapabilmemizi sağlayacak

    resp.forEach((element) { // foreach ile elemanları tek tek gezdi
      Todo task = Todo.fromJson(element);
      if(task.completed! == false){ // false
        todos.add(task);
      }
    });

    return todos;
  }
  // getcompletedTodos
  Future<List<Todo>> getcompletedTodos() async { // getTodos oluşturduk ve bu future döndürüyor async keywordu ile işaretlendi ve asenkron oldu
    final response = await http.get(Uri.parse(url)); // yuakrıdaki url'e get isteği yaptık ve await diyerek gelmesini bekledik.
    List<dynamic> resp = jsonDecode(response.body)["todos"]; // json içindeki body'yi alıyor (url'yi biliyor)
    List<Todo> todos=List.empty(growable: true); // todos'un kaç tane elemanı olacağını bilmediğimiz için boş liste oluşturduk ve growable: true dedik listeye ekleme yapabilmemizi sağlayacak

    resp.forEach((element) { // foreach ile elemanları tek tek gezdi
      Todo task = Todo.fromJson(element);
      if(task.completed! == true){ //true
        todos.add(task);
      }
    });

    return todos;
  }
  // SAVE TODO API İSTEKYoutube videosu
  Future<String> addTodo(Todo newTodo) async { // add_new_task.dart içerisindeki save ile alakalı void methodu için(aşağıdaki)
    final response = await http.post(Uri.parse(addurl), // response yaptığımız isteğin cevabı olacak ve cevaba göre de hareketler yapıcaz addurl'yi yukarıda tanımlamıştık ve ekledik
    headers: <String,String>{"Content-Type":"application/json; charset=UTF-8"}, // headers'in json olduğunu belirtmek için buraya bir map oluşturduk ve Content_Type'ına karakter seti ekledik
    body: json.encode(newTodo.toJson()));

    print(response.body); // save'ye basınca print ettik
    return response.body; // API'den gelen yanıtı döndür
  }
}
// her şey bitince home.dart'a servis için bir kaç şey ekeyeceğiz