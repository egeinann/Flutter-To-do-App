// ***** BACK-END İŞLERİ *****
class Todo {
  Todo(
      {required this.id,
      required this.todo,
      required this.completed,
      required this.userId});

  int?id; //bu field'ların herzaman dolu gelip gelmeyeceğini bilmediğimiz için soru işareti ekledik
  String? todo;
  bool? completed;
  int? userId;

  // From json
  Todo.fromJson(Map<String, dynamic> json) {
    id = json["id"]; // Todo içinde bulunan id field'ını Json mapi değişkeninden gelecek olan "id" isimli şeye eşitledik
    todo = json["todo"];
    completed = json["completed"];
    userId = json["userId"];
  }

  //To json
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data={};
    data["id"] = id;
    data["todo"] = todo;
    data["completed"] = completed;
    data["userId"] = userId;
    return data;
  }
}
// !!! NOT : Burada elle yaptığımız büyün işleri google  >  json to dart  >  1 adet objeyi yapıştırıyoruz  >  buradaki bütün kodları bizim için yazıyor
// bu sayfada işimiz bittikten sonra servis oluşturmamız gerek (servis yapısının projeye uygun olması için lib'e yeni klasör oluştur...)