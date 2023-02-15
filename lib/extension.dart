extension GetLabel on String {
  String getLabel(){
    return split(' ').last.toUpperCase();
  }
}