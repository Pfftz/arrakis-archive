import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/audio_controller.dart';

class MusicControlWidget extends StatelessWidget {
  const MusicControlWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = AudioController.instance;

    return Positioned(
      top: 100,
      right: 16,
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF3d2d1c).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFb29254).withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFe79b07).withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Music Control Button
              IconButton(
                onPressed: () => audioController.toggleMusic(),
                icon: Icon(
                  audioController.isPlaying.value
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  color: const Color(0xFFe79b07),
                  size: 28,
                ),
                tooltip: audioController.isPlaying.value
                    ? 'Pause Desert Winds'
                    : 'Play Desert Winds',
              ),

              // Mute/Unmute Button
              IconButton(
                onPressed: () => audioController.toggleMute(),
                icon: Icon(
                  audioController.isMuted.value
                      ? Icons.volume_off
                      : Icons.volume_up,
                  color: audioController.isMuted.value
                      ? const Color(0xFFb29254)
                      : const Color(0xFFe79b07),
                  size: 24,
                ),
                tooltip: audioController.isMuted.value
                    ? 'Unmute Sounds'
                    : 'Mute Sounds',
              ),

              // Volume Slider (rotated to be vertical)
              if (!audioController.isMuted.value)
                SizedBox(
                  height: 80,
                  width: 20,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: audioController.volume.value,
                      onChanged: (value) => audioController.setVolume(value),
                      activeColor: const Color(0xFFe79b07),
                      inactiveColor: const Color(
                        0xFFb29254,
                      ).withValues(alpha: 0.3),
                      thumbColor: const Color(0xFFf8c457),
                      min: 0.0,
                      max: 1.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandedMusicControl extends StatelessWidget {
  const ExpandedMusicControl({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = AudioController.instance;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3d2d1c),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFb29254).withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.music_note,
                  color: const Color(0xFFe79b07),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Desert Winds Symphony',
                  style: const TextStyle(
                    color: Color(0xFFe79b07),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'DidoLT',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Status Text
            Text(
              audioController.isPlaying.value
                  ? '"The sound of the desert carries the wisdom of ages..."'
                  : '"In silence, the spice reveals its secrets..."',
              style: const TextStyle(
                color: Color(0xFFb29254),
                fontStyle: FontStyle.italic,
                fontSize: 14,
                fontFamily: 'Futura',
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Control Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Stop Button
                _ControlButton(
                  icon: Icons.stop_circle_outlined,
                  label: 'Stop',
                  onPressed: () => audioController.stopMusic(),
                  color: const Color(0xFFb29254),
                ),

                // Play/Pause Button
                _ControlButton(
                  icon: audioController.isPlaying.value
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  label: audioController.isPlaying.value ? 'Pause' : 'Play',
                  onPressed: () => audioController.toggleMusic(),
                  color: const Color(0xFFe79b07),
                  isMain: true,
                ),

                // Mute Button
                _ControlButton(
                  icon: audioController.isMuted.value
                      ? Icons.volume_off
                      : Icons.volume_up,
                  label: audioController.isMuted.value ? 'Unmute' : 'Mute',
                  onPressed: () => audioController.toggleMute(),
                  color: audioController.isMuted.value
                      ? const Color(0xFFb29254)
                      : const Color(0xFFe79b07),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Volume Control
            if (!audioController.isMuted.value) ...[
              Row(
                children: [
                  Icon(
                    Icons.volume_down,
                    color: const Color(0xFFb29254),
                    size: 20,
                  ),
                  Expanded(
                    child: Slider(
                      value: audioController.volume.value,
                      onChanged: (value) => audioController.setVolume(value),
                      activeColor: const Color(0xFFe79b07),
                      inactiveColor: const Color(
                        0xFFb29254,
                      ).withValues(alpha: 0.3),
                      thumbColor: const Color(0xFFf8c457),
                      min: 0.0,
                      max: 1.0,
                    ),
                  ),
                  Icon(
                    Icons.volume_up,
                    color: const Color(0xFFb29254),
                    size: 20,
                  ),
                ],
              ),

              Text(
                'Volume: ${(audioController.volume.value * 100).round()}%',
                style: const TextStyle(color: Color(0xFFb29254), fontSize: 12),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final bool isMain;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
    this.isMain = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Icon(icon, color: color, size: isMain ? 32 : 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
