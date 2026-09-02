import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'app_state.dart';
import 'models.dart';

class AudioController extends ChangeNotifier {
  AudioController(this.state) {
    _positionSub = player.positionStream.listen((p) { position = p; if (episode != null && p.inSeconds % 5 == 0) state.setProgress(episode!.id, p.inSeconds); notifyListeners(); });
    _durationSub = player.durationStream.listen((d) { duration = d ?? Duration.zero; notifyListeners(); });
    _playerSub = player.playerStateStream.listen((_) => notifyListeners());
  }
  final AppState state;
  final AudioPlayer player = AudioPlayer();
  Episode? episode;
  Duration position = Duration.zero, duration = Duration.zero;
  late final StreamSubscription _positionSub, _durationSub, _playerSub;
  bool get playing => player.playing;
  Future<void> play(Episode value, {int? atSeconds}) async {
    if (value.audioUrl.isEmpty) return;
    if (episode?.id != value.id) { episode = value; await player.setUrl(value.audioUrl); await player.seek(Duration(seconds: atSeconds ?? state.progress[value.id] ?? 0)); state.recordPlayed(value.id); }
    else if (atSeconds != null) { await player.seek(Duration(seconds: atSeconds)); }
    await player.play(); notifyListeners();
  }
  Future<void> toggle() => playing ? player.pause() : player.play();
  Future<void> seek(Duration value) => player.seek(value);
  @override void dispose() { _positionSub.cancel(); _durationSub.cancel(); _playerSub.cancel(); player.dispose(); super.dispose(); }
}
