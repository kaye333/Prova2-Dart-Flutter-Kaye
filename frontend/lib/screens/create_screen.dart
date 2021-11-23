import 'package:flutter/material.dart';
import 'package:frontend/api/backend.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/components/validators.dart';
import 'components/backButton.dart';
import 'components/loginAccountLabel.dart';
import 'components/title.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateScreenState();
  }
}

class CreateScreenState extends State<CreateScreen> {
  final Api api = Api();
  String email = '';
  String name = '';
  String password = '';
  String confirmPassword = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  String? confirmPasswordValid(confirmPassword) {
    final valid = passwordValid(confirmPassword);
    if (valid != null) return valid;
    if (passwordController.text != confirmPassword) {
      return 'Senhas não são iguais';
    }
  }

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

  Widget campoNome() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Nome Completo',
          labelStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white)),
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.name,
      validator: nameValid,
      onSaved: (value) => setState(() => name = value!),
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
      validator: passwordValid,
      controller: passwordController,
      onSaved: (value) => setState(
          () => {password = value!, passwordController.text = password}),
    );
  }

  Widget campoConfirmarSenha() {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
          labelText: 'Confirme a Senha',
          labelStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white)),
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      validator: confirmPasswordValid,
      onSaved: (value) => setState(() => confirmPassword = value!),
      controller: confirmpasswordController,
    );
  }

  Widget botao() => InkWell(
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
          'Cadastrar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () async {
        final isValid = _formKey.currentState!.validate();
        if (isValid) {
          _formKey.currentState!.save();
          final user = await api.create(email, name, password);
          if (user != null) {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else {
            invalidCredentials();
          }
        }
      });

  Future<dynamic> invalidCredentials() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cadastro não efetuado'),
          content: const Text("Não foi possível realizar o cadastro"),
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
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  campoEmail(),
                                  campoNome(),
                                  campoSenha(),
                                  campoConfirmarSenha(),
                                  const SizedBox(height: 20),
                                  botao(),
                                  SizedBox(height: height * .14),
                                  const LoginAccountLabel(),
                                ])))),
                const Positioned(top: 40, left: 0, child: BackB()),
              ],
            )));
  }
}
