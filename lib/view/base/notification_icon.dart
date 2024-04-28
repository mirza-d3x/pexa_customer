import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  NotificationIcon({
    super.key,
    required this.backgroundColor,
    this.isHome = false,
    @required this.hasNotification = false,
  });

  final Color? backgroundColor;
  bool isHome;
  bool hasNotification;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(children: [
        Icon(Icons.notifications_none_outlined,
            size: 18, color: Theme.of(context).secondaryHeaderColor),
        hasNotification
            ? Positioned(
                top: 1,
                right: 1,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        // width: 2,
                        color: backgroundColor != null &&
                                backgroundColor == Colors.transparent
                            ? isHome
                                ? Theme.of(context).primaryColor
                                : Colors.white.withOpacity(0.7)
                            : Theme.of(context).primaryColor),
                  ),
                ))
            : const SizedBox(),
      ]),
    );
  }
}
