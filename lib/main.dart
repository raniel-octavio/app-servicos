import 'package:flutter/material.dart';

void main() {
  runApp(const FixlyApp());
}

class FixlyApp extends StatelessWidget {
  const FixlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fixly',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// ---------------- SPLASH ----------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          "Fixly",
          style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ---------------- LOGIN ----------------


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter your mobile number",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Campo de telefone com código do país
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("+55 🇧🇷", style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Your phone number",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Botão continuar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                  child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),

              const SizedBox(height: 30),

              // Opções alternativas
              Center(
                child: Column(
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.g_mobiledata, size: 28),
                      label: const Text("Continue with Google"),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.email),
                      label: const Text("Continue with Email"),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Find my account"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------- HOME ----------------


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),          // conteúdo da Home
    const ServicesScreen(),       // tela de Serviços
    const ServiceSelectionScreen(serviceName: "Serviço"), // exemplo de Atividades
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.miscellaneous_services), label: "Serviços"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Atividades"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Conta"),
        ],
      ),
    );
  }
}

// ---------------- CONTEÚDO DA HOME ----------------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Serviços", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Entregas", style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            ),

            // Barra de busca
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Onde precisa?",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    onPressed: () {},
                    child: const Text("Agora", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            // Locais salvos
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Locais salvos", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            _locationTile(Icons.work, "Trabalho", "Av. Paulista, 1000", Colors.blueAccent),
            _locationTile(Icons.home, "Casa", "Rua das Flores, 123", Colors.green),

            // Sugestões com imagens
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Sugestões", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _suggestionCard("assets/chaveiro.png", "Chaveiro"),
                  _suggestionCard("assets/eletricista.png", "Eletricista"),
                  _suggestionCard("assets/consertos.png", "Consertos"),
                  _suggestionCard("assets/eletro.png", "Eletrodomésticos"),
                ],
              ),
            ),

            // Planejamento
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text("Formas de planejar com Fixly", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            _planCard("Agende um serviço", "assets/calendar.png"),
            _planCard("Serviços emergenciais", "assets/emergency.png"),
          ],
        ),
      ),
    );
  }

  static Widget _locationTile(IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {},
    );
  }

  static Widget _suggestionCard(String imagePath, String label) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(imagePath, width: 70, height: 70, fit: BoxFit.cover),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  static Widget _planCard(String title, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(imagePath, width: 100, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}


// ---------------- SERVIÇOS ----------------

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Serviços",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selecione um serviço",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
                children: [
                  _serviceCard(context, "assets/chaveiro.png", "Chaveiro", "Serviços rápidos de chaveiro"),
                  _serviceCard(context, "assets/eletricista.png", "Eletricista", "Instalações e reparos elétricos"),
                  _serviceCard(context, "assets/consertos.png", "Consertos", "Reparos gerais para sua casa"),
                  _serviceCard(context, "assets/eletro.png", "Eletrodomésticos", "Assistência para eletrodomésticos"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _serviceCard(BuildContext context, String imagePath, String title, String subtitle) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LocationSelectionScreen(),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.grey)),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- SELEÇÃO DE SERVIÇO ----------------
class ServiceSelectionScreen extends StatelessWidget {
  final String serviceName;

  const ServiceSelectionScreen({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    final options = [
      {"title": "$serviceName Pro 1", "price": "R\$ 80,00", "eta": "Chega em 20 min"},
      {"title": "$serviceName Pro 2", "price": "R\$ 70,00", "eta": "Chega em 30 min"},
      {"title": "$serviceName Pro 3", "price": "R\$ 90,00", "eta": "Chega em 40 min"},
      {"title": "$serviceName Pro 4", "price": "R\$ 100,00", "eta": "Chega em 1h"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Escolha um serviço",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          // Mapa simulado
          SizedBox(
            height: double.infinity,
            child: Image.asset(
              "assets/map.png", // imagem estática simulando o mapa
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Painel arrastável estilo Uber
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.3,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Escolha uma opção disponível",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // Lista de opções
                    ...options.map((option) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          title: Text(option["title"]!),
                          subtitle: Text("${option["price"]} • ${option["eta"]}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ServiceSelectionScreen(serviceName: "Serviço"),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 100), // espaço para o rodapé
                  ],
                ),
              );
            },
          ),

          // Rodapé estilo Uber
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Visa ****1059", style: TextStyle(color: Colors.white)),
                      Icon(Icons.keyboard_arrow_up, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationScreen(
                            serviceName: serviceName,
                            price: "Preço variável",
                            eta: "Tempo estimado",
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Escolher $serviceName",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ---------------- CONFIRMAÇÃO ----------------
class ConfirmationScreen extends StatelessWidget {
  final String serviceName;
  final String price;
  final String eta;

  const ConfirmationScreen({
    super.key,
    required this.serviceName,
    required this.price,
    required this.eta,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Confirmação", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Text(
          "Você selecionou $serviceName\nPreço: $price\nChegada: $eta",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}



// ---------------- TRACKING ----------------
class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acompanhamento")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Finalizar e pagar"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentScreen()),
            );
          },
        ),
      ),
    );
  }
}

// ---------------- PAGAMENTO ----------------
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pagamento")),
      body: Center(
        child: const Text("Escolha método de pagamento e avalie o serviço."),
      ),
    );
  }
}
// ---------------- CONTA ----------------
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Conta", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Perfil do usuário
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/profile.png"), // imagem do perfil
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Marcelo Silva",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4),
                      Text("4.88 • Verificado",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Promoções
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Você tem várias promoções — Aplicaremos automaticamente a mais vantajosa.",
              style: TextStyle(fontSize: 14),
            ),
          ),

          const SizedBox(height: 20),

          // Saldo
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Saldo: R\$42,25",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),

          const SizedBox(height: 20),

          // Seções
          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Pessoal"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          const Divider(),

          const ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("Ajuda"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          const Divider(),

          const ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text("Carteira"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
          const Divider(),

          const ListTile(
            leading: Icon(Icons.history),
            title: Text("Atividades"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ],
      ),
    );
  }
}

// ---------------- SELEÇÃO DE LOCAL ----------------
class LocationSelectionScreen extends StatelessWidget {
  const LocationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locais = [
      {"nome": "Posto da Gruta", "endereco": "Av. Benedito Matarazzo, 4229", "distancia": "3.1 km"},
      {"nome": "Freakout", "endereco": "R. Luís Jacinto, 240 – Centro", "distancia": "9.4 km"},
      {"nome": "Rodoviária São José", "endereco": "R. Itororó, 221 – Vila Piratininga", "distancia": "9.7 km"},
      {"nome": "Monacolounge", "endereco": "Rua Luiz Jacinto, 260 – Centro", "distancia": "9.4 km"},
      {"nome": "Terminal Jacareí", "endereco": "Av. Eng. David Monteiro Lino, 585", "distancia": "7.9 km"},
      {"nome": "Bar do Manabu", "endereco": "Praça Cariri, 112 – Chácaras Reunidas", "distancia": "2.8 km"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Selecione o local", style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          // Mapa simulado
          SizedBox(
            height: double.infinity,
            child: Image.asset(
              "assets/map.png", // imagem estática simulando o mapa
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Painel arrastável
          // Painel arrastável
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.3,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    // Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ),
                    // Localização atual
                    Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: const Icon(Icons.my_location, color: Colors.blue),
                        title: const Text("Localização atual"),
                        subtitle: const Text("Avenida Benedito Doming..."),

                      ),
                    ),
                    // Campo de busca
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Onde precisa?",
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Sugestões próximas",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // Lista de locais sugeridos
                    ...locais.map((local) {
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.place, color: Colors.black),
                          title: Text(local["nome"]!),
                          subtitle: Text("${local["endereco"]} • ${local["distancia"]}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ServiceSelectionScreen(serviceName: "Serviço"),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 100),
                  ],
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}
