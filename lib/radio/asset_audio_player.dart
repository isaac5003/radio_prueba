import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:prueba_2/bloc/player_bloc.dart';
import 'package:prueba_2/radio/radio_player.dart';
import 'package:rxdart/rxdart.dart';

class AssetAudioPlayer extends RadioPlayer {
  final assetPlayer = AssetsAudioPlayer();
  var _isUrlSet = false;
  // var _pauseOrPlay = true;

  @override
  Future<void> play({String url}) async {
    if (!_isUrlSet) {
      await assetPlayer.open(
        Audio.network(
          url,
          metas: Metas(
            title: 'Restauración 100.5',
            artist: 'CCR',
            album: 'Restauración',
            image: MetasImage.network(
                'https://cdn-radiotime-logos.tunein.com/s164825g.png'),
          ),
        ),
        showNotification: true,
        autoStart: true,
        notificationSettings: NotificationSettings(
          prevEnabled: false,
          nextEnabled: false,
          stopEnabled: false,
          playPauseEnabled: true,
          customPlayPauseAction: (player) {
            final bool playing = assetPlayer.isPlaying.value;
            if (playing) {
              assetPlayer.pause();
              return PlayingState();
            } else {
              assetPlayer.play();
              return PausedState();
            }
          },
        ),
      );
      _isUrlSet = true;
    }
    return assetPlayer.play();
  }

  @override
  Future<void> paused() {
    return assetPlayer.pause();
  }
}
