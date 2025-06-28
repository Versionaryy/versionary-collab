import 'package:flutter/material.dart';

class TelaPerfil extends StatelessWidget {
  static const Color roxo = Color(0xFF7C3389); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 10),
          Image.asset('assets/logo.png', height: 80),
          const SizedBox(height: 10),
          const CircleAvatar(
            radius: 40,
            backgroundColor: roxo,
            child: Icon(Icons.person, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 8),
          const Text('user', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Color(0xFFF5E8F8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: const [
                PerfilCampo(label: 'E-mail', hint: 'Alterar e-mail'),
                PerfilCampo(label: 'Senha', hint: 'Alterar senha'),
                PerfilCampo(label: 'Usuário', hint: 'Alterar usuário'),
                PerfilCampo(label: 'Data de nascimento', hint: 'Alterar data de nascimento'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // salvar alterações
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: roxo,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text(
              'SALVAR',
              style: TextStyle(color: Colors.white)
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              // sair
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              side: const BorderSide(color: roxo),
            ),
            child: const Text('SAIR', style: TextStyle(color: roxo)),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: () => Navigator.pop(context)),
            IconButton(icon: const Icon(Icons.person), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: roxo,
        onPressed: () {
          // botão "+"
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class PerfilCampo extends StatelessWidget {
  final String label;
  final String hint;

  const PerfilCampo({required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
