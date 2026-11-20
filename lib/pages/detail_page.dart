import 'package:flutter/material.dart';
import '../models/home_item.dart';
import '../routes.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)?.settings.arguments as HomeItem?;
    final title = item?.title ?? 'Пункт N';
    final subtitle = item?.subtitle ?? 'Описание пункта N';
    final icon = item?.icon ?? Icons.info;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 150,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(const BorderSide(color: Colors.black)),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Icon(icon, size: 60, color: Colors.pink),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 20, fontFamily: 'Ubuntu'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Routes.home);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, Routes.profile);
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}