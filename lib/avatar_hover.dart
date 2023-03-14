library avatar_hover;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morphable_shape/morphable_shape.dart';

class AvatarHover extends StatefulWidget {
  final GlobalKey widgetKey;
  final BuildContext context;
  final bool online;
  final String? url;
  final List<PopupMenuItem>? itemsMenu;
  final List<Color> colors;
  final double height;
  final double width;
  final double statusHeight;
  final double statusWidth;
  final double bottom;
  final double right;
  final ImageProvider? avatarChild;

  const AvatarHover({
    Key? key,
    required this.widgetKey,
    required this.context,
    required this.online,
    this.avatarChild,
    this.url,
    this.colors = const [],
    this.itemsMenu,
    this.height = 100,
    this.width = 100,
    this.right = 6.8,
    this.bottom = 6.8,
    this.statusHeight = 20,
    this.statusWidth = 20,
  }) : super(key: key);

  @override
  State<AvatarHover> createState() => _AvatarHoverState();
}

class _AvatarHoverState extends State<AvatarHover> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width + 6,
      height: widget.height,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      child: MouseRegion(
        onHover: widget.itemsMenu != null ? (PointerHoverEvent e) async {
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
                        colors: widget.colors.isNotEmpty ? widget.colors : const [
                          Color(0xFFa8bf2c),
                          Color(0xFF237aa0),
                          Color(0xFFee1c78),
                          Color(0xFFff9213),
                          Color(0xFFf62a59),
                        ],
                        tileMode: TileMode.repeated,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: widget.height,
                        width: widget.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          key: widget.widgetKey,
                          backgroundColor: widget.url != null
                              ? Colors.transparent
                              : Colors.transparent,
                          foregroundImage: widget.avatarChild!,
                          radius: 50,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: widget.bottom,
                  right: widget.right,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: widget.online
                          ? const Color(0xFF44E011)
                          : Colors.grey,
                      border: Border.all(
                        width: 1.8,
                        color: Colors.white,
                      ),
                    ),
                    height: widget.statusHeight,
                    width: widget.statusWidth,
                    child: widget.online ? null : const Center(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future menuAvatar(PointerHoverEvent e) {
    RenderBox box = widget.widgetKey.currentContext?.findRenderObject() as RenderBox;
    Offset offset = box.localToGlobal(Offset.zero);
    Rect rect = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      box.size.width,
      box.size.height,
    );
    double dx = rect.left - rect.width / 2 - 15;
    double dy = rect.bottom + 15;

    return showMenu(
      useRootNavigator: true,
      context: context,
      shape: RectangleShapeBorder(
        borderRadius: DynamicBorderRadius.all(
          DynamicRadius.circular(6.toPXLength),
        ),
      ),
      position: RelativeRect.fromLTRB(
        dx,
        dy,
        dx,
        dy,
      ),
      items: widget.itemsMenu == null ? [] : widget.itemsMenu!,
    );
  }
}
