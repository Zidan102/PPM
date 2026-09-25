import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clicker Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 165, 255)),
      ),
      home: const MyHomePage(title: 'PPM Sesi 1 - Muhammad Zidan Alfikri (20240040257)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    } else {
      // Tampilkan pesan peringatan jika counter sudah 0
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nilai sudah 0, tidak bisa dikurangi lagi!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    bool isEven = _counter % 2 == 0;

    
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- KARTU IDENTITAS MAHASISWA ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Avatar / Inisial Profil
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Detail Identitas
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Muhammad Zidan Alfikri',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'NIM: 20240040257',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Prodi: Teknik Informatika',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Pengecekan variabel ganjil / genap
            // --- TEKS COUNTER & STATUS ---
            const Text('Kamu sudah klik tombol sebanyak:'),
            const SizedBox(height: 8),

            // Angka Counter dengan Warna Dinamis
            Text(
              '$_counter',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: isEven ? Colors.green : Colors.red, // Green jika Genap, Red jika Ganjil
              ),
            ),

            const SizedBox(height: 8),

            // Chip Status Ganjil / Genap
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isEven ? Colors.green.shade100 : Colors.red.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isEven ? 'Status: GENAP' : 'Status: GANJIL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isEven ? Colors.green.shade900 : Colors.red.shade900,
                ),
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Tombol Kurang (-)
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10), // Jarak antar tombol

          // Tombol Reset (0)
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 10), // Jarak antar tombol

          // Tombol Tambah (+)
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
