import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Audio Channels for isolated playback pools
enum AudioChannel {
  voice, // Letter sounds, narration, TTS
  sfx,   // Effects, feedback, stars, confetti
  bgm,   // Background music
}

/// Audio Service — handles multi-channel audio playback
/// Enforces strict foreground serialization across voice + sfx so clips never overlap.
class AudioService {
  AudioService._() {
    _initPlayers();
  }

  static final AudioService _instance = AudioService._();
  static AudioService get instance => _instance;

  final Map<AudioChannel, AudioPlayer> _players = {};
  bool _isDisposed = false;
  int _fgOpId = 0;
  int _bgmOpId = 0;

  void _initPlayers() {
    for (final channel in AudioChannel.values) {
      final player = AudioPlayer();
      if (channel == AudioChannel.bgm) {
        player.setReleaseMode(ReleaseMode.loop);
      }
      _players[channel] = player;
    }
  }

  bool _isOpActive(AudioChannel channel, int op) {
    if (_isDisposed) return false;
    return channel == AudioChannel.bgm ? op == _bgmOpId : op == _fgOpId;
  }

  Future<void> _stopConflictingPlayers(AudioChannel channel) async {
    if (channel == AudioChannel.bgm) {
      await _players[AudioChannel.bgm]?.stop();
    } else {
      await Future.wait([
        if (_players[AudioChannel.voice] != null)
          _players[AudioChannel.voice]!.stop(),
        if (_players[AudioChannel.sfx] != null)
          _players[AudioChannel.sfx]!.stop(),
      ]);
    }
  }

  /// Play an audio asset from the assets folder on a specific channel
  /// [assetPath] should be relative to assets/ (e.g., 'audio/letters/alif_name.mp3')
  Future<void> playAsset(
    String assetPath, {
    AudioChannel channel = AudioChannel.voice,
    double volume = 1.0,
  }) async {
    if (_isDisposed) return;
    final op = channel == AudioChannel.bgm ? ++_bgmOpId : ++_fgOpId;
    try {
      final player = _players[channel];
      if (player == null) return;

      await _stopConflictingPlayers(channel);
      if (!_isOpActive(channel, op)) return;

      await player.setVolume(volume.clamp(0.0, 1.0));
      if (!_isOpActive(channel, op)) return;

      await player.setSource(AssetSource(assetPath));
      if (!_isOpActive(channel, op)) return;

      await player.resume();
    } catch (e) {
      debugPrint('AudioService [$channel]: Error playing asset $assetPath: $e');
    }
  }

  /// Play an audio file from a full file path
  Future<void> playFile(
    String filePath, {
    AudioChannel channel = AudioChannel.voice,
    double volume = 1.0,
  }) async {
    if (_isDisposed) return;
    final op = channel == AudioChannel.bgm ? ++_bgmOpId : ++_fgOpId;
    try {
      final player = _players[channel];
      if (player == null) return;

      await _stopConflictingPlayers(channel);
      if (!_isOpActive(channel, op)) return;

      await player.setVolume(volume.clamp(0.0, 1.0));
      if (!_isOpActive(channel, op)) return;

      await player.setSource(DeviceFileSource(filePath));
      if (!_isOpActive(channel, op)) return;

      await player.resume();
    } catch (e) {
      debugPrint('AudioService [$channel]: Error playing file $filePath: $e');
    }
  }

  /// Play from a URL
  Future<void> playUrl(
    String url, {
    AudioChannel channel = AudioChannel.voice,
    double volume = 1.0,
  }) async {
    if (_isDisposed) return;
    final op = channel == AudioChannel.bgm ? ++_bgmOpId : ++_fgOpId;
    try {
      final player = _players[channel];
      if (player == null) return;

      await _stopConflictingPlayers(channel);
      if (!_isOpActive(channel, op)) return;

      await player.setVolume(volume.clamp(0.0, 1.0));
      if (!_isOpActive(channel, op)) return;

      await player.setSource(UrlSource(url));
      if (!_isOpActive(channel, op)) return;

      await player.resume();
    } catch (e) {
      debugPrint('AudioService [$channel]: Error playing URL $url: $e');
    }
  }

  /// Stop playback on a specific channel, or all channels if channel is null
  Future<void> stop({AudioChannel? channel}) async {
    if (_isDisposed) return;
    try {
      if (channel == null) {
        ++_fgOpId;
        ++_bgmOpId;
        await Future.wait(_players.values.map((p) => p.stop()));
      } else if (channel == AudioChannel.bgm) {
        ++_bgmOpId;
        await _players[channel]?.stop();
      } else {
        ++_fgOpId;
        await _players[channel]?.stop();
      }
    } catch (e) {
      debugPrint('AudioService: Error stopping: $e');
    }
  }

  /// Set playback volume for a channel (or all channels)
  Future<void> setVolume(double volume, {AudioChannel? channel}) async {
    if (_isDisposed) return;
    final clamped = volume.clamp(0.0, 1.0);
    if (channel != null) {
      await _players[channel]?.setVolume(clamped);
    } else {
      for (final p in _players.values) {
        await p.setVolume(clamped);
      }
    }
  }

  /// Set playback speed/rate for a channel
  Future<void> setPlaybackRate(double rate, {AudioChannel channel = AudioChannel.voice}) async {
    if (_isDisposed) return;
    await _players[channel]?.setPlaybackRate(rate);
  }

  /// Get current player state for a channel
  PlayerState getChannelState(AudioChannel channel) {
    return _players[channel]?.state ?? PlayerState.stopped;
  }

  /// Stream of player state changes for a channel
  Stream<PlayerState>? onPlayerStateChanged(AudioChannel channel) {
    return _players[channel]?.onPlayerStateChanged;
  }

  /// Stream that fires when playback completes for a channel
  Stream<void>? onPlayerComplete(AudioChannel channel) {
    return _players[channel]?.onPlayerComplete;
  }

  /// Dispose all players
  void dispose() {
    _isDisposed = true;
    ++_fgOpId;
    ++_bgmOpId;
    for (final player in _players.values) {
      player.dispose();
    }
    _players.clear();
  }
}
