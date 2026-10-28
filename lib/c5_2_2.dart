import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Padding Demo'),
          backgroundColor: Colors.blueGrey,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: MyPaddingDemo(),
        ),
      ),
    );
  }
}

class MyPaddingDemo extends StatelessWidget {
  const MyPaddingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Khai báo các widget bar1, bar2, bar3 để code có thể chạy được ổn định
    final Widget bar1 = Container(
      height: 40,
      color: Colors.red,
      child: const Center(child: Text('bar1', style: TextStyle(color: Colors.white))),
    );

    final Widget bar2 = Container(
      height: 40,
      color: Colors.green,
      child: const Center(child: Text('bar2', style: TextStyle(color: Colors.white))),
    );

    final Widget bar3 = Container(
      height: 40,
      color: Colors.blue,
      child: const Center(child: Text('bar3', style: TextStyle(color: Colors.white))),
    );

    // Đoạn code gốc từ hình ảnh của bạn
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Padding Demo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Padding(padding: const EdgeInsets.all(10), child: bar1),
        Padding(padding: const EdgeInsets.fromLTRB(0, 1, 40, 0), child: bar2),
        Padding(padding: const EdgeInsets.only(left: 50, top: 100), child: bar3),
      ],
    );
  }
}
