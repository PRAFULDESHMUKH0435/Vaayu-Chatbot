class AppException{
  String? message;
  String? prefix;
  AppException({required this.message,required this.prefix});


  String ToString(){
    return "$message $prefix";
  }
}

