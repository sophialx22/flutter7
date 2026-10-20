import 'package:flutter/material.dart';
import '../models/home_item.dart';

const List<HomeItem> homeItems = [
  HomeItem(
    title: 'Просмотр фильмов',
    subtitle: 'Смотрите фильмы и сериалы онлайн',
    icon: Icons.play_circle,
  ),
  HomeItem(
    title: 'Подписка',
    subtitle: 'Оформите подписку на сервис',
    icon: Icons.card_membership,
  ),
  HomeItem(
    title: 'Онлайн-трансляция',
    subtitle: 'Прямые трансляции и премьеры',
    icon: Icons.live_tv,
  ),
  HomeItem(
    title: 'Личный кабинет',
    subtitle: 'Управляйте своим профилем',
    icon: Icons.person,
  ),
];

const List<String> homeImages = [
  'assets/images/11.jpg',
  'assets/images/10.jpg',
  'assets/images/3.jpg',
  'assets/images/9.jpg',
  'assets/images/14.png',
];