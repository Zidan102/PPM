import 'package:flutter/material.dart';

class VenueMapViewer extends StatelessWidget {
  const VenueMapViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Denah Venue (Gunakan dua jari untuk memperbesar/geser)",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(
                child: Container(
                  width: 600,
                  height: 600,
                  color: Colors.blue.shade50,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: 50,
                        child: _buildRoomBox("Auditorium Utama", Colors.orange),
                      ),
                      Positioned(
                        top: 250,
                        left: 200,
                        child: _buildRoomBox("Lab Komputer", Colors.green),
                      ),
                      Positioned(
                        top: 450,
                        left: 100,
                        child: _buildRoomBox("Ruang Seminar Lt. 2", Colors.purple),
                      ),
                      const Positioned(
                        bottom: 20,
                        right: 20,
                        child: Chip(label: Text("Pintu Utama / Lobby")),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomBox(String name, Color color) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}