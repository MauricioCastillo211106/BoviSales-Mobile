// lib/presentation/widgets/search_bar.dart
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSearch;
  final void Function()? onFilter;

  SearchBar({
    required this.controller,
    required this.onSearch,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black, // Fondo negro para todo el widget
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Fondo blanco para la barra de búsqueda
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  hintText: 'Buscar Bovino',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                ),
                onSubmitted: onSearch,
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: onFilter,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFC67C4E), // Color café para el botón de filtro
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.filter_list, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
