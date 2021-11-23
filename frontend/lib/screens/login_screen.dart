import 'package:flutter/material.dart';
import 'package:frontend/api/backend.dart';
import 'package:frontend/screens/create_screen.dart';
import 'package:frontend/screens/user.dart';
import 'package:frontend/screens/components/validators.dart';
import 'components/backButton.dart';
import 'components/title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, title = 'Login Screen'}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final Api api = Api();
  String email = '';
  String password = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget campoEmail() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'E-mail',
          labelStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white)),
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: emailValid,
      onSaved: (value) => setState(() => email = value!),
    );
  }

  Widget campoSenha() {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
          labelText: 'Senha',
          labelStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white)),
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      onSaved: (value) => setState(() => password = value!),
    );
  }

  Widget botaoLogin() => InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff000000), Color(0xff000000)])),
        child: const Text(
          'Acessar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () async {
        final isValid = _formKey.currentState!.validate();
        if (isValid) {
          _formKey.currentState!.save();
          final name = await api.login(email, password);
          if (name != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => User(name)),
            );
          } else {
            acessoNegado();
          }
        }
      });

  Future<dynamic> acessoNegado() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Acesso negado'),
          content: const Text("Usuário ou senha inválido"),
          backgroundColor: Colors.white70,
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });

  Widget divisoria() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1, color: Colors.white),
            ),
          ),
          Text(
            'ou',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 1, color: Colors.white),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget botaoFacebook() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.5,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: const Text('f',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w400)),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: const Text('Acesse com o Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }

  Widget criarContaLink() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CreateScreen()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Não possui conta ?',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Cadastre-se',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            height: height,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff03befc), Color(0xff000000)])),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                      child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: height * .2),
                                const TitleBanner(),
                                const SizedBox(height: 50),
                                campoEmail(),
                                const SizedBox(
                                  height: 80,
                                ),
                                campoSenha(),
                                const SizedBox(height: 20),
                                botaoLogin(),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.centerRight,
                                  child: const Text('Esqueceu a senha ?',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white)),
                                ),
                                divisoria(),
                                botaoFacebook(),
                                SizedBox(height: height * .055),
                                criarContaLink(),
                                SizedBox(height: height * .12),
                              ]))),
                ),
                const Positioned(top: 40, left: 0, child: BackB()),
              ],
            )));
  }
}
