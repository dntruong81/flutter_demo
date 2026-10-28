import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveFlexScreen(),
    );
  }
}

class ResponsiveFlexScreen extends StatelessWidget {
  const ResponsiveFlexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tỷ lệ Flex 1:2 thực tế'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // ĐOẠN MÃ CỦA BẠN ĐƯỢC TÍCH HỢP MÀU NỀN ĐỂ DỄ QUAN SÁT KHÔNG GIAN
          child: Row(
            children: [
              // Cột 1: Chiếm 1 phần không gian (flex = 1)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                    color: Colors.amber.shade200,
                    alignment: Alignment.center,
                    child: Text(
                      'Rộng: ${constraints.maxWidth.toStringAsFixed(2)} px',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              // Cột 2: Chiếm 2 phần không gian (flex = 2)
              Expanded(
                flex: 2,
                child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                    color: Colors.blue.shade200,
                    alignment: Alignment.center,
                    child: Text(
                      'Rộng: ${constraints.maxWidth.toStringAsFixed(2)} px',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
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
