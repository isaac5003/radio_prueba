import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prueba_2/radio/radio_player.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final RadioPlayer radioPlayer;
  PlayerBloc({@required this.radioPlayer})
      : assert(radioPlayer != null),
        super(PausedState());

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is PlayEvent && state is! PlayingState) {
      radioPlayer.play(url: event.url);
      yield PlayingState();
    } else if (event is PausedEvent) {
      radioPlayer.paused();
      yield PausedState();
    }
  }
}
