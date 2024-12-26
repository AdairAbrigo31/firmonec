
class TypesQuipux {
  static int quipuxEspol(){
    return 0;
  }

  static int quipuxNatural(){
    return 1;
  }

  static String getNameTypeQuipux(int code){
    if(code == 0){
      return "Espol";
    } else {
      return "Natural";
    }
  }
}