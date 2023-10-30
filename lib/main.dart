import 'package:flutter/material.dart';
import 'package:projeto_final/Principal.dart';
import 'package:projeto_final/drawer_menu.dart';
import 'package:projeto_final/drawer_menu.dart'; // Corrija o nome do arquivo para 'drawer_menu.dart'
import 'Pagina2.dart';
import 'Pagina1.dart';
import 'Pagina3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      routes: {
        '/home': (context) => MainScreen(),
        '/nossos_produtos': (context) => Pagina1(),
        '/pedidos': (context) => Pagina2(),
        '/onde_estamos': (context) => RecuperarPosicao(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int paginaAtual = 1;



  void changePage(int index) {
    setState(() {
      paginaAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: [
        DrawerScreen(changePage: changePage), // Passa o valor de isDrawerOpen
       Principal(paginaAtual: paginaAtual, changePage: changePage),
        ],)
    );
  }
}