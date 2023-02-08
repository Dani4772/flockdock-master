import 'package:flocdock/mixin/data.dart';
import 'package:flocdock/services/dio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLibrary with WidgetsBindingObserver {
  late AppLifecycleState _state;
  AppLifecycleState get state => _state;
  MyLibrary() {
    WidgetsBinding.instance?.addObserver(this);
  }

  /// make sure the clients of this library invoke the dispose method
  /// so that the observer can be unregistered
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _state = state;
    print(_state.toString());
    if(AppData().isAuthenticated&&_state==AppLifecycleState.resumed)
      onlineUser();
    else if(AppData().isAuthenticated&&_state==AppLifecycleState.paused)
      offlineUser();
  }
  void onlineUser() async {
    await DioService.post('online_user', {
      "userId": AppData().userdetail!.usersId
    });
  }
  void offlineUser() async {
    await DioService.post('offline_user', {
      "userId": AppData().userdetail!.usersId
    });
  }
}