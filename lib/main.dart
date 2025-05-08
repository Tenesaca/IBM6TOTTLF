import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(SexoApp());
}

class SexoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sexo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
   final List<Widget> _pages = [SexoPage(), Placeholder()];
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SICA - Registro Sexo")),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Sexo'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Acerca de'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Sexo {
  final String idsexo;
  final String nombre;

  Sexo({required this.idsexo, required this.nombre});

  factory Sexo.fromJson(Map<String, dynamic> json) {
    return Sexo(
      idsexo: json['idsexo'].toString(),
      nombre: json['nombre'],
    );
  }
}

class SexoPage extends StatefulWidget {
  @override
  _SexoPageState createState() => _SexoPageState();
}

class _SexoPageState extends State<SexoPage> {
  List<Sexo> _sexoList = [];
  List<Sexo> _filteredSexoList = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _fetchSexoData();
  }

  Future<void> _fetchSexoData() async {
    try {
      final response = await http.get(Uri.parse('https://educaysoft.org/apple6b/app/controllers/SexoController.php?action=api'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _sexoList = data.map((item) => Sexo.fromJson(item)).toList();
          _filteredSexoList = _sexoList;
        });
      } else {
        throw Exception('Error al cargar datos');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _searchText = query;
      _filteredSexoList = _sexoList
          .where((item) =>
              item.nombre.toLowerCase().contains(query.toLowerCase()) ||
              item.idsexo.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra de búsqueda
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: _filterSearch,
            decoration: InputDecoration(
              labelText: 'Buscar',
              hintText: 'Ingrese nombre o ID',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        // Lista de registros
        Expanded(
          child: _filteredSexoList.isEmpty
              ? Center(child: Text("No hay datos"))
              : ListView.builder(
                  itemCount: _filteredSexoList.length,
                  itemBuilder: (context, index) {
                    final sexo = _filteredSexoList[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.label),
                        title: Text(sexo.nombre),
                        subtitle: Text("ID: ${sexo.idsexo}"),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
