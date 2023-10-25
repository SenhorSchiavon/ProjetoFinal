import 'package:flutter/material.dart';
import 'Pagina1.dart';
import 'Pagina2.dart';
import 'Pagina3.dart';
import 'drawer_menu.dart';

class Principal extends StatefulWidget {
  final int paginaAtual;

  Principal({Key? key, required this.paginaAtual}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  double xOffset = 0;
  double yOffset = 0;
  IconData menuIcon = Icons.menu;
  bool isDrawerOpen = false;

  void toggleDrawer() {
    setState(() {
      if (isDrawerOpen) {
        xOffset = 0;
        yOffset = 0;
        isDrawerOpen = false;
        menuIcon = Icons.menu;
      } else {
        xOffset = 290;
        yOffset = 80;
        isDrawerOpen = true;
        menuIcon = Icons.arrow_back;
      }
    });
  }

  void changePage(int index) {
    setState(() {
      // Utilize widget.paginaAtual para atualizar a página.
      print("O valor da página atual é ${widget.paginaAtual}");
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (widget.paginaAtual == 1) {
      body = Pagina1();
    } else if (widget.paginaAtual == 2) {
      body = Pagina2();
    } else if (widget.paginaAtual == 3) {
      body = RecuperarPosicao();
    } else {
      body = Center(
        child: Text('Conteúdo da Página Principal'),
      );
    }

    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isDrawerOpen ? BorderRadius.circular(20) : BorderRadius.circular(0),
      ),
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset("imagens/arvorebranca.png", height: 50),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(menuIcon),
            onPressed: toggleDrawer,
          ),
        ),
        body: body,
      ),
    );
  }
}
