import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Máy Tính Lãi Suất',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const InterestCalculatorPage(),
    );
  }
}

class InterestCalculatorPage extends StatefulWidget {
  const InterestCalculatorPage({super.key});

  @override
  State<InterestCalculatorPage> createState() => _InterestCalculatorPageState();
}

class _InterestCalculatorPageState extends State<InterestCalculatorPage> {
  // Các biến điều khiển nhập liệu
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  double _yearsToDouble = 0;

  void _calculateYears() {
    // Lấy giá trị từ ô nhập và chuyển sang số thực
    double? interestRate = double.tryParse(_interestController.text);

    if (interestRate != null && interestRate > 0) {
      setState(() {
        // Công thức tính số năm để tiền gấp đôi (Quy tắc 72)
        _yearsToDouble = 72 / interestRate;
      });
    } else {
      // Thông báo nếu nhập sai
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập lãi suất hợp lệ (> 0)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Máy Tính Lãi Suất Gấp Đôi'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nhập lãi suất hàng năm (%):",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _interestController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ví dụ: 7.5',
                suffixText: '%',
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: _calculateYears,
                icon: const Icon(Icons.calculate),
                label: const Text("TÍNH TOÁN"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 40),
            if (_yearsToDouble > 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Số năm để tiền tăng gấp đôi là:",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${_yearsToDouble.toStringAsFixed(1)} năm",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}