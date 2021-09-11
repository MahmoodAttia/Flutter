import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clubhouse_ui/constants/data.dart';
import 'package:flutter_clubhouse_ui/constants/strings.dart';
import 'package:flutter_clubhouse_ui/presentation/widgets/user_profile_image.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({Key? key, required this.room}) : super(key: key);
  final Room room;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, roomScreen, arguments: room),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.club.toUpperCase(),
                  style: Theme.of(context).textTheme.overline!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.0,
                      ),
                ),
                Text(
                  room.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned(
                                left: 28.0,
                                top: 20.0,
                                child: UserProfileImage(
                                  imageUrl: room.others[0].imageUrl,
                                )),
                            UserProfileImage(
                              imageUrl: room.others[1].imageUrl,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...room.speakers.map(
                            (e) => Text(
                              '${e.familyName} ${e.givenName}  💬',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                  text:
                                      '${room.others.length + room.followedBySpeakers.length} '),
                              WidgetSpan(
                                  child: Icon(
                                CupertinoIcons.person_fill,
                                color: Colors.grey,
                                size: 18,
                              )),
                              TextSpan(text: '/ '),
                              TextSpan(text: '${room.speakers.length} '),
                              WidgetSpan(
                                  child: Icon(
                                CupertinoIcons.chat_bubble_fill,
                                color: Colors.grey,
                                size: 18,
                              )),
                            ])),
                          ),
                        ],
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
