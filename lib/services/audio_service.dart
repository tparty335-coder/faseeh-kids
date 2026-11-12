import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:faseeh_kids/core/audio_clip_durations.dart';

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
  final Map<AudioChannel, Future<void>> _channelQueues = {};
  bool _isDisposed = false;
  int _voiceOpId = 0;
  int _sfxOpId = 0;
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

  /// Serialize native AudioPlayer calls per channel to prevent Android MediaPlayer state (-38) races.
  Future<void> _enqueue(AudioChannel channel, Future<void> Function() task) {
    final prev = _channelQueues[channel] ?? Future<void>.value();
    final next = prev.catchError((_) {}).then((_) => task());
    _channelQueues[channel] = next.catchError((_) {});
    return next;
  }

  Future<void> _playSource(
    AudioChannel channel,
    Source source, {
    required double volume,
    required String label,
  }) async {
    if (_isDisposed) return;
    final op = _nextOpId(channel);
    await _enqueue(channel, () async {
      if (!_isOpActive(channel, op)) return;
      try {
        final player = _players[channel];
        if (player == null) return;

        await _stopConflictingPlayers(channel);
        if (!_isOpActive(channel, op)) return;

        await player.setVolume(volume.clamp(0.0, 1.0));
        if (!_isOpActive(channel, op)) return;

        await player.setSource(source);
        if (!_isOpActive(channel, op)) return;

        await player.resume();
      } catch (e) {
        debugPrint('AudioService [$channel]: Error playing $label: $e');
      }
    });
  }

  int _nextOpId(AudioChannel channel) {
    switch (channel) {
      case AudioChannel.voice:
        return ++_voiceOpId;
      case AudioChannel.sfx:
        return ++_sfxOpId;
      case AudioChannel.bgm:
        return ++_bgmOpId;
    }
  }

  int _getOpId(AudioChannel channel) {
    switch (channel) {
      case AudioChannel.voice:
        return _voiceOpId;
      case AudioChannel.sfx:
        return _sfxOpId;
      case AudioChannel.bgm:
        return _bgmOpId;
    }
  }

  bool _isOpActive(AudioChannel channel, int op) {
    if (_isDisposed) return false;
    switch (channel) {
      case AudioChannel.voice:
        return op == _voiceOpId;
      case AudioChannel.sfx:
        return op == _sfxOpId;
      case AudioChannel.bgm:
        return op == _bgmOpId;
    }
  }

  Future<void> _stopConflictingPlayers(AudioChannel channel) async {
    // Only stop playback on the SAME channel.
    // A sound effect (sfx) must NEVER stop or cut off voice narration.
    await _players[channel]?.stop();
  }

  /// Play an audio asset from the assets folder on a specific channel
  /// [assetPath] should be relative to assets/ (e.g., 'audio/letters/alif_name.mp3')
  Future<void> playAsset(
    String assetPath, {
    AudioChannel channel = AudioChannel.voice,
    double volume = 1.0,
  }) {
    final cleanPath = assetPath.startsWith('assets/')
        ? assetPath.substring(7)
        : assetPath;
    return _playSource(
      channel,
      AssetSource(cleanPath),
      volume: volume,
      label: 'asset $assetPath',
    );
  }

  /// Returns the duration of an audio asset if known in catalog, or default fallback.
  Duration getAssetDuration(String assetPath) {
    final clean = assetPath.startsWith('assets/')
        ? assetPath.substring(7)
        : assetPath;
    final ms = kAudioClipDurationsMs[clean];
    if (ms != null) {
      return Duration(milliseconds: ms);
    }
    return const Duration(milliseconds: 2000);
  }

  /// Play an audio asset and wait until it finishes playing completely.
  /// Enforces generous time so audio files never clash or cut each other off.
  Future<void> playAssetAndWait(
    String assetPath, {
    AudioChannel channel = AudioChannel.voice,
    double volume = 1.0,
    Duration? explicitDuration,
    Duration pauseAfter = const Duration(milliseconds: 300),
  }) async {
    if (_isDisposed) return;
    await playAsset(assetPath, channel: channel, volume: volume);
    final op = _getOpId(channel);
    final dur = explicitDuration ?? getAssetDuration(assetPath);
    await Future.delayed(dur + pauseAfter);
    if (!_isOpActive(channel, op)) return;
  }

  /// Play an audio file from a full file path
  Future<void> playFile(
    String filePath, {
    AudioChannel channel = AudioChannel.voice,
    double volume = 1.0,
  }) =>
      _playSource(
        channel,
        DeviceFileSource(filePath),
        volume: volume,
        label: 'file $filePath',
      );

  /// Play from a URL
  Future<void> playUrl(
    String url, {
    AudioChannel channel = AudioChannel.voice,
    double volume = 1.0,
  }) =>
      _playSource(
        channel,
        UrlSource(url),
        volume: volume,
        label: 'URL $url',
      );

  /// Stop playback on a specific channel, or all channels if channel is null
  Future<void> stop({AudioChannel? channel}) async {
    if (_isDisposed) return;
    try {
      if (channel == null) {
        ++_voiceOpId;
        ++_sfxOpId;
        ++_bgmOpId;
        await Future.wait(
          AudioChannel.values.map((c) => _enqueue(c, () async {
                await _players[c]?.stop();
              })),
        );
      } else {
        switch (channel) {
          case AudioChannel.voice:
            ++_voiceOpId;
            break;
          case AudioChannel.sfx:
            ++_sfxOpId;
            break;
          case AudioChannel.bgm:
            ++_bgmOpId;
            break;
        }
        await _enqueue(channel, () async {
          await _players[channel]?.stop();
        });
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
    // نحوّل الـ stream إلى Stream<void> حقيقي: audioplayers يُصدر AudioEvent وقت
    // التشغيل، وهذا يكسر onTimeout: () {} (TypeError) عند انتهاء المهلة.
    return _players[channel]?.onPlayerComplete.map<void>((_) {});
  }

  /// Dispose all players
  void dispose() {
    _isDisposed = true;
    ++_voiceOpId;
    ++_sfxOpId;
    ++_bgmOpId;
    for (final player in _players.values) {
      player.dispose();
    }
    _players.clear();
  }
}
