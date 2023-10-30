import 'package:flutter/material.dart';
import 'package:projeto_final/logado.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastrarConta extends StatefulWidget {
  const CadastrarConta({super.key});

  @override
  State<CadastrarConta> createState() => _CadastrarContaState();
}

class _CadastrarContaState extends State<CadastrarConta> {
  TextEditingController campoLogin = TextEditingController();
  TextEditingController campoSenha = TextEditingController();
  bool isCampoLoginFocused = false;
  bool isCampoSenhaFocused = false;

  void adicionar() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseAuth auth = FirebaseAuth.instance;
    String email = campoLogin.text;
    String senha = campoSenha.text;

    try {
      auth.createUserWithEmailAndPassword(email: email, password: senha);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Conta cadastrada com SUCESSO!!"),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,),
        );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Conta invalida, tente novamente!!"),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "imagens/logopreta.png",
                  height: 200,
                ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      focusColor: Colors.grey,
                      hintText: "Digite o Login",
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
                      color: Colors.black,
                    ),
                    controller: campoLogin,
                  ),
                  SizedBox(height: 45),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Digite a Senha",
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
                      color: Colors.black,
                    ),
                    controller: campoSenha,
                  ),
                  SizedBox(height: 50),
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
                            adicionar();
                          },
                          child: Text(
                            "Adicionar",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
