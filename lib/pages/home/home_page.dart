import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/home_item.dart';
import '../../routes.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(const LoadHomeData()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  int _selectedIndex = 0;
  String _userName = 'Лукиных София Даниловна';
  String _userEmail = 'sofi@gmail.com';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      setState(() {
        _userName = args['name'] ?? _userName;
        _userEmail = args['email'] ?? _userEmail;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 1) {
      Navigator.pushNamed(
        context,
        Routes.profile,
        arguments: {'name': _userName, 'email': _userEmail},
      ).then((_) {
        if (mounted) setState(() => _selectedIndex = 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Онлайн-кинотеатры', style: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          switch (state) {
            case HomeInitial():
              return const Center(child: Text('Данные не загружены'));
            case HomeLoading():
              return const Center(child: CircularProgressIndicator());
            case HomeError(:final message):
              return Center(child: Text(message));
            case HomeLoaded(:final items, :final images):
              return _HomeContent(
                items: items,
                images: images,
                onItemTap: (title) {
                  if (title == 'Личный кабинет') {
                    _onItemTapped(1);
                  } else {
                    Navigator.pushNamed(context, Routes.detail);
                  }
                },
              );
          }
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final List<HomeItem> items;
  final List<String> images;
  final Function(String) onItemTap;

  const _HomeContent({required this.items, required this.images, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitle(),
                      const SizedBox(height: 20),
                      _buildDescription(),
                      const SizedBox(height: 20),
                      _buildImagesGrid(),
                    ],
                  ),
                ),
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
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(images[index], width: 150, height: 150, fit: BoxFit.cover),
                    ),
                  ),
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
          leading: Icon(item.icon, color: Colors.pink),
          title: Text(item.title),
          subtitle: Text(item.subtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => onItemTap(item.title),
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
          leading: Icon(item.icon, color: Colors.pink),
          title: Text(item.title, style: const TextStyle(fontSize: 14)),
          onTap: () => onItemTap(item.title),
        ),
      );
    },
  );

  Widget _buildAuthor() => const Row(children: [Icon(Icons.person, size: 40, color: Colors.pink), SizedBox(width: 12), Text('Лукиных С.Д., группа ИКБО-61-23', style: TextStyle(fontFamily: 'Ubuntu', fontSize: 16))]);
}