library avatar_hover;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:morphable_shape/morphable_shape.dart';

class AvatarHover {
  final GlobalKey widgetKey;
  final BuildContext context;
  final bool online;
  final String? url;
  final List<PopupMenuItem>? itemsMenu;
  final bool hoverMenu;
  final List<Color> colors;
  final double height;
  final double width;
  final double statusHeight;
  final double statusWidth;
  final double bottom;
  final double right;
  final Widget? avatarChild;

  AvatarHover({
    required this.widgetKey,
    required this.context,
    required this.online,
    this.avatarChild,
    this.hoverMenu = false,
    this.url,
    this.colors = const [],
    this.itemsMenu,
    this.height = 100,
    this.width = 100,
    this.right = 6.8,
    this.bottom = 6.8,
    this.statusHeight = 20,
    this.statusWidth = 20,
  }) : assert (itemsMenu == null,
    "itemsMenu cannot be null"
  );

  Widget avatar() {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      width: 116,
      child: MouseRegion(
        onHover: hoverMenu ? (PointerHoverEvent e) async {
          await menuAvatar(e);
        } : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              fit: StackFit.loose,
              alignment: Alignment.bottomCenter,
              children: [
                Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: colors.isNotEmpty ? colors : const [
                          Color(0xFFa8bf2c),
                          Color(0xFF237aa0),
                          Color(0xFFee1c78),
                          Color(0xFFff9213),
                          Color(0xFFf62a59),
                        ],
                        tileMode: TileMode.repeated,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white,
                            width: 3
                          )
                        ),
                        child: CircleAvatar(
                          key: widgetKey,
                          backgroundColor: url != null
                            ? Colors.transparent
                            : Colors.transparent,
                          backgroundImage: url != null
                            ? NetworkImage(url!)
                            : null,
                          child: avatarChild,
                          radius: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: bottom,
                  right: right,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: online
                        ? const Color(0xFF44E011)
                        : Colors.grey,
                      border: Border.all(
                        width: 1.8,
                        color: Colors.white
                      ),
                    ),
                    child: online ? null : const Center(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                    height: statusHeight,
                    width: statusWidth,
                  ),
                )
              ],
            ),
          ]
        ),
      ),
    );
  }

  Future menuAvatar(PointerHoverEvent e) {
    RenderBox box = widgetKey.currentContext?.findRenderObject() as RenderBox;
    Offset offset = box.localToGlobal(Offset.zero);
    Rect rect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      box.size.width,
      box.size.height
    );
    double dx = rect.left - rect.width / 2 - 15;
    double dy = rect.bottom + 15;

    return showMenu(
      context: context,
      shape: RectangleShapeBorder(
        borderRadius: DynamicBorderRadius.all(
          DynamicRadius.circular(6.toPXLength)
        ),
      ),
      position: RelativeRect.fromLTRB(
        dx,
        dy,
        dx,
        dy,
      ),
      items: [
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.alternate_email_rounded),
              SizedBox(width: 8,),
              Text(
                "Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          mouseCursor: SystemMouseCursors.basic,
        ),
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.book),
              SizedBox(width: 8,),
              Text(
                "My books",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          mouseCursor: SystemMouseCursors.basic,
        ),
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.settings),
              SizedBox(width: 8,),
              Text(
                "Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          mouseCursor: SystemMouseCursors.basic,
        ),
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.exit_to_app),
              SizedBox(width: 8,),
              Text(
                "Log out",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          mouseCursor: SystemMouseCursors.basic,
        )
      ]
    );
  }
}

