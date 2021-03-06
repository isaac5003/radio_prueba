import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/line_scale_pulse_out_indicator.dart';
import 'package:loading/loading.dart';
import 'package:prueba_2/widgets/idle_dots.dart';

import 'bloc/player_bloc.dart';

class HomeScreen extends StatelessWidget {
  final _planetRockUrl =
      'https://ssl.rockhost.com/proxy/restauracion?mp=/mp3_128';
  final _planetRockImage =
      'https://cdn-radiotime-logos.tunein.com/s164825g.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Radio'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: Container(
          child: Center(
            child: BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, state) {
                if (state is PausedState) {
                  return IdleDots(color: Theme.of(context).accentColor);
                } else if (state is PlayingState) {
                  return Loading(
                    indicator: LineScalePulseOutIndicator(),
                    size: 100,
                    color: Theme.of(context).accentColor,
                  );
                } else {
                  throw Exception('Unknown state of bloc');
                }
              },
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Theme.of(context).primaryColor,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 50,
                width: 50,
                child: Image.network(_planetRockImage),
              ),
            ),
            Text(
              'Restauracion',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, state) {
                  if (state is PausedState) {
                    return IconButton(
                      icon: Icon(
                        Icons.play_arrow,
                        size: 32,
                      ),
                      onPressed: () {
                        BlocProvider.of<PlayerBloc>(context)
                            .add(PlayEvent(url: _planetRockUrl));
                      },
                    );
                  } else {
                    return IconButton(
                      icon: Icon(
                        Icons.pause,
                        size: 32,
                      ),
                      onPressed: () {
                        BlocProvider.of<PlayerBloc>(context).add(PausedEvent());
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PauseEvent {}
