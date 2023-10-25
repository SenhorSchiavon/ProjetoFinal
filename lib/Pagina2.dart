import 'package:flutter/material.dart';
import 'Banco.dart';

class Pagina2 extends StatefulWidget {
  const Pagina2({Key? key}) : super(key: key);

  @override
  _Pagina2State createState() => _Pagina2State();
}

class _Pagina2State extends State<Pagina2> {
  final campoNome = TextEditingController();
  final campoTelefone = TextEditingController();
  final campoEndereco = TextEditingController();
  final campoQuantidade = TextEditingController();
  final campoTipo = TextEditingController();

  void _fazerPedido() {
    String nome = campoNome.text;
    String telefone = campoTelefone.text;
    String endereco = campoEndereco.text;
    int quantidade = int.tryParse(campoQuantidade.text) ?? 0;
    String tipo = campoTipo.text;

    Banco.inserirPedido(nome, telefone, endereco, quantidade, tipo);

    campoNome.clear();
    campoTelefone.clear();
    campoEndereco.clear();
    campoQuantidade.clear();
    campoTipo.clear();

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Encomendas",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                margin: EdgeInsets.only(top: 20),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Nome",
                  hintText: "Informe o Nome",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      gapPadding: 10,
                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 50,
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                ),
                controller: campoNome,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Telefone",
                  hintText: "Informe o seu Telefone",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      gapPadding: 10,
                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 50,
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                ),
                controller: campoTelefone,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Endereço",
                  hintText: "Informe o Endereço",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      gapPadding: 10,
                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 50,
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                ),

                controller: campoEndereco,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Quantidade",
                  hintText: "Informe a quantidade",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 50,
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                ),
                controller: campoQuantidade,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Tipo",
                  hintText: "LowCarb, Fitness, Salgado, Suco Detox",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      gapPadding: 50,
                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    gapPadding: 50,
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                ),
                controller: campoTipo,
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  minimumSize: MaterialStateProperty.all(Size(80,80)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.white)
                  ))
                ),
                onPressed: () {
                  _fazerPedido();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Item incluído com sucesso!!"),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: Text("Fazer o Pedido",style:
                  TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }



