import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Audio Channels for isolated playback pools
enum AudioChannel {
  voice, // Letter sounds, narration, TTS
  sfx,   // Effects, feedback, stars, confetti
  bgm,   // Background music
}

/// Audio Service — handles multi-channel audio playback
/// Uses audioplayers package with isolated AudioPlayer instances per channel
class AudioService {
  AudioService._() {
    _initPlayers();
  }

  static final AudioService _instance = AudioService._();
  static AudioService get instance => _instance;

  final Map<AudioChannel, AudioPlayer> _players = {};
  bool _isDisposed = false;

  void _initPlayers() {
    for (final channel in AudioChannel.values) {
      final player = AudioPlayer();
      // Configure audio context per channel if needed
      if (channel == AudioChannel.bgm) {
        player.setReleaseMode(ReleaseMode.loop);
      }
      _players[channel] = player;
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
    try {
      final player = _players[channel];
      if (player == null) return;

      await player.stop();
      await player.setVolume(volume.clamp(0.0, 1.0));
      await player.setSource(AssetSource(assetPath));
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
    try {
      final player = _players[channel];
      if (player == null) return;

      await player.stop();
      await player.setVolume(volume.clamp(0.0, 1.0));
      await player.setSource(DeviceFileSource(filePath));
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
    try {
      final player = _players[channel];
      if (player == null) return;

      await player.stop();
      await player.setVolume(volume.clamp(0.0, 1.0));
      await player.setSource(UrlSource(url));
      await player.resume();
    } catch (e) {
      debugPrint('AudioService [$channel]: Error playing URL $url: $e');
    }
  }

  /// Stop playback on a specific channel, or all channels if channel is null
  Future<void> stop({AudioChannel? channel}) async {
    if (_isDisposed) return;
    try {
      if (channel != null) {
        await _players[channel]?.stop();
      } else {
        for (final p in _players.values) {
          await p.stop();
        }
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
    for (final player in _players.values) {
      player.dispose();
    }
    _players.clear();
  }
}

