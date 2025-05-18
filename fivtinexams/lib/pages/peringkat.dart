import 'package:flutter/material.dart';

class PeringkatPage extends StatelessWidget {
  const PeringkatPage({super.key});

  // Contoh data peringkat
  final List<Map<String, dynamic>> _peringkatData = const [
    {"nama": "Rafi", "skor": 98},
    {"nama": "Aulia", "skor": 94},
    {"nama": "Dimas", "skor": 91},
    {"nama": "Zahra", "skor": 88},
    {"nama": "Putra", "skor": 85},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Peringkat Teratas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: _peringkatData.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = _peringkatData[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[300],
                    foregroundColor: Colors.white,
                    child: Text('${index + 1}'),
                  ),
                  title: Text(item['nama']),
                  trailing: Text(
                    '${item['skor']} poin',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}