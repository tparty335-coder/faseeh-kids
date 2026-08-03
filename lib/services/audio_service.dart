import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// Audio Service — handles playback of audio assets and files
/// Uses audioplayers package for cross-platform audio
class AudioService {
  AudioService._();

  static final AudioService _instance = AudioService._();
  static AudioService get instance => _instance;

  final AudioPlayer _player = AudioPlayer();
  bool _isDisposed = false;

  /// Play an audio asset from the assets folder
  /// [assetPath] should be relative to assets/ (e.g., 'audio/letters/alif_name.mp3')
  Future<void> playAsset(String assetPath) async {
    if (_isDisposed) return;
    try {
      await _player.stop();
      await _player.setSource(AssetSource(assetPath));
      await _player.resume();
    } catch (e) {
      debugPrint('AudioService: Error playing asset $assetPath: $e');
    }
  }

  /// Play an audio file from a full file path
  Future<void> playFile(String filePath) async {
    if (_isDisposed) return;
    try {
      await _player.stop();
      await _player.setSource(DeviceFileSource(filePath));
      await _player.resume();
    } catch (e) {
      debugPrint('AudioService: Error playing file $filePath: $e');
    }
  }

  /// Play from a URL
  Future<void> playUrl(String url) async {
    if (_isDisposed) return;
    try {
      await _player.stop();
      await _player.setSource(UrlSource(url));
      await _player.resume();
    } catch (e) {
      debugPrint('AudioService: Error playing URL $url: $e');
    }
  }

  /// Stop current playback
  Future<void> stop() async {
    if (_isDisposed) return;
    try {
      await _player.stop();
    } catch (e) {
      debugPrint('AudioService: Error stopping: $e');
    }
  }

  /// Set playback volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    if (_isDisposed) return;
    await _player.setVolume(volume.clamp(0.0, 1.0));
  }

  /// Set playback speed/rate
  Future<void> setPlaybackRate(double rate) async {
    if (_isDisposed) return;
    await _player.setPlaybackRate(rate);
  }

  /// Get current player state
  PlayerState get state => _player.state;

  /// Stream of player state changes
  Stream<PlayerState> get onPlayerStateChanged => _player.onPlayerStateChanged;

  /// Stream that fires when playback completes
  Stream<void> get onPlayerComplete => _player.onPlayerComplete;

  /// Dispose the player
  void dispose() {
    _isDisposed = true;
    _player.dispose();
  }
}
