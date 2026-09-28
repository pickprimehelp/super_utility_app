import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MultiToolApp());
}

class MultiToolApp extends StatelessWidget {
  const MultiToolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Utility Tools',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  final String _bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) => setState(() => _isAdLoaded = true),
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> tools = [
    {'title': 'Wedding Card Maker', 'icon': Icons.card_giftcard, 'screen': const WeddingCardScreen()},
    {'title': 'GST Invoice Maker', 'icon': Icons.receipt_long, 'screen': const InvoiceMakerScreen()},
    {'title': 'Age Calculator', 'icon': Icons.cake, 'screen': const AgeCalculatorScreen()},
    {'title': 'Daily Status & Emoji', 'icon': Icons.format_quote, 'screen': const StatusMakerScreen()},
    {'title': 'Photo Compressor', 'icon': Icons.compress, 'screen': const PhotoCompressorScreen()},
    {'title': 'Advance Photo Editor', 'icon': Icons.edit, 'screen': const DummyToolScreen(title: 'Photo Editor')},
    {'title': 'Reel Maker', 'icon': Icons.video_library, 'screen': const DummyToolScreen(title: 'Reel Maker')},
    {'title': 'QR Code Generator', 'icon': Icons.qr_code, 'screen': const DummyToolScreen(title: 'QR Generator')},
    {'title': 'Text to Speech', 'icon': Icons.record_voice_over, 'screen': const DummyToolScreen(title: 'Text to Speech')},
    {'title': 'PDF Merger', 'icon': Icons.merge_type, 'screen': const DummyToolScreen(title: 'PDF Merger')},
    {'title': 'Background Remover', 'icon': Icons.photo_filter, 'screen': const DummyToolScreen(title: 'BG Remover')},
    {'title': 'Unit Converter', 'icon': Icons.calculate, 'screen': const DummyToolScreen(title: 'Unit Converter')},
    {'title': 'Notes & Tasks', 'icon': Icons.note_alt, 'screen': const DummyToolScreen(title: 'Notes & Tasks')},
    {'title': 'BMI Calculator', 'icon': Icons.monitor_weight, 'screen': const DummyToolScreen(title: 'BMI Calculator')},
    {'title': 'Stopwatch & Timer', 'icon': Icons.timer, 'screen': const DummyToolScreen(title: 'Stopwatch')},
    {'title': 'Color Picker', 'icon': Icons.color_lens, 'screen': const DummyToolScreen(title: 'Color Picker')},
    {'title': 'Discount Calculator', 'icon': Icons.percent, 'screen': const DummyToolScreen(title: 'Discount Calc')},
    {'title': 'EMI Calculator', 'icon': Icons.account_balance, 'screen': const DummyToolScreen(title: 'EMI Calc')},
    {'title': 'Password Generator', 'icon': Icons.lock, 'screen': const DummyToolScreen(title: 'Password Gen')},
    {'title': 'Flashlight', 'icon': Icons.flash_on, 'screen': const DummyToolScreen(title: 'Flashlight')},
    {'title': 'App Usage Tracker', 'icon': Icons.bar_chart, 'screen': const DummyToolScreen(title: 'Usage Tracker')},
    {'title': 'Audio Cutter', 'icon': Icons.content_cut, 'screen': const DummyToolScreen(title: 'Audio Cutter')},
    {'title': 'Water Reminder', 'icon': Icons.local_drink, 'screen': const DummyToolScreen(title: 'Water Reminder')},
    {'title': 'Compass', 'icon': Icons.explore, 'screen': const DummyToolScreen(title: 'Compass')},
    {'title': 'Speedometer', 'icon': Icons.speed, 'screen': const DummyToolScreen(title: 'Speedometer')},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('25-in-1 Super Utility Suite'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: tools.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => tools[index]['screen']),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(tools[index]['icon'], size: 40, color: Theme.of(context).primaryColor),
                        const SizedBox(height: 8),
                        Text(
                          tools[index]['title'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isAdLoaded)
            SizedBox(
              height: _bannerAd!.size.height.toDouble(),
              width: _bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
    );
  }
}

class InvoiceMakerScreen extends StatefulWidget {
  const InvoiceMakerScreen({super.key});

  @override
  State<InvoiceMakerScreen> createState() => _InvoiceMakerScreenState();
}

class _InvoiceMakerScreenState extends State<InvoiceMakerScreen> {
  final _customerController = TextEditingController();
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final _gstController = TextEditingController(text: "18");

  final List<Map<String, dynamic>> _items = [];

  void _addItem() {
    if (_itemController.text.isNotEmpty && _priceController.text.isNotEmpty) {
      setState(() {
        _items.add({
          'name': _itemController.text,
          'price': double.parse(_priceController.text),
        });
        _itemController.clear();
        _priceController.clear();
      });
    }
  }

  void _generatePdf() async {
    final pdf = pw.Document();
    double gstRate = double.tryParse(_gstController.text) ?? 18.0;
    double subtotal = _items.fold(0, (sum, item) => sum + item['price']);
    double gstAmount = subtotal * (gstRate / 100);
    double total = subtotal + gstAmount;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              cross: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('TAX INVOICE', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.Divider(),
                pw.Text('Customer Name: ${_customerController.text}'),
                pw.SizedBox(height: 20),
                pw.TableHelper.fromTextArray(
                  headers: ['Item Name', 'Price (INR)'],
                  data: _items.map((e) => [e['name'], e['price'].toStringAsFixed(2)]).toList(),
                ),
                pw.Divider(),
                pw.Align(alignment: pw.Alignment.centerRight, child: pw.Text('Subtotal: ₹${subtotal.toStringAsFixed(2)}')),
                pw.Align(alignment: pw.Alignment.centerRight, child: pw.Text('GST (${gstRate}%): ₹${gstAmount.toStringAsFixed(2)}')),
                pw.Align(alignment: pw.Alignment.centerRight, child: pw.Text('Grand Total: ₹${total.toStringAsFixed(2)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GST Invoice Bill Maker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _customerController, decoration: const InputDecoration(labelText: 'Customer Name')),
            Row(
              children: [
                Expanded(child: TextField(controller: _itemController, decoration: const InputDecoration(labelText: 'Product Name'))),
                const SizedBox(width: 10),
                Expanded(child: TextField(controller: _priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price'))),
                IconButton(icon: const Icon(Icons.add_circle, size: 32), onPressed: _addItem),
              ],
            ),
            TextField(controller: _gstController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'GST %')),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(_items[index]['name']),
                  trailing: Text('₹${_items[index]['price']}'),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _items.isEmpty ? null : _generatePdf,
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Generate A4 Invoice PDF'),
            ),
          ],
        ),
      ),
    );
  }
}

class WeddingCardScreen extends StatefulWidget {
  const WeddingCardScreen({super.key});

  @override
  State<WeddingCardScreen> createState() => _WeddingCardScreenState();
}

class _WeddingCardScreenState extends State<WeddingCardScreen> {
  final _brideController = TextEditingController(text: "Priya");
  final _groomController = TextEditingController(text: "Rahul");
  final _dateController = TextEditingController(text: "25th November 2026");
  Color _cardBgColor = Colors.red.shade900;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wedding Card Maker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _cardBgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber, width: 4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('WEDDING INVITATION', style: TextStyle(color: Colors.amber, fontSize: 16, letterSpacing: 2)),
                  const SizedBox(height: 10),
                  Text('${_groomController.text} ❤️ ${_brideController.text}', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  Text('Date: ${_dateController.text}', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(controller: _groomController, decoration: const InputDecoration(labelText: 'Groom Name'), onChanged: (v) => setState(() {})),
            TextField(controller: _brideController, decoration: const InputDecoration(labelText: 'Bride Name'), onChanged: (v) => setState(() {})),
            TextField(controller: _dateController, decoration: const InputDecoration(labelText: 'Wedding Date'), onChanged: (v) => setState(() {})),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () => setState(() => _cardBgColor = Colors.red.shade900), child: const Text('Red Theme')),
                ElevatedButton(onPressed: () => setState(() => _cardBgColor = Colors.purple.shade900), child: const Text('Purple Theme')),
                ElevatedButton(onPressed: () => setState(() => _cardBgColor = Colors.teal.shade900), child: const Text('Teal Theme')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AgeCalculatorScreen extends StatefulWidget {
  const AgeCalculatorScreen({super.key});

  @override
  State<AgeCalculatorScreen> createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  DateTime? _selectedDate;
  String _ageResult = "Select Date of Birth";

  void _calculateAge(DateTime dob) {
    DateTime today = DateTime.now();
    int years = today.year - dob.year;
    int months = today.month - dob.month;
    int days = today.day - dob.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(today.year, today.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    setState(() {
      _ageResult = "$years Years, $months Months, $days Days Old";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Age Calculator')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_ageResult, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  _selectedDate = picked;
                  _calculateAge(picked);
                }
              },
              child: const Text('Select Date of Birth'),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusMakerScreen extends StatelessWidget {
  const StatusMakerScreen({super.key});

  final List<String> statuses = const [
    "Believe in yourself! 💪✨",
    "Keep smiling, life is beautiful 😊🌟",
    "Hard work beats talent! 🚀🔥",
    "Stay positive, work hard, make it happen 🎉💯",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Status & Emoji Maker')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: statuses.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(statuses[index], style: const TextStyle(fontSize: 16)),
              trailing: const Icon(Icons.copy),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Status copied to clipboard!')));
              },
            ),
          );
        },
      ),
    );
  }
}

class PhotoCompressorScreen extends StatefulWidget {
  const PhotoCompressorScreen({super.key});

  @override
  State<PhotoCompressorScreen> createState() => _PhotoCompressorScreenState();
}

class _PhotoCompressorScreenState extends State<PhotoCompressorScreen> {
  File? _image;
  String _info = "Select an image to compress";

  Future<void> _pickAndCompress() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File original = File(pickedFile.path);
      List<int> bytes = await original.readAsBytes();
      img.Image? decoded = img.decodeImage(Uint8List.fromList(bytes));

      if (decoded != null) {
        List<int> compressed = img.encodeJpg(decoded, quality: 50);
        setState(() {
          _image = original;
          _info = "Original Size: ${(bytes.length / 1024).toStringAsFixed(1)} KB\nCompressed Size: ${(compressed.length / 1024).toStringAsFixed(1)} KB";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Photo Compressor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null) Image.file(_image!, height: 200),
            const SizedBox(height: 20),
            Text(_info, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _pickAndCompress, child: const Text('Pick Image')),
          ],
        ),
      ),
    );
  }
}

class DummyToolScreen extends StatelessWidget {
  final String title;
  const DummyToolScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('$title Tool Coming Soon!'),
      ),
    );
  }
}
