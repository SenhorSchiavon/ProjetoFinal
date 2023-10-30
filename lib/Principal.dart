import 'package:flutter/material.dart';
import 'package:projeto_final/Pagina1.dart';
import 'package:projeto_final/Banco.dart';
import 'package:projeto_final/Pagina2.dart';
import 'package:projeto_final/Pagina3.dart';
import 'package:projeto_final/Pagina4.dart';
class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int indice = 0;
  List telas = [
  Pagina1(),
  Pagina2(),
  RecuperarPosicao(),
  Pagina4()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("imagens/arvorebranca.png",scale: 100,),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),

                child: Column(
                  children: [
                    Image.asset("imagens/arvorepreta.png",height: 100,),
                    Text("Fitgarden")
                  ],
                )
            ),
            ListTile(
              title: Text("Nossos Produtos",style: TextStyle(
                  color: Colors.green
              ),),
              leading: Icon(Icons.fastfood,color: Colors.green,),
              onTap: (){
                setState(() {
                  indice = 0;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text("Pedido",style: TextStyle(color: Colors.green),),
              leading: Icon(Icons.request_page_outlined,color: Colors.green,),
              onTap: (){
                setState(() {
                  indice = 1;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text("Onde estamos",style: TextStyle(color: Colors.green),),
              leading: Icon(Icons.location_on_outlined, color: Colors.green,),
              onTap: (){
                setState(() {
                  indice = 2;
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text("Login",style: TextStyle(color: Colors.green),),
              leading: Icon(Icons.logout, color: Colors.green,),
              onTap: (){
                setState(() {
                  indice = 3;
                  Navigator.pop(context);
                });
              },
            ),


          ],
        ),
      ),
      body: telas[indice],
    );
  }
}
