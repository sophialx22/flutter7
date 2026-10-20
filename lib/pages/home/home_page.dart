import 'package:flutter/material.dart';
import '../../routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  String _userName = 'Иванов Иван Иванович';
  String _userEmail = 'test123@mail.ru';

  final List<String> images = const [
    'assets/images/11.jpg',
    'assets/images/10.jpg',
    'assets/images/3.jpg',
    'assets/images/9.jpg',
    'assets/images/14.png',
  ];

  final List<Map<String, dynamic>> items = const [
    {'title': 'Просмотр фильмов', 'subtitle': 'Смотрите фильмы и сериалы онлайн', 'icon': Icons.play_circle},
    {'title': 'Подписка', 'subtitle': 'Оформите подписку на сервис', 'icon': Icons.card_membership},
    {'title': 'Онлайн-трансляция', 'subtitle': 'Прямые трансляции и премьеры', 'icon': Icons.live_tv},
    {'title': 'Личный кабинет', 'subtitle': 'Управляйте своим профилем', 'icon': Icons.person},
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      _userName = args['name'] ?? _userName;
      _userEmail = args['email'] ?? _userEmail;
    }
  }

  Future<void> _openProfile() async {
    final result = await Navigator.pushNamed(
      context,
      Routes.profile,
      arguments: {'name': _userName, 'email': _userEmail},
    );
    if (result != null && result is Map) {
      setState(() {
        _userName = result['name'] ?? _userName;
        _userEmail = result['email'] ?? _userEmail;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 1) _openProfile();
  }

  void _onItemCardTap(String title) {
    if (title == 'Личный кабинет') {
      _openProfile();
    } else {
      Navigator.pushNamed(context, Routes.detail);
    }
  }

  Widget _buildHomeContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWide = constraints.maxWidth > 600;
        final double spacing = isWide ? 50 : 20;

        if (isWide) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildTitle(), const SizedBox(height: 20), _buildDescription(), const SizedBox(height: 20), _buildImagesGrid()])),
                SizedBox(width: spacing),
                Expanded(child: _buildItemsGrid()),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(),
              const SizedBox(height: 20),
              _buildDescription(),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) => Container(margin: const EdgeInsets.only(right: 10), child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset(images[index], width: 150, height: 150, fit: BoxFit.cover))),
                ),
              ),
              const SizedBox(height: 20),
              _buildItemsList(),
              const SizedBox(height: 30),
              _buildAuthor(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitle() => Container(width: double.infinity, padding: const EdgeInsets.all(16), decoration: BoxDecoration(border: Border.all(color: Colors.pink), borderRadius: BorderRadius.circular(20)), child: const Text('Название ПО: Онлайн-кинотеатр', style: TextStyle(fontFamily: 'Ubuntu', fontSize: 20, fontWeight: FontWeight.bold)));
  Widget _buildDescription() => Container(width: double.infinity, padding: const EdgeInsets.all(16), decoration: BoxDecoration(border: Border.all(color: Colors.pink), borderRadius: BorderRadius.circular(20)), child: const Text('Описание: Онлайн-кинотеатр — это сервис, который позволяет смотреть фильмы и сериалы через интернет без скачивания.', style: TextStyle(fontFamily: 'Ubuntu', fontSize: 16)));
  Widget _buildImagesGrid() => SizedBox(height: 200, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: images.length, itemBuilder: (context, index) => Container(margin: const EdgeInsets.only(right: 10), child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset(images[index], width: 150, height: 150, fit: BoxFit.cover)))));

  Widget _buildItemsList() => ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: Icon(item['icon'], color: Colors.pink),
          title: Text(item['title']),
          subtitle: Text(item['subtitle']),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _onItemCardTap(item['title']),
        ),
      );
    },
  );

  Widget _buildItemsGrid() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.5),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Card(
        child: ListTile(
          leading: Icon(item['icon'], color: Colors.pink),
          title: Text(item['title'], style: const TextStyle(fontSize: 14)),
          onTap: () => _onItemCardTap(item['title']),
        ),
      );
    },
  );

  Widget _buildAuthor() => const Row(children: [Icon(Icons.person, size: 40, color: Colors.pink), SizedBox(width: 12), Text('Лукиных С.Д., группа ИКБО-61-23', style: TextStyle(fontFamily: 'Ubuntu', fontSize: 16))]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Онлайн-кинотеатры', style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.bold)), centerTitle: true, backgroundColor: Colors.pink),
      body: _buildHomeContent(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [NavigationDestination(icon: Icon(Icons.home), label: 'Главная'), NavigationDestination(icon: Icon(Icons.person), label: 'Профиль')],
      ),
    );
  }
}