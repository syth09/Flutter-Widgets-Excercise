import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Máy tính lãi suất',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const InterestCalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InterestCalculatorScreen extends StatefulWidget {
  const InterestCalculatorScreen({super.key});

  @override
  State<InterestCalculatorScreen> createState() =>
      _InterestCalculatorScreenState();
}

class _InterestCalculatorScreenState extends State<InterestCalculatorScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();

  String _result = '';

  void _calculate() {
    final String amountText = _amountController.text.trim();
    final String rateText = _rateController.text.trim();

    if (rateText.isEmpty) {
      setState(() {
        _result = 'Vui lòng nhập lãi suất hàng năm (%)';
      });
      return;
    }

    final double? rate = double.tryParse(rateText);
    if (rate == null || rate <= 0) {
      setState(() {
        _result = 'Lãi suất phải là số dương';
      });
      return;
    }

    // Rule of 72
    final double years = 72 / rate;

    setState(() {
      _result = 'Số năm để tiền tăng gấp đôi: ${years.toStringAsFixed(1)} năm';
      if (years < 1) {
        _result += '\n(Lãi suất quá cao, tiền sẽ tăng rất nhanh)';
      }
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Máy tính lãi suất'),
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Số tiền (không bắt buộc dùng trong tính toán này)
            const Text('Số tiền', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Nhập số tiền',
              ),
            ),
            const SizedBox(height: 20),

            // Lãi suất hàng năm
            const Text('Lãi suất hàng năm', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _rateController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hintText: 'Ví dụ: 8 (tức 8%)',
                suffixText: '%',
              ),
            ),
            const SizedBox(height: 30),

            // Nút Tính toán
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _calculate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Text('Tính toán', style: TextStyle(fontSize: 16)),
              ),
            ),

            const SizedBox(height: 40),

            // Kết quả
            if (_result.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _result,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
