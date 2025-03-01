import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Widget? leading;

  const AdaptiveAppBar({
    super.key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoNavigationBar(context)
        : _buildMaterialAppBar(context);
  }

  Widget _buildMaterialAppBar(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
    );
  }

  Widget _buildCupertinoNavigationBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text(title),
      trailing: actions != null && actions!.isNotEmpty
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            )
          : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Platform.isIOS
      ? const Size.fromHeight(44)
      : const Size.fromHeight(kToolbarHeight);
}
