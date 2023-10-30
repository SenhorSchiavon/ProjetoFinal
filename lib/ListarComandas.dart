import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Banco.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListarComandas(),
    );
  }
}

class ListarComandas extends StatefulWidget {
  const ListarComandas({Key? key}) : super(key: key);

  @override
  State<ListarComandas> createState() => _ListarComandasState();
}

const TWO_PI = 3.14 * 2;

class _ListarComandasState extends State<ListarComandas> {


  final size = 200.0;

  List<Map<String, dynamic>> listaProdutos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> carregarDados() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    listaProdutos.clear();

    try {
      QuerySnapshot todos = await db.collection("pedidos").get();
      todos.docs.forEach((element) {
        var dado = element.data() as Map<String, dynamic>;
        listaProdutos.add(dado);
      });
    } catch (e) {
      print("Erro ao carregar dados: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? FutureBuilder(
          future: Future.delayed(Duration(seconds: 2), () => true), // Simulate loading for 4 seconds
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              carregarDados(); // Carrega os dados após a animação de carregamento
            }
            return TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 2),
              builder: (context, value, child) {
                int percentage = (value * 100).ceil();
                return Container(
                  width: size,
                  height: size,
                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return SweepGradient(
                            startAngle: 0.0,
                            endAngle: TWO_PI,
                            stops: [value, value],
                            center: Alignment.center,
                            colors: [Colors.green, Colors.green.withAlpha(55)],
                          ).createShader(rect);
                        },
                        child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: Image.asset("imagens/arvorepreta.png").image,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )
            : _buildListaProdutos(),
      ),
    );
  }

  Widget _buildListaProdutos() {
    return ListView.builder(
      itemCount: listaProdutos.length,
      itemBuilder: (context, indice) {
        var produto = listaProdutos[indice];

        List<dynamic> tiposSelecionados = produto["tiposSelecionados"];

        String tiposTexto = '';

        tiposSelecionados.forEach((tipo) {
          tiposTexto += '${tipo['tipoSelecionado']} - Quantidade: ${tipo['quantidade']}\n';
        });

        return Dismissible(
          key: Key(produto["id"].toString()),
          onDismissed: (direction) {
            // Seu código de exclusão...
          },
          background: Container(
            color: Colors.red,
            child: Center(
              child: Text(
                'Deslize para excluir',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          child: ListTile(
            title: Text(produto["nome"]),
            subtitle: Text(
              tiposTexto,
            ),
          ),
        );
      },
    );
  }
  }

