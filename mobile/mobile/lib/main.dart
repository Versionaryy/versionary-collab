import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/services/data_class.dart';
import 'package:mobile/services/user_service.dart';
import 'package:provider/provider.dart';
import 'screens/tela_cadastro.dart';
import 'screens/tela_feed.dart';
import 'screens/tela_criarpost.dart';
import 'screens/tela_comentarios.dart';
import 'screens/tela_perfil.dart';
import 'screens/tela_notificacoes.dart';

void main() async {
  await GetStorage.init();
  runApp(const VersionaryApp());
}

class VersionaryApp extends StatelessWidget {
  const VersionaryApp({super.key});

  @override
  Widget build(BuildContext context) {    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataClass()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
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
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => TelaComentarios(
                postId: args['postId'] as int,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}

class UserProvider extends ChangeNotifier {
  UserProvider() {
    _loadTokenFromStorage();
  }

  String? _token;

  String? get token => _token;

  void _loadTokenFromStorage() {
    _token = GetStorage().read('token');
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final response = await loginAPI(email, password);
    setToken(response.token);
  }

  Future<void> setToken(String token) async {
    _token = token;
    await GetStorage().write('token', token);
    notifyListeners();
  }

  Future<void> clearToken() async {
    _token = null;
    await GetStorage().remove('token');
    notifyListeners();
  }
}

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final Color roxo = const Color(0xFF7C3389);

  final Color fundoLogin = const Color(0xFFCFB4D3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Column(
              children: [
                Image.asset('assets/logo.png', height: 160),
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
                    controller: _emailController,
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
                    controller: _passwordController,
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

                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: roxo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
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

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<UserProvider>(context, listen: false)
          .login(_emailController.text, _passwordController.text);

      // Verifica se o widget ainda está na árvore de widgets antes de navegar
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/feed');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha no login: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
