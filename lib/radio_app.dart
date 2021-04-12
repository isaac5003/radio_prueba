import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_2/home_screen.dart';
import 'package:prueba_2/radio/asset_audio_player.dart';
import 'package:prueba_2/radio/radio_player.dart';

import 'bloc/player_bloc.dart';

class RadioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RadioPlayer radioPlayer = AssetAudioPlayer();
    return MaterialApp(
      title: 'Online Radio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BlocProvider<PlayerBloc>(
        create: (context) => PlayerBloc(radioPlayer: radioPlayer),
        child: HomeScreen(),
      ),
    );
  }
}
