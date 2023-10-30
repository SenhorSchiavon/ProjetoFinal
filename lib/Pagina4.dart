import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_final/logado.dart';


class Pagina4 extends StatefulWidget {
  const Pagina4({Key? key}) : super(key: key);

  @override
  _Pagina4State createState() => _Pagina4State();
}

class _Pagina4State extends State<Pagina4> {
  TextEditingController campoLogin = TextEditingController();
  TextEditingController campoSenha = TextEditingController();
  bool isCampoLoginFocused = false;
  bool isCampoSenhaFocused = false;

  void autenticar() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    FirebaseAuth auth = FirebaseAuth.instance;
    String email = campoLogin.text;
    String senha = campoSenha.text;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: senha);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Logado()));

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Bem-vindo",style: TextStyle(
                color: Colors.green
            ),),
            content: Text("Login efetuado com sucesso!",style: TextStyle(
                color: Colors.green
            ),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Fechar"),
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Falha em Logar",style: TextStyle(
              color: Colors.red
            ),),
            content: Text("Credenciais Invalidas.Tente novamente",style: TextStyle(
                color: Colors.red
            ),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Fechar",style: TextStyle(
                  color: Colors.red
                ),),
              ),
            ],
          );
        },
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "imagens/logobranca.png",
                  height: 200,
                ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: 15,
                      color: isCampoLoginFocused ? Colors.white : Colors.black,
                      height: -1
                    ),
                    child: Text("Login"),
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      focusColor: Colors.grey,
                      filled: true,
                      fillColor: Colors.white,
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
                    onTap: () {
                      setState(() {
                        isCampoLoginFocused = true;
                      });
                    },
                    onEditingComplete: () {
                      setState(() {
                        isCampoLoginFocused = false;
                      });
                    },
                  ),
                  SizedBox(height: 45),
                  AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: 15,
                      color: isCampoSenhaFocused ? Colors.white : Colors.black,
                      height: -1
                    ),
                    child: Text("Senha"),
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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
                    onTap: () {
                      setState(() {
                        isCampoSenhaFocused = true;
                      });
                    },
                    onEditingComplete: () {
                      setState(() {
                        isCampoSenhaFocused = false;
                      });
                    },
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
                            autenticar();
                          },
                          child: Text(
                            "Logar",
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
