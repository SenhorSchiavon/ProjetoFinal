import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Banco {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> inserirPedido(
      String nome, String telefone, String endereco, int quantidade, String tipo) async {
    await Firebase.initializeApp();

    try {
      await _db.collection("pedidos").add({
        "nome": nome,
        "telefone": telefone,
        "endereco": endereco,
        "quantidade": quantidade,
        "tipo": tipo,
      });
    } catch (e) {
      // Trate possíveis erros aqui
      print("Erro ao inserir o pedido: $e");
    }
  }
}
