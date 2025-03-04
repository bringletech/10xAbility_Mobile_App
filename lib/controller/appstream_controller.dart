import 'dart:async';

class AppStreamController{
  AppStreamController._internal();
  static final AppStreamController _instance = AppStreamController._internal();
  static AppStreamController get instance => _instance;

  StreamController<bool> handleBottomTab = StreamController.broadcast();
  Stream get handleBottomTabAction => handleBottomTab.stream;

  void disposeHandleBottomTabStream() => handleBottomTab.close();

  void rebuildHandleBottomTabStream(){
    if(handleBottomTab.isClosed){
      handleBottomTab = StreamController.broadcast();
    }
  }
}