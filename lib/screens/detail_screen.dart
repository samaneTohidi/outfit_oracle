import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neutral Tone Office Chic',
          style: TextStyle(fontSize: 14.0),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(
              'https://i.pinimg.com/236x/72/72/33/72723310acdd5c67ed9a071827446615.jpg',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          // Link and Buttons
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Link
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                        'Dive into a world where tradition meets modernity with our "Embrace the Bold" collection.'
                        'This series showcases the perfect harmony between classic elegance and avant-garde flair.'
                        'Featuring structured silhouettes, layered designs, and a blend of bold and muted tones, each piece encourages you to step out with confidence and sophistication.'
                        'From asymmetrical cuts to innovative fabrics, this collection is designed for those who are unafraid to make a statement.',
                    style: TextStyle(
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add your share functionality here
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add your save functionality here
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
