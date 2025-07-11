import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/audio_controller.dart';

class MusicControlWidget extends StatefulWidget {
  const MusicControlWidget({super.key});

  @override
  State<MusicControlWidget> createState() => _MusicControlWidgetState();
}

class _MusicControlWidgetState extends State<MusicControlWidget> {
  // Position for draggable widget
  Offset position = const Offset(
    320,
    500,
  ); // Default position (bottom right area)

  @override
  Widget build(BuildContext context) {
    final audioController = AudioController.instance;
    final screenSize = MediaQuery.of(context).size;

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: _buildMusicButton(audioController, isDragging: true),
        childWhenDragging: Container(), // Hide original while dragging
        onDragEnd: (details) {
          setState(() {
            // Ensure the button stays within screen bounds
            double newX = details.offset.dx;
            double newY = details.offset.dy;

            // Keep within screen bounds (with some padding)
            newX = newX.clamp(16.0, screenSize.width - 72.0);
            newY = newY.clamp(50.0, screenSize.height - 120.0);

            position = Offset(newX, newY);
          });
        },
        child: _buildMusicButton(audioController),
      ),
    );
  }

  Widget _buildMusicButton(
    AudioController audioController, {
    bool isDragging = false,
  }) {
    return Obx(
      () => Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(
            0xFF3d2d1c,
          ).withValues(alpha: isDragging ? 0.8 : 0.95),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFb29254).withValues(alpha: 0.6),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFFe79b07,
              ).withValues(alpha: isDragging ? 0.6 : 0.4),
              blurRadius: isDragging ? 12 : 8,
              spreadRadius: isDragging ? 2 : 1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: () => audioController.toggleMusic(),
            onLongPress: () => _showMusicMenu(audioController),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFe79b07).withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  audioController.isPlaying.value
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  color: const Color(0xFFe79b07),
                  size: 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMusicMenu(AudioController audioController) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF3d2d1c),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle indicator
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFb29254),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              'Desert Winds Symphony',
              style: TextStyle(
                color: Color(0xFFe79b07),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Dune',
              ),
            ),
            const SizedBox(height: 20),

            // Controls
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _MenuButton(
                    icon: Icons.stop_rounded,
                    label: 'Stop',
                    onTap: () {
                      audioController.stopMusic();
                      Navigator.pop(context);
                    },
                  ),
                  _MenuButton(
                    icon: audioController.isPlaying.value
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    label: audioController.isPlaying.value ? 'Pause' : 'Play',
                    onTap: () {
                      audioController.toggleMusic();
                      Navigator.pop(context);
                    },
                    isMain: true,
                  ),
                  _MenuButton(
                    icon: audioController.isMuted.value
                        ? Icons.volume_off_rounded
                        : Icons.volume_up_rounded,
                    label: audioController.isMuted.value ? 'Unmute' : 'Mute',
                    onTap: () {
                      audioController.toggleMute();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Volume control
            Obx(
              () => Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.volume_down_rounded,
                        color: Color(0xFFb29254),
                        size: 20,
                      ),
                      Expanded(
                        child: Slider(
                          value: audioController.volume.value,
                          onChanged: (value) =>
                              audioController.setVolume(value),
                          activeColor: const Color(0xFFe79b07),
                          inactiveColor: const Color(
                            0xFFb29254,
                          ).withValues(alpha: 0.3),
                          thumbColor: const Color(0xFFf8c457),
                        ),
                      ),
                      const Icon(
                        Icons.volume_up_rounded,
                        color: Color(0xFFb29254),
                        size: 20,
                      ),
                    ],
                  ),
                  Text(
                    'Volume: ${(audioController.volume.value * 100).round()}%',
                    style: const TextStyle(
                      color: Color(0xFFb29254),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isMain;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isMain = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Container(
              width: isMain ? 50 : 40,
              height: isMain ? 50 : 40,
              decoration: BoxDecoration(
                color: isMain
                    ? const Color(0xFFe79b07).withValues(alpha: 0.2)
                    : const Color(0xFFb29254).withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isMain
                      ? const Color(0xFFe79b07)
                      : const Color(0xFFb29254),
                  width: 1,
                ),
              ),
              child: Icon(
                icon,
                color: isMain
                    ? const Color(0xFFe79b07)
                    : const Color(0xFFb29254),
                size: isMain ? 24 : 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isMain
                    ? const Color(0xFFe79b07)
                    : const Color(0xFFb29254),
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
