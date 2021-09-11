import 'package:flutter/material.dart';
import 'package:flutter_clubhouse_ui/constants/data.dart';
import 'package:flutter_clubhouse_ui/constants/strings.dart';
import 'package:flutter_clubhouse_ui/presentation/screens/room_screen.dart';

class AppRouter {
  Route? pageRoute(RouteSettings settings) {
    switch (settings.name) {
      case roomScreen:
        final room = settings.arguments;
        return MaterialPageRoute(builder: (BuildContext context) {
          return RoomScreen(room: room as Room);
        });
    }
  }
}
