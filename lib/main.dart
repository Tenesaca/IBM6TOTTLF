
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp()); // Cambiado el nombres de la app a MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SICA App (IBM6TOBTTLF)', // Título de la aplicación
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  // Lista de páginas que se mostrarán en el cuerpo del Scaffold
  // El orden aquí debe coincidir con el orden de los BottomNavigationBarItem
  final List<Widget> _pages = [
    SexoPage(),
    TelefonoPage(),
    PersonaPage(),
    EstadocivilPage(), // Nueva página para Estado Civil
    DireccionPage(), // Nueva página para Direccion
    Placeholder(), // Página "Acerca de" o cualquier otra que desees
  ];

  // Función que se llama cuando se toca un elemento del BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SICA - Registro(IBM6TOB)")), // Título de la AppBar
      body: _pages[_selectedIndex], // Muestra la página seleccionada
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Sexo'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Telefono'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Persona'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Estado Civil',
          ), // Nuevo ítem para Estado Civil
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Direccion',
          ), // Nuevo ítem para Direccion
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Acerca de'),
        ],
        currentIndex:
            _selectedIndex, // Índice del ítem seleccionado actualmente
        onTap: _onItemTapped, // Callback cuando se toca un ítem
        selectedItemColor: Colors.blue, // Color del ítem seleccionado
        unselectedItemColor: Colors.grey, // Color de los ítems no seleccionados
        type:
            BottomNavigationBarType
                .fixed, // Asegura que todos los items se muestren
      ),
    );
  }
}

// --- Clases de Modelo ---

// Modelo para los datos de Sexo
class Sexo {
  final String idsexo;
  final String nombre;

  Sexo({required this.idsexo, required this.nombre});

  factory Sexo.fromJson(Map<String, dynamic> json) {
    return Sexo(idsexo: json['idsexo'].toString(), nombre: json['nombre']);
  }
}

// Modelo para los datos de Telefono
class Telefono {
  final String idtelefono;
  final String numero;

  Telefono({required this.idtelefono, required this.numero});

  factory Telefono.fromJson(Map<String, dynamic> json) {
    return Telefono(
      idtelefono: json['idtelefono'].toString(),
      numero: json['numero'],
    );
  }
}

// Modelo para los datos de Estadocivil
class Estadocivil {
  final String idestadocivil;
  final String nombre;

  Estadocivil({required this.idestadocivil, required this.nombre});

  factory Estadocivil.fromJson(Map<String, dynamic> json) {
    return Estadocivil(
      idestadocivil: json['idestadocivil'].toString(),
      nombre: json['nombre'],
    );
  }
}

// Modelo para los datos de Direccion
class Direccion {
  final String iddireccion;
  final String calleprincipal;
  final String callesecundaria;
  final String numerocasa;

  Direccion({
    required this.iddireccion,
    required this.calleprincipal,
    required this.callesecundaria,
    required this.numerocasa,
  });

  factory Direccion.fromJson(Map<String, dynamic> json) {
    return Direccion(
      iddireccion: json['iddireccion'].toString(),
      calleprincipal: json['calleprincipal'] ?? 'N/A',
      callesecundaria: json['callesecundaria'] ?? 'N/A',
      numerocasa: json['numerocasa'] ?? 'N/A',
    );
  }
}

// Modelo para los datos de Persona
class Persona {
  final String idpersona;
  final String nombres;
  final String apellidos;
  final String elsexo;
  final String elestadocivil;
  final String fechanacimiento; // Asumiendo que viene como String

  Persona({
    required this.idpersona,
    required this.nombres,
    required this.apellidos,
    required this.elsexo,
    required this.elestadocivil,
    required this.fechanacimiento,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      idpersona: json['idpersona'].toString(),
      nombres: json['nombres'] ?? 'N/A',
      apellidos: json['apellidos'] ?? 'N/A',
      elsexo: json['elsexo'] ?? 'N/A',
      elestadocivil: json['elestadocivil'] ?? 'N/A',
      fechanacimiento: json['fechanacimiento'] ?? 'N/A',
    );
  }
}

// --- Páginas de Contenido ---

// Página para mostrar la lista de Sexo
class SexoPage extends StatefulWidget {
  const SexoPage({super.key});

  @override
  _SexoPageState createState() => _SexoPageState();
}

class _SexoPageState extends State<SexoPage> {
  List<Sexo> _sexoList = [];
  List<Sexo> _filteredSexoList = [];
  String _searchText = '';
  bool _isLoading = true; // Para mostrar un indicador de carga

  @override
  void initState() {
    super.initState();
    _fetchSexoData();
  }

  Future<void> _fetchSexoData() async {
    setState(() {
      _isLoading = true; // Inicia la carga
    });
    try {
<<<<<<< HEAD
      final response = await http.get(Uri.parse('https://educaysoft.org/ibm6b/app/controllers/SexoController.php?action=api'));
=======
      final response = await http.get(
        Uri.parse(
          'https://educaysoft.org/apple6b/app/controllers/SexoController.php?action=api',
        ),
      );
>>>>>>> 8bf4f60b626fa305cfbcff9ddf4910bce1cea6d5
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _sexoList = data.map((item) => Sexo.fromJson(item)).toList();
          _filteredSexoList = _sexoList;
        });
      } else {
        throw Exception(
          'Error al cargar datos de Sexo: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error al obtener datos de Sexo: $e');
      // Podrías mostrar un mensaje de error al usuario aquí
    } finally {
      setState(() {
        _isLoading = false; // Finaliza la carga
      });
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _searchText = query;
      _filteredSexoList =
          _sexoList
              .where(
                (item) =>
                    item.nombre.toLowerCase().contains(query.toLowerCase()) ||
                    item.idsexo.contains(query),
              )
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
              labelText: 'Buscar Sexo',
              hintText: 'Ingrese nombres o ID',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        // Lista de registros
        Expanded(
          child:
              _isLoading
                  ? Center(
                    child: CircularProgressIndicator(),
                  ) // Indicador de carga
                  : _filteredSexoList.isEmpty
                  ? Center(child: Text("No hay datos de Sexo disponibles"))
                  : ListView.builder(
                    itemCount: _filteredSexoList.length,
                    itemBuilder: (context, index) {
                      final sexo = _filteredSexoList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.people, color: Colors.blueAccent),
                          title: Text(
                            sexo.nombre,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("ID: ${sexo.idsexo}"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
                          onTap: () {
                            // Acción al hacer tap en un elemento de sexo
                            print('Sexo seleccionado: ${sexo.nombre}');
                          },
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}

<<<<<<< HEAD

=======
>>>>>>> 8bf4f60b626fa305cfbcff9ddf4910bce1cea6d5
// Página para mostrar la lista de Telefono
class TelefonoPage extends StatefulWidget {
  const TelefonoPage({super.key});

  @override
  _TelefonoPageState createState() => _TelefonoPageState();
}

class _TelefonoPageState extends State<TelefonoPage> {
  List<Telefono> _telefonoList = [];
  List<Telefono> _filteredTelefonoList = [];
  String _searchText = '';
  bool _isLoading = true; // Para mostrar un indicador de carga

  @override
  void initState() {
    super.initState();
    _fetchTelefonoData();
  }

  Future<void> _fetchTelefonoData() async {
    setState(() {
      _isLoading = true; // Inicia la carga
    });
    try {
<<<<<<< HEAD
      final response = await http.get(Uri.parse('https://educaysoft.org/ibm6b/app/controllers/TelefonoController.php?action=api'));
=======
      final response = await http.get(
        Uri.parse(
          'https://educaysoft.org/apple6b/app/controllers/TelefonoController.php?action=api',
        ),
      );
>>>>>>> 8bf4f60b626fa305cfbcff9ddf4910bce1cea6d5
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _telefonoList = data.map((item) => Telefono.fromJson(item)).toList();
          _filteredTelefonoList = _telefonoList;
        });
      } else {
        throw Exception(
          'Error al cargar datos de Telefono: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error al obtener datos de Telefono: $e');
      // Podrías mostrar un mensaje de error al usuario aquí
    } finally {
      setState(() {
        _isLoading = false; // Finaliza la carga
      });
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _searchText = query;
      _filteredTelefonoList =
          _telefonoList
              .where(
                (item) =>
                    item.numero.toLowerCase().contains(query.toLowerCase()) ||
                    item.idtelefono.contains(query),
              )
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
              labelText: 'Buscar Telefono',
              hintText: 'Ingrese numeros o ID',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        // Lista de registros
        Expanded(
          child:
              _isLoading
                  ? Center(
                    child: CircularProgressIndicator(),
                  ) // Indicador de carga
                  : _filteredTelefonoList.isEmpty
                  ? Center(child: Text("No hay datos de Telefono disponibles"))
                  : ListView.builder(
                    itemCount: _filteredTelefonoList.length,
                    itemBuilder: (context, index) {
                      final telefono = _filteredTelefonoList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: Colors.blueAccent,
                          ), // Icono cambiado
                          title: Text(
                            telefono.numero,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("ID: ${telefono.idtelefono}"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
                          onTap: () {
                            // Acción al hacer tap en un elemento de telefono
                            print('Telefono seleccionado: ${telefono.numero}');
                          },
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}

<<<<<<< HEAD
// Página para mostrar la lista de Persona
class PersonaPage extends StatefulWidget {
=======
// Página para mostrar la lista de Estadocivil
class EstadocivilPage extends StatefulWidget {
  const EstadocivilPage({super.key});

>>>>>>> 8bf4f60b626fa305cfbcff9ddf4910bce1cea6d5
  @override
  _EstadocivilPageState createState() => _EstadocivilPageState();
}

class _EstadocivilPageState extends State<EstadocivilPage> {
  List<Estadocivil> _estadocivilList = [];
  List<Estadocivil> _filteredEstadocivilList = [];
  String _searchText = '';
  bool _isLoading = true; // Para mostrar un indicador de carga

  @override
  void initState() {
    super.initState();
    _fetchEstadocivilData();
  }

  Future<void> _fetchEstadocivilData() async {
    setState(() {
      _isLoading = true; // Inicia la carga
    });
    try {
<<<<<<< HEAD
      final response = await http.get(Uri.parse('https://educaysoft.org/ibm6b/app/controllers/PersonaController.php?action=api'));
=======
      final response = await http.get(
        Uri.parse(
          'https://educaysoft.org/apple6b/app/controllers/EstadocivilController.php?action=api',
        ),
      );
>>>>>>> 8bf4f60b626fa305cfbcff9ddf4910bce1cea6d5
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _estadocivilList =
              data.map((item) => Estadocivil.fromJson(item)).toList();
          _filteredEstadocivilList = _estadocivilList;
        });
      } else {
        throw Exception(
          'Error al cargar datos de Estadocivil: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error al obtener datos de Estadocivil: $e');
      // Podrías mostrar un mensaje de error al usuario aquí
    } finally {
      setState(() {
        _isLoading = false; // Finaliza la carga
      });
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _searchText = query;
      _filteredEstadocivilList =
          _estadocivilList
              .where(
                (item) =>
                    item.nombre.toLowerCase().contains(query.toLowerCase()) ||
                    item.idestadocivil.contains(query),
              )
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
              labelText: 'Buscar Estado Civil',
              hintText: 'Ingrese nombres o ID',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        // Lista de registros
        Expanded(
          child:
              _isLoading
                  ? Center(
                    child: CircularProgressIndicator(),
                  ) // Indicador de carga
                  : _filteredEstadocivilList.isEmpty
                  ? Center(
                    child: Text("No hay datos de Estado Civil disponibles"),
                  )
                  : ListView.builder(
                    itemCount: _filteredEstadocivilList.length,
                    itemBuilder: (context, index) {
                      final estadocivil = _filteredEstadocivilList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ), // Icono
                          title: Text(
                            estadocivil.nombre,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("ID: ${estadocivil.idestadocivil}"),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
                          onTap: () {
                            // Acción al hacer tap en un elemento de estado civil
                            print(
                              'Estado Civil seleccionado: ${estadocivil.nombre}',
                            );
                          },
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}

// Página para mostrar la lista de Direccion
class DireccionPage extends StatefulWidget {
  const DireccionPage({super.key});

  @override
  _DireccionPageState createState() => _DireccionPageState();
}

class _DireccionPageState extends State<DireccionPage> {
  List<Direccion> _direccionList = [];
  List<Direccion> _filteredDireccionList = [];
  String _searchText = '';
  bool _isLoading = true; // Para mostrar un indicador de carga

  @override
  void initState() {
    super.initState();
    _fetchDireccionData();
  }

  Future<void> _fetchDireccionData() async {
    setState(() {
      _isLoading = true; // Inicia la carga
    });
    try {
      // Replace with your actual API endpoint for Direccion
      final response = await http.get(
        Uri.parse(
          'https://educaysoft.org/apple6b/app/controllers/DireccionController.php?action=api',
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _direccionList =
              data.map((item) => Direccion.fromJson(item)).toList();
          _filteredDireccionList = _direccionList;
        });
      } else {
        throw Exception(
          'Error al cargar datos de Direccion: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error al obtener datos de Direccion: $e');
      // Podrías mostrar un mensaje de error al usuario aquí
    } finally {
      setState(() {
        _isLoading = false; // Finaliza la carga
      });
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _searchText = query;
      _filteredDireccionList =
          _direccionList
              .where(
                (item) =>
                    item.calleprincipal.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    item.callesecundaria.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    item.numerocasa.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    item.iddireccion.contains(query),
              )
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
              labelText: 'Buscar Direccion',
              hintText: 'Ingrese calle principal, secundaria, número o ID',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        // Lista de registros
        Expanded(
          child:
              _isLoading
                  ? Center(
                    child: CircularProgressIndicator(),
                  ) // Indicador de carga
                  : _filteredDireccionList.isEmpty
                  ? Center(child: Text("No hay datos de Dirección disponibles"))
                  : ListView.builder(
                    itemCount: _filteredDireccionList.length,
                    itemBuilder: (context, index) {
                      final direccion = _filteredDireccionList[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.orange,
                          ),
                          title: Text(
                            "Calle Principal: ${direccion.calleprincipal}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ID: ${direccion.iddireccion}"),
                              Text(
                                "Calle Secundaria: ${direccion.callesecundaria}",
                              ),
                              Text("Número Casa: ${direccion.numerocasa}"),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
                          onTap: () {
                            // Acción al hacer tap en un elemento de direccion
                            print(
                              'Dirección seleccionada: ${direccion.calleprincipal}',
                            );
                          },
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}

// Página para mostrar la lista de Persona
class PersonaPage extends StatefulWidget {
  const PersonaPage({super.key});

  @override
  _PersonaPageState createState() => _PersonaPageState();
}

class _PersonaPageState extends State<PersonaPage> {
  List<Persona> _personaList = [];
  List<Persona> _filteredPersonaList = [];
  String _searchText = '';
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPersonaData();
    _searchController.addListener(() {
        _filterSearch(_searchController.text);
    });
  }

 @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchPersonaData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse(
          'https://educaysoft.org/apple6b/app/controllers/PersonaController.php?action=api',
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _personaList = data.map((item) => Persona.fromJson(item)).toList();
          _filteredPersonaList = _personaList;
        });
      } else {
        throw Exception(
          'Error al cargar datos de Persona: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error al obtener datos de Persona: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos: $e'), backgroundColor: Colors.redAccent,),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterSearch(String query) {
    setState(() {
      _searchText = query;
      _filteredPersonaList = _personaList
          .where(
            (item) =>
                item.nombres.toLowerCase().contains(query.toLowerCase()) ||
                item.apellidos.toLowerCase().contains(query.toLowerCase()) ||
                item.idpersona.contains(query) || // Buscar por ID
                item.fechanacimiento.contains(query),
          )
          .toList();
    });
  }

  // Función para mostrar detalles (ejemplo)
  void _showPersonaDetails(Persona persona) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text("${persona.nombres} ${persona.apellidos}"),
              content: SingleChildScrollView(
                  child: ListBody(
                      children: <Widget>[
                          Text("ID: ${persona.idpersona}"),
                          Text("Fecha Nacimiento: ${persona.fechanacimiento}"),
                          Text("Sexo: ${persona.elsexo}"),
                          Text("Estado Civil: ${persona.elestadocivil}"),
                          // Aquí podrías añadir más detalles o acciones
                      ],
                  ),
              ),
              actions: <Widget>[
                  TextButton(
                      child: const Text('Cerrar'),
                      onPressed: () {
                          Navigator.of(context).pop();
                      },
                  ),
              ],
          ),
      );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barra de búsqueda mejorada
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Buscar Persona',
              hintText: 'Ingrese nombres, apellidos, ID o fecha...',
              prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor),
              suffixIcon: _searchText.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                         _searchController.clear();
                         _filterSearch('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0), // Bordes redondeados
                borderSide: BorderSide.none, // Sin borde visible
              ),
              filled: true,
              fillColor: Colors.grey[200], // Fondo sutil
              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            ),
          ),
        ),
        // Lista de registros
        Expanded(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _filteredPersonaList.isEmpty
                  ? Center(
                      child: Text(
                        _personaList.isEmpty
                            ? "No hay datos de Personas disponibles."
                            : "No se encontraron coincidencias.",
                        style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 8.0), // Padding horizontal para la lista
                      itemCount: _filteredPersonaList.length,
                      itemBuilder: (context, index) {
                        final persona = _filteredPersonaList[index];
                        final initials = persona.nombres.isNotEmpty && persona.apellidos.isNotEmpty
                            ? persona.nombres[0] + persona.apellidos[0]
                            : 'P';
                        final avatarColor = Colors.primaries[persona.idpersona.hashCode % Colors.primaries.length].shade100;
                        final avatarTextColor = Colors.primaries[persona.idpersona.hashCode % Colors.primaries.length].shade700;


                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: InkWell( // Hace la tarjeta tappable
                            onTap: () => _showPersonaDetails(persona),
                            borderRadius: BorderRadius.circular(12.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: avatarColor,
                                    child: Text(
                                      initials.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: avatarTextColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(width: 15.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${persona.nombres} ${persona.apellidos}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0,
                                              color: Colors.black87),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          "ID: ${persona.idpersona} | Nac: ${persona.fechanacimiento}",
                                          style: TextStyle(color: Colors.grey[700], fontSize: 13.0),
                                        ),
                                        SizedBox(height: 3.0),
                                         Wrap( // Usa Wrap para que no se desborde si no cabe
                                          spacing: 8.0, // Espacio horizontal
                                          runSpacing: 4.0, // Espacio vertical
                                          children: [
                                              Chip(
                                                label: Text(persona.elsexo, style: TextStyle(fontSize: 11)),
                                                backgroundColor: persona.elsexo.toLowerCase() == 'masculino' ? Colors.blue.shade50 : Colors.pink.shade50,
                                                avatar: Icon(persona.elsexo.toLowerCase() == 'masculino' ? Icons.male : Icons.female, size: 16),
                                                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
                                                labelPadding: EdgeInsets.only(left: 2.0, right: 4.0),
                                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              ),
                                              Chip(
                                                label: Text(persona.elestadocivil, style: TextStyle(fontSize: 11)),
                                                backgroundColor: Colors.grey.shade100,
                                                avatar: Icon(Icons.favorite_border, size: 16, color: Colors.red.shade300,),
                                                padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
                                                labelPadding: EdgeInsets.only(left: 2.0, right: 4.0),
                                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.grey.shade400),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                     ),
      ],
    );
  }
}

