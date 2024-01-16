import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fl_chart/fl_chart.dart';

final player=AudioPlayer()..setReleaseMode(ReleaseMode.loop);

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final tabs=[
    screen1(),
    screen3(),
    screen4(),
  ];

  int previousIndex=0;
  int currentIndex=0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('管好你得錢包'),
              backgroundColor: Colors.green,
              ),
            body: tabs[currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.green,
                selectedItemColor: Colors.red,
                selectedFontSize: 18,
                unselectedFontSize: 14,
                iconSize: 30,
                currentIndex: currentIndex,
                items: [
                  BottomNavigationBarItem(icon: Icon(Icons.ad_units), label:'記帳管理',),
                  BottomNavigationBarItem(icon: Icon(Icons.add), label:'發票登入',),
                  BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label:'預存金額',),
                ],
              onTap: (index) {
                setState(() {
                  previousIndex=currentIndex;
                  currentIndex=index;
                  if (index==0) {
                    if (previousIndex==currentIndex) player.resume();
                    player.stop();
                  }
                  if (index==1) {
                    if (previousIndex==currentIndex) player.resume();
                    player.stop();
                  }
                  if (index==2) {
                    if (previousIndex==currentIndex) player.resume();
                    player.stop();
                  }
                  if (index==3) {
                    if (previousIndex==currentIndex) player.resume();
                    player.stop();
                  }
                });
              },
    ),
    ),
    );
  }
}

class screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '記帳App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Expense> expenses = [];
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  void addExpense(double amount, String note) {
    setState(() {
      expenses.add(Expense(amount, note, DateTime.now()));
      amountController.clear();
      noteController.clear();
      saveExpenses();
    });
  }

  void editExpense(int index, double amount, String note) {
    setState(() {
      expenses[index] = Expense(amount, note, DateTime.now());
      saveExpenses();
      amountController.clear();
      noteController.clear(); // 清空輸入欄
    });
  }

  void deleteExpense(int index) {
    setState(() {
      expenses.removeAt(index);
      saveExpenses();
    });
  }

  double calculateTotalAmount() {
    double total = 0;
    for (var expense in expenses) {
      total += expense.amount;
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  void loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> expenseStrings = prefs.getStringList('expenses') ?? [];

    setState(() {
      expenses = expenseStrings.map((expenseString) {
        List<String> parts = expenseString.split('|');
        return Expense(double.parse(parts[0]), parts[1], DateTime.parse(parts[2]));
      }).toList();
    });
  }

  void saveExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> expenseStrings = expenses.map((expense) {
      return '${expense.amount}|${expense.note}|${expense.dateTime.toIso8601String()}';
    }).toList();
    prefs.setStringList('expenses', expenseStrings);
  }

  Future<void> editDialog(int index) async {
    amountController.text = expenses[index].amount.toString();
    noteController.text = expenses[index].note;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('修改紀錄'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: '輸入金額'),
              ),
              TextField(
                controller: noteController,
                decoration: InputDecoration(labelText: '備註'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () {
                double amount = double.parse(amountController.text);
                String note = noteController.text;
                editExpense(index, amount, note);
                Navigator.of(context).pop();
              },
              child: Text('確定'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20), // 與AppBar間隔20
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: InkWell(
              onTap: () {
                _showInputDialog(context);
              },
              child: Container(
                width: screenWidth - 40,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '記帳',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('金額: ${expenses[index].amount}'),
                  subtitle: Text('備註: ${expenses[index].note}\n日期時間: ${DateFormat('yyyy-MM-dd HH:mm').format(expenses[index].dateTime)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editDialog(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteExpense(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20), // 與底部的間隔
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              '總金額: ${calculateTotalAmount()}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInputDialog(BuildContext context) async {
    double amount = 0;
    String note = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('記帳'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: '輸入金額'),
                onChanged: (value) {
                  amount = double.parse(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '備註'),
                onChanged: (value) {
                  note = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () {
                addExpense(amount, note);
                Navigator.of(context).pop();
              },
              child: Text('確定'),
            ),
          ],
        );
      },
    );
  }
}

class Expense {
  final double amount;
  final String note;
  final DateTime dateTime;

  Expense(this.amount, this.note, this.dateTime);
}



class screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<screen3> {
  List<String> invoices = [];
  TextEditingController invoiceController = TextEditingController();
  TextEditingController winningNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('發票對獎'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '輸入發票號碼:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: invoiceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '請輸入8碼發票號碼',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                addInvoice();
              },
              child: Text('紀錄發票'),
            ),
            SizedBox(height: 32),
            Text(
              '輸入中獎號碼:',
              style: TextStyle(fontSize: 18),
            ),
            TextField(
              controller: winningNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '請輸入中獎號碼',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                checkWinning();
              },
              child: Text('對獎'),
            ),
            SizedBox(height: 32),
            Text(
              '發票紀錄:',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: invoices.map((invoice) {
                    return Text(invoice);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addInvoice() {
    String invoice = invoiceController.text;
    setState(() {
      invoices.add(invoice);
      invoiceController.clear();
    });
  }

  void checkWinning() {
    String winningNumber = winningNumberController.text;

    // 檢查每張發票是否中獎
    for (String invoice in invoices) {
      int matchingDigits = calculateMatchingDigits(invoice, winningNumber);
      if (matchingDigits >= 3) {
        // 中獎視窗
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('中獎啦！'),
              content: Text('恭喜你中了 $matchingDigits 碼！'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('確定'),
                ),
              ],
            );
          },
        );
        return; // 中獎就結束
      }
    }

    // 沒中獎視窗
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('沒中獎'),
          content: Text('下次一定會中！'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('確定'),
            ),
          ],
        );
      },
    );
  }

  // 計算兩個字串從尾部開始相同的碼數
  int calculateMatchingDigits(String str1, String str2) {
    int minLength = str1.length < str2.length ? str1.length : str2.length;
    int matchingDigits = 0;

    for (int i = 1; i <= minLength; i++) {
      if (str1.substring(str1.length - i) == str2.substring(str2.length - i)) {
        matchingDigits = i;
      } else {
        break;
      }
    }

    return matchingDigits;
  }
}

class screen4 extends StatefulWidget {
  @override
  _screen4State createState() => _screen4State();
}

class _screen4State extends State<screen4> {
  TextEditingController goalController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  double goalAmount = 0.0; // 你的目標金額
  double savedAmount = 0.0; // 已經存入的金額
  List<double> savedAmountList = []; // 存入的金額紀錄

  bool goalAchieved = false;

  @override
  void initState() {
    super.initState();
    loadGoalAmount();
    loadSavedAmountList();
  }

  void loadGoalAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double storedGoalAmount = prefs.getDouble('goalAmount') ?? 0.0;

    setState(() {
      goalAmount = storedGoalAmount;
    });
  }

  void saveGoalAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('goalAmount', goalAmount);
  }

  void addSavedAmount(double amount) {
    setState(() {
      savedAmount += amount;
      savedAmountList.add(amount); // 將存入的金額加到列表中
      checkGoalAchievement();
      saveSavedAmountList();
    });
  }

  void checkGoalAchievement() {
    if (savedAmount >= goalAmount && !goalAchieved) {
      setState(() {
        goalAchieved = true;
      });
      _showGoalAchievementDialog();
    } else if (goalAchieved) {
      // 如果已經達成目標，重置狀態以不再顯示「恭喜達成目標」
      setState(() {
        goalAchieved = false;
      });
    }
  }

  void _showGoalAchievementDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('目標達成'),
          content: Text('恭喜你達成了存錢目標！'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('確定'),
            ),
          ],
        );
      },
    );
  }

  void loadSavedAmountList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedSavedAmountList = prefs.getStringList('savedAmountList');

    if (storedSavedAmountList != null) {
      setState(() {
        savedAmountList = storedSavedAmountList.map((amount) => double.parse(amount)).toList();
        savedAmount = savedAmountList.fold(0, (prev, curr) => prev + curr);
      });
    }
  }

  void saveSavedAmountList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = savedAmountList.map((amount) => amount.toString()).toList();
    prefs.setStringList('savedAmountList', stringList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: goalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '目標金額'),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    double newGoalAmount = double.parse(goalController.text);
                    setState(() {
                      goalAmount = newGoalAmount;
                      saveGoalAmount();
                      savedAmountList = [];
                      savedAmount = 0.0;
                      saveSavedAmountList();
                    });
                    goalController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // 綠色按鈕
                  ),
                  child: Text('設定目標金額'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: '存入金額'),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    double newAmount = double.parse(amountController.text);
                    addSavedAmount(newAmount);
                    amountController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // 綠色按鈕
                  ),
                  child: Text('新增存入金額'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '目標金額: $goalAmount',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '存入金額紀錄: $savedAmount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: savedAmountList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('金額: ${savedAmountList[index]}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              '總存入金額: $savedAmount',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}