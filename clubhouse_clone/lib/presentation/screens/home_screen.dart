import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clubhouse_ui/constants/data.dart';
import 'package:flutter_clubhouse_ui/presentation/widgets/room_card.dart';
import 'package:flutter_clubhouse_ui/presentation/widgets/upcoming_rooms.dart';
import 'package:flutter_clubhouse_ui/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.search,
              size: 28,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.envelope_open,
                size: 26,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.calendar,
                size: 28,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.bell,
                size: 28,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 10.0, 20.0, 10.0),
                child: UserProfileImage(
                  imageUrl: currentUser.imageUrl,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
        body: Stack(alignment: Alignment.center, children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 120.0),
            children: [
              UpcomingRooms(upcomingRooms: upcomingRoomsList),
              const SizedBox(
                height: 12.0,
              ),
              ...roomsList.map((e) => RoomCard(room: e)),
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                  Theme.of(context).scaffoldBackgroundColor,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              )),
          Positioned(
            bottom: 60,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Text.rich(TextSpan(children: [
                WidgetSpan(
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
                TextSpan(
                  text: ' Start a room',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ])),
            ),
          ),
          Positioned(
            bottom: 60.0,
            right: 40.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.circle_grid_3x3_fill,
                    size: 28.0,
                  ),
                  onPressed: () {},
                ),
                Positioned(
                    right: 4.6,
                    bottom: 11.8,
                    child: Container(
                        height: 16.0,
                        width: 16.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).accentColor,
                        ))),
              ],
            ),
          )
        ]));
  }
}
