import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioController extends GetxController {
  static AudioController get instance => Get.find();

  late AudioPlayer _audioPlayer;
  RxBool isPlaying = false.obs;
  RxBool isMuted = false.obs;
  RxDouble volume = 0.5.obs;
  RxBool isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
    _initializeAudio();
  }

  void _initializeAudio() {
    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      isPlaying.value = state == PlayerState.playing;
      print("🎵 Player state changed: $state");
    });

    // Listen for errors
    _audioPlayer.onPlayerComplete.listen((event) {
      print("🎵 Audio completed, restarting...");
      if (isInitialized.value) {
        playBackgroundMusic();
      }
    });

    // Don't auto-start on web - wait for user interaction
    print("🎵 Audio controller initialized - ready for user interaction");
  }

  Future<void> initializeWithUserGesture() async {
    if (!isInitialized.value) {
      await playBackgroundMusic();
      isInitialized.value = true;
    }
  }

  Future<void> playBackgroundMusic() async {
    try {
      print("🎵 Starting Desert Winds Symphony...");

      // Stop any currently playing audio first
      await _audioPlayer.stop();

      // Play the actual dune.mp3 file from assets
      await _audioPlayer.play(AssetSource('audio/dune.mp3'));
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(volume.value);

      print("🎵 Background music started - The spice flows with sound...");
      print("🔊 Volume set to: ${(volume.value * 100).round()}%");
    } catch (e) {
      print("❌ Error playing background music: $e");
      isPlaying.value = false;
    }
  }

  Future<void> pauseMusic() async {
    try {
      await _audioPlayer.pause();
      print("⏸️ Music paused - Silence falls across Arrakis...");
    } catch (e) {
      print("❌ Error pausing music: $e");
    }
  }

  Future<void> resumeMusic() async {
    try {
      await _audioPlayer.resume();
      print("▶️ Music resumed - The desert winds sing again...");
    } catch (e) {
      print("❌ Error resuming music: $e");
    }
  }

  Future<void> stopMusic() async {
    try {
      await _audioPlayer.stop();
      print("⏹️ Music stopped - The silence of the deep desert...");
    } catch (e) {
      print("❌ Error stopping music: $e");
    }
  }

  void toggleMusic() {
    if (!isInitialized.value) {
      initializeWithUserGesture();
    } else if (isPlaying.value) {
      pauseMusic();
    } else {
      resumeMusic();
    }
  }

  void toggleMute() {
    if (isMuted.value) {
      _audioPlayer.setVolume(volume.value);
      isMuted.value = false;
      print("🔊 Sound restored - The voice of the desert returns...");
    } else {
      _audioPlayer.setVolume(0.0);
      isMuted.value = true;
      print("🔇 Sound muted - Stillness like a Fremen's patience...");
    }
  }

  void setVolume(double newVolume) {
    volume.value = newVolume;
    if (!isMuted.value) {
      _audioPlayer.setVolume(newVolume);
      print("🔊 Volume set to: ${(newVolume * 100).round()}%");
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
