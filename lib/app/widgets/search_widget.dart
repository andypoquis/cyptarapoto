import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: const TextField(
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Buscar',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          focusedBorder: InputBorder.none, // Anula el borde cuando se enfoca
          enabledBorder:
              InputBorder.none, // Anula el borde cuando está habilitado
          icon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }
}
