import 'package:flutter/material.dart';
import 'package:projeto_final/CadastrarComanda.dart';
import 'package:projeto_final/CadastrarConta.dart';
import 'package:projeto_final/ListarComandas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_final/Pagina1.dart';
import 'package:projeto_final/Principal.dart';

class Logado extends StatefulWidget {
  const Logado({super.key});

  @override
  State<Logado> createState() => _LogadoState();
}

class _LogadoState extends State<Logado> {
  final name = 'FitGarden';
  int indice = 0;
  List telas = [
    ListarComandas(),
    CadastrarComanda(),
    CadastrarConta()
  ];

  int paginaAtual = 1;
  void changePage(int newPage) {
    // Define a function named changePage.
    setState(() {
      paginaAtual = newPage;
    });
  }

  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel de Controle"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: Material(
          color: Colors.green,
          child: ListView(
            padding: padding,
            children: <Widget>[
              buildHeader(
                name: name,
              ),
              const SizedBox(height: 48),
              ListTile(
                leading: Icon(Icons.list_alt, color: Colors.white),
                title: Text("Comandas em Aberto", style: TextStyle(color: Colors.white)),
                hoverColor: Colors.white70,
                onTap: (){
                  setState(() {
                    indice = 0;
                    Navigator.pop(context);
                  });
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.request_page_outlined, color: Colors.white),
                title: Text("Cadastrar Comanda", style: TextStyle(color: Colors.white)),
                hoverColor: Colors.white70,
                onTap: (){
                  setState(() {
                    indice = 1;
                    Navigator.pop(context);
                  });
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.person_add, color: Colors.white),
                title: Text("Cadastrar Conta", style: TextStyle(color: Colors.white)),
                hoverColor: Colors.white70,
                onTap: (){
                  setState(() {
                    indice = 2;
                    Navigator.pop(context);
                  });
                },
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 24),
              Divider(color: Colors.white70),
              const SizedBox(height: 24),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text("Deslogar", style: TextStyle(color: Colors.white)),
                hoverColor: Colors.white70,
                onTap: (){
                  Deslogar();
                  setState(() {
                    Navigator.of(context).pushNamed('/home');
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: telas[indice],
    );
  }
}

Widget buildMenuItem({
  required String text,
  required IconData icon
}){
  final color = Colors.white;
  final hoverColor = Colors.white70;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text,style: TextStyle(
      color: color
    ) ),
    hoverColor: hoverColor,

  );
}

void Deslogar() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
}

Widget buildHeader({
  required String name,
}) =>
    InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Row(
          children: [
            CircleAvatar(radius: 30, child: Image.asset("imagens/arvorebranca.png"),backgroundColor: Colors.green,),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 20, color: Colors.white),

                ),
                const SizedBox(height: 4),
              ],
            ),
            Spacer(),

          ],
        ),
      ),
    );