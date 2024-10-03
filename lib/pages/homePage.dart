import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_firebase/controller/homeController.dart';
import 'package:login_firebase/data/repositories/github_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HerosUsers _HerosUsers = HerosUsers();

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(
          'Lista de Heróis',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder(
        future: _HerosUsers.fetchHeroInformation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao acessar API! ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final heros = snapshot.data!;
            return ListView.builder(
              itemCount: heros.length,
              itemBuilder: (context, index) {
                final hero = heros[index];
                return ListTile(
                  leading: hero.heroImage.isNotEmpty
                      ? Image.network(
                          hero.heroImage,
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        )
                      : SizedBox(width: 50, height: 75),
                  title: Text(hero.name),
                  subtitle: Text('Herói: ${hero.name}'),
                  onTap: () {
                    var details = hero.details;
                    _launchURL(details);
                  },
                );
              },
            );
          } else {
            return Center(child: Text('Nenhum dado disponível'));
          }
        },
      ),
    );
  }
}