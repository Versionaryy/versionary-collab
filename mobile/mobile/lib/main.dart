import 'package:flutter/material.dart';
import 'tela_cadastro.dart';
import 'tela_feed.dart';
import 'tela_criarpost.dart';
import 'tela_comentarios.dart';
import 'tela_perfil.dart';
import 'tela_notificacoes.dart';

void main() => runApp(VersionaryApp());

class VersionaryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/cadastro': (context) => CadastroPage(),
        '/feed': (context) => TelaFeed(),
        '/criarpost': (context) => TelaCriarPost(),
        '/perfil': (context) => TelaPerfil(),
        '/notificacoes': (context) => TelaNotificacoes(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/comentarios') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) => TelaComentarios(
              username: args['username']!,
              conteudo: args['conteudo']!,
              tag: args['tag']!,
            ),
          );
        }
        return null;
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final Color roxo = const Color(0xFF7C3389);
  final Color fundoLogin = const Color(0xFFCFB4D3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/logo.png'),
                  backgroundColor: Colors.black,
                ),
                const SizedBox(height: 10),
                Text(
                  'Versionary',
                  style: TextStyle(
                    color: roxo,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'COLLAB',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Card de login
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: fundoLogin,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: roxo,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Faça login com seu email',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    'Esqueceu sua senha?',
                    style: TextStyle(
                      color: roxo,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/feed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: roxo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/cadastro');
              },
              child: Text(
                'Criar conta',
                style: TextStyle(
                  color: roxo,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
