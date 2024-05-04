import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primaryColor: Colors.pink[100],
        scaffoldBackgroundColor:
            Color(0xFFFCE4EC), // Milky Pink Background Color
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ExpenseTrackerHome(),
    );
  }
}

class ExpenseTrackerHome extends StatefulWidget {
  @override
  _ExpenseTrackerHomeState createState() => _ExpenseTrackerHomeState();
}

class _ExpenseTrackerHomeState extends State<ExpenseTrackerHome> {
  List<double> expenses = [];

  void _addExpense(double amount) {
    setState(() {
      expenses.add(amount);
    });
  }

  double _calculateTotalExpenses() {
    double total = 0;
    for (var expense in expenses) {
      total += expense;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Expenses',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                '\$${_calculateTotalExpenses().toStringAsFixed(2)}', // Placeholder for actual expenses amount
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Add Expense'),
                      content: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Enter amount'),
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            _addExpense(double.parse(value));
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    );
                  },
                );
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
