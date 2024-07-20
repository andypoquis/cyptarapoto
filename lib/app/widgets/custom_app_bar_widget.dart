import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget searchWidget;
  final Widget? trailing;

  const CustomAppBar({
    Key? key,
    required this.searchWidget,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      elevation: 0, // Deshabilita la sombra
      systemOverlayStyle:
          SystemUiOverlayStyle.dark, // Iconos de sistema en oscuro
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/logo.png', // Ruta del icono de la aplicación
          width: 24, // Ajusta el ancho según tus necesidades
          height: 24, // Ajusta la altura según tus necesidades
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: searchWidget,
      ),
      actions: [
        if (trailing != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: trailing!,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
