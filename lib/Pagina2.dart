import 'package:flutter/material.dart';
import 'package:projeto_final/Banco.dart';

class Pagina2 extends StatefulWidget {
  const Pagina2({Key? key}) : super(key: key);

  @override
  _Pagina2State createState() => _Pagina2State();
}

const List<String> list = ["LowCarb", "Fitness", "Salgado", "Suco Detox"];

class _Pagina2State extends State<Pagina2> {
  final campoNome = TextEditingController();
  final campoTelefone = TextEditingController();
  final campoEndereco = TextEditingController();
  final campoQuantidade = TextEditingController();
  final campoTipo = TextEditingController();

  String dropdownValue = list.isNotEmpty ? list.first : "";

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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Encomendas",
              style: TextStyle(
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
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
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Telefone",
                hintText: "Informe o Telefone",
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
            SizedBox(height: 20),
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
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: InputDecoration(
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
              value: dropdownValue,
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value ?? "";
                  campoTipo.text = value ?? ""; // Atualiza campoTipo
                });
              },
              items: list.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white12),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      minimumSize: MaterialStateProperty.all(Size(0, 60)),
                    ),
                    onPressed: () {
                      _fazerPedido();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Pedido efetuado com SUCESSO!!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: Text("Fazer Pedido"),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
