import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MODEL RESEP
class Resep {
  final int id;
  final String nama;
  final String deskripsi;
  final String kategori;
  final String emoji;
  final int durasi;
  final int porsi;
  final double rating;
  final String tingkat;
  final List<String> bahan;
  final List<String> langkah;

  const Resep({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.kategori,
    required this.emoji,
    required this.durasi,
    required this.porsi,
    required this.rating,
    required this.tingkat,
    required this.bahan,
    required this.langkah,
  });
}

// DATA RESEP
final List<Resep> dataResep = [
  Resep(
    id: 1,
    nama: 'Nasi Goreng',
    deskripsi: 'Nasi goreng sederhana yang gurih dan lezat.',
    kategori: 'Makanan Utama',
    emoji: '🍳',
    durasi: 20,
    porsi: 2,
    rating: 4.9,
    tingkat: 'Mudah',
    bahan: [
      '2 piring nasi putih',
      '2 butir telur',
      '2 siung bawang putih',
      '2 sdm kecap manis',
      'Garam dan minyak secukupnya',
    ],
    langkah: [
      'Cincang bawang putih.',
      'Panaskan minyak dan tumis bawang.',
      'Masukkan telur lalu orak-arik.',
      'Masukkan nasi, kecap, dan garam.',
      'Aduk rata lalu sajikan.',
    ],
  ),
  Resep(
    id: 2,
    nama: 'Ayam Teriyaki',
    deskripsi: 'Ayam teriyaki dengan saus manis gurih.',
    kategori: 'Makanan Utama',
    emoji: '🍗',
    durasi: 30,
    porsi: 2,
    rating: 4.8,
    tingkat: 'Sedang',
    bahan: [
      '250 gram ayam',
      '2 sdm saus teriyaki',
      '1 siung bawang putih',
      '1 sdm kecap manis',
      'Minyak secukupnya',
    ],
    langkah: [
      'Potong ayam menjadi bagian kecil.',
      'Tumis bawang putih hingga harum.',
      'Masukkan ayam dan masak hingga berubah warna.',
      'Tambahkan saus teriyaki dan kecap.',
      'Masak hingga matang lalu sajikan.',
    ],
  ),
  Resep(
    id: 3,
    nama: 'Pancake Pisang',
    deskripsi: 'Pancake lembut dengan rasa pisang.',
    kategori: 'Sarapan',
    emoji: '🥞',
    durasi: 15,
    porsi: 2,
    rating: 4.7,
    tingkat: 'Mudah',
    bahan: [
      '2 buah pisang',
      '1 butir telur',
      '5 sdm tepung terigu',
      '100 ml susu',
      'Margarin secukupnya',
    ],
    langkah: [
      'Haluskan pisang.',
      'Campurkan pisang, telur, tepung, dan susu.',
      'Aduk hingga adonan rata.',
      'Panaskan margarin di teflon.',
      'Masak adonan hingga matang.',
    ],
  ),
  Resep(
    id: 4,
    nama: 'Pisang Cokelat',
    deskripsi: 'Camilan pisang dengan cokelat lumer.',
    kategori: 'Camilan',
    emoji: '🍫',
    durasi: 20,
    porsi: 2,
    rating: 4.9,
    tingkat: 'Mudah',
    bahan: [
      '2 buah pisang',
      'Kulit lumpia',
      'Cokelat meses',
      '1 sdm tepung dan air',
      'Minyak untuk menggoreng',
    ],
    langkah: [
      'Potong pisang sesuai selera.',
      'Letakkan pisang dan cokelat di kulit lumpia.',
      'Lipat dan rekatkan dengan campuran tepung.',
      'Panaskan minyak.',
      'Goreng hingga keemasan.',
    ],
  ),
];

// APLIKASI UTAMA
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RaeCook',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF8FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF5C93),
          primary: const Color(0xFFFF5C93),
          secondary: const Color(0xFF78C99A),
          tertiary: const Color(0xFF78BDF5),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF8FA),
          foregroundColor: Color(0xFF343047),
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: const HalamanUtama(),
    );
  }
}

// HALAMAN UTAMA
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  final TextEditingController pencarian = TextEditingController();
  final Set<int> favorit = {};
  final List<Resep> resepSaya = [];

  String kategoriAktif = 'Semua';

  final List<String> kategori = [
    'Semua',
    'Sarapan',
    'Makanan Utama',
    'Camilan',
  ];

  List<Resep> get semuaResep => [...dataResep, ...resepSaya];

  List<Resep> get resepTampil {
    return semuaResep.where((resep) {
      final cocokNama = resep.nama
          .toLowerCase()
          .contains(pencarian.text.toLowerCase());

      final cocokKategori = kategoriAktif == 'Semua' ||
          resep.kategori == kategoriAktif;

      return cocokNama && cocokKategori;
    }).toList();
  }

  @override
  void dispose() {
    pencarian.dispose();
    super.dispose();
  }

  Color warnaKategori(String kategori) {
    switch (kategori) {
      case 'Sarapan':
        return const Color(0xFFFFE9A8);
      case 'Makanan Utama':
        return const Color(0xFFDDF4E3);
      case 'Camilan':
        return const Color(0xFFDDEEFF);
      default:
        return const Color(0xFFFFDCE8);
    }
  }

  void bukaDetail(Resep resep) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HalamanDetailResep(
          resep: resep,
          sudahFavorit: favorit.contains(resep.id),
          saatFavorit: (aktif) {
            setState(() {
              if (aktif) {
                favorit.add(resep.id);
              } else {
                favorit.remove(resep.id);
              }
            });
          },
        ),
      ),
    );
  }

  void tambahResep(Resep resep) {
    setState(() {
      resepSaya.add(resep);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Resep baru berhasil ditambahkan! 💗'),
      ),
    );
  }

  void bukaForm() {
    Navigator.push<Resep>(
      context,
      MaterialPageRoute(
        builder: (_) => const FormTambahResep(),
      ),
    ).then((resep) {
      if (resep != null) {
        tambahResep(resep);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('🍳 ', style: TextStyle(fontSize: 28)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RaeCook',
                  style: TextStyle(
                    color: Color(0xFFE7477D),
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const Text(
                  'Cook something lovely!',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Resep favorit',
            icon: const Icon(
              Icons.favorite,
              color: Color(0xFFFF5C93),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Resep Favorit 💗'),
                  content: SizedBox(
                    width: double.maxFinite,
                    child: favorit.isEmpty
                        ? const Text('Yuk, pilih resep favoritmu!')
                        : ListView(
                            shrinkWrap: true,
                            children: semuaResep
                                .where((r) => favorit.contains(r.id))
                                .map(
                                  (r) => ListTile(
                                    title: Text(r.nama),
                                    leading: Text(
                                      r.emoji,
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      bukaDetail(r);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup'),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFDCE8),
                    Color(0xFFFFE9A8),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'MASAK APA HARI INI?',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Ide lezat,\nmulai dari dapurmu!',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF69364D),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Temukan resep favorit dengan bahan sederhana.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '👩🏻‍🍳',
                    style: TextStyle(fontSize: 65),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: pencarian,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Cari nasi goreng, ayam, camilan...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF3979D6),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Kategori resep',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: kategori.map((item) {
                final aktif = kategoriAktif == item;

                return ChoiceChip(
                  label: Text(item),
                  selected: aktif,
                  selectedColor: const Color(0xFFFFB6CF),
                  backgroundColor: warnaKategori(item),
                  onSelected: (_) {
                    setState(() => kategoriAktif = item);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Resep pilihan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${resepTampil.length} resep',
                  style: const TextStyle(
                    color: Color(0xFFE7477D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (resepTampil.isEmpty)
              const Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Text('Resep tidak ditemukan 🥹'),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: resepTampil.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 165,
                ),
                itemBuilder: (context, index) {
                  final resep = resepTampil[index];

                  return KartuResep(
                    resep: resep,
                    favorit: favorit.contains(resep.id),
                    warna: warnaKategori(resep.kategori),
                    saatDibuka: () => bukaDetail(resep),
                    saatFavorit: () {
                      setState(() {
                        if (favorit.contains(resep.id)) {
                          favorit.remove(resep.id);
                        } else {
                          favorit.add(resep.id);
                        }
                      });
                    },
                  );
                },
              ),

            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFDDF4E3),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text(
                '💡 Masak sendiri, pilih bahan favoritmu, '
                'dan nikmati hasilnya bersama orang tersayang!',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: bukaForm,
              icon: const Icon(Icons.add),
              label: const Text('Tambah Resep'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5C93),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// KARTU RESEP — REVISI JARAK DAN UKURAN
class KartuResep extends StatelessWidget {
  final Resep resep;
  final bool favorit;
  final Color warna;
  final VoidCallback saatDibuka;
  final VoidCallback saatFavorit;

  const KartuResep({
    super.key,
    required this.resep,
    required this.favorit,
    required this.warna,
    required this.saatDibuka,
    required this.saatFavorit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: saatDibuka,
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 78,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: warna,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          resep.emoji,
                          style: const TextStyle(fontSize: 42),
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: IconButton(
                          onPressed: saatFavorit,
                          icon: Icon(
                            favorit
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: const Color(0xFFFF5C93),
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                resep.nama,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    size: 13,
                    color: Colors.orange,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    '${resep.durasi} menit',
                    style: const TextStyle(fontSize: 11),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.star,
                    size: 13,
                    color: Color(0xFFFFC83D),
                  ),
                  Text(
                    '${resep.rating}',
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: warna,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  resep.kategori,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HALAMAN DETAIL RESEP
class HalamanDetailResep extends StatefulWidget {
  final Resep resep;
  final bool sudahFavorit;
  final ValueChanged<bool> saatFavorit;

  const HalamanDetailResep({
    super.key,
    required this.resep,
    required this.sudahFavorit,
    required this.saatFavorit,
  });

  @override
  State<HalamanDetailResep> createState() =>
      _HalamanDetailResepState();
}

class _HalamanDetailResepState extends State<HalamanDetailResep> {
  late bool favorit;

  @override
  void initState() {
    super.initState();
    favorit = widget.sudahFavorit;
  }

  @override
  Widget build(BuildContext context) {
    final resep = widget.resep;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Resep'),
        actions: [
          IconButton(
            tooltip: 'Favorit',
            onPressed: () {
              setState(() {
                favorit = !favorit;
              });
              widget.saatFavorit(favorit);
            },
            icon: Icon(
              favorit ? Icons.favorite : Icons.favorite_border,
              color: const Color(0xFFFF5C93),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDCE8),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                resep.emoji,
                style: const TextStyle(fontSize: 100),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            resep.nama,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFF343047),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            resep.deskripsi,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: InfoResep(
                  ikon: Icons.schedule,
                  nilai: '${resep.durasi} menit',
                  warna: const Color(0xFFFFB6CF),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InfoResep(
                  ikon: Icons.people,
                  nilai: '${resep.porsi} porsi',
                  warna: const Color(0xFFBCE8C8),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: InfoResep(
                  ikon: Icons.star,
                  nilai: '${resep.rating}',
                  warna: const Color(0xFFFFE28A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEAF1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '🧺 Bahan-bahan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...resep.bahan.map(
                  (bahan) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFFFF5C93),
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(child: Text(bahan)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE4F1FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '👩🏻‍🍳 Cara membuat',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                ...resep.langkah.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFD65C),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${entry.key + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(entry.value),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Selamat memasak bersama RaeCook! 💗'),
                ),
              );
            },
            icon: const Icon(Icons.restaurant),
            label: const Text('Mulai Memasak'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5C93),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// WIDGET INFORMASI RESEP
class InfoResep extends StatelessWidget {
  final IconData ikon;
  final String nilai;
  final Color warna;

  const InfoResep({
    super.key,
    required this.ikon,
    required this.nilai,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(ikon, color: const Color(0xFF343047)),
          const SizedBox(height: 6),
          Text(
            nilai,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// FORM TAMBAH RESEP
class FormTambahResep extends StatefulWidget {
  const FormTambahResep({super.key});

  @override
  State<FormTambahResep> createState() => _FormTambahResepState();
}

class _FormTambahResepState extends State<FormTambahResep> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final deskripsiController = TextEditingController();
  final durasiController = TextEditingController();
  final porsiController = TextEditingController(text: '2');
  final bahanController = TextEditingController();
  final langkahController = TextEditingController();

  String kategori = 'Makanan Utama';
  String emoji = '🍽️';
  String tingkat = 'Mudah';

  final List<String> daftarKategori = [
    'Sarapan',
    'Makanan Utama',
    'Camilan',
  ];

  final List<String> daftarEmoji = [
    '🍽️',
    '🍜',
    '🍗',
    '🍰',
    '🥗',
    '🥞',
    '🍕',
    '🍫',
  ];

  @override
  void dispose() {
    namaController.dispose();
    deskripsiController.dispose();
    durasiController.dispose();
    porsiController.dispose();
    bahanController.dispose();
    langkahController.dispose();
    super.dispose();
  }

  String? wajibDiisi(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bagian ini wajib diisi';
    }
    return null;
  }

  InputDecoration dekorasiInput(
    String label,
    String contoh,
  ) {
    return InputDecoration(
      labelText: label,
      hintText: contoh,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFFFFDCE8),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: Color(0xFFFFDCE8),
        ),
      ),
    );
  }

  void simpanResep() {
    if (!_formKey.currentState!.validate()) return;

    final durasi = int.tryParse(durasiController.text.trim());
    final porsi = int.tryParse(porsiController.text.trim());

    if (durasi == null ||
        durasi <= 0 ||
        porsi == null ||
        porsi <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Durasi dan porsi harus berupa angka positif.',
          ),
        ),
      );
      return;
    }

    final bahan = bahanController.text
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    final langkah = langkahController.text
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    if (bahan.isEmpty || langkah.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Isi bahan dan cara membuat terlebih dahulu.',
          ),
        ),
      );
      return;
    }

    final resepBaru = Resep(
      id: DateTime.now().millisecondsSinceEpoch,
      nama: namaController.text.trim(),
      deskripsi: deskripsiController.text.trim(),
      kategori: kategori,
      emoji: emoji,
      durasi: durasi,
      porsi: porsi,
      rating: 5.0,
      tingkat: tingkat,
      bahan: bahan,
      langkah: langkah,
    );

    Navigator.pop(context, resepBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Resep Baru'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFDCE8),
                    Color(0xFFE4F1FF),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                children: [
                  Text(
                    '🧑🏻‍🍳',
                    style: TextStyle(fontSize: 45),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Resep Spesialmu!',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Bagikan ide makanan favoritmu di RaeCook.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            TextFormField(
              controller: namaController,
              decoration: dekorasiInput(
                'Nama makanan',
                'Contoh: Mie Goreng',
              ),
              validator: wajibDiisi,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: deskripsiController,
              decoration: dekorasiInput(
                'Deskripsi resep',
                'Ceritakan sedikit tentang makanan ini',
              ),
              maxLines: 2,
              validator: wajibDiisi,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: durasiController,
                    keyboardType: TextInputType.number,
                    decoration: dekorasiInput(
                      'Durasi (menit)',
                      '20',
                    ),
                    validator: wajibDiisi,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: porsiController,
                    keyboardType: TextInputType.number,
                    decoration: dekorasiInput(
                      'Jumlah porsi',
                      '2',
                    ),
                    validator: wajibDiisi,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: kategori,
              decoration: dekorasiInput(
                'Kategori resep',
                'Pilih kategori',
              ),
              items: daftarKategori.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => kategori = value);
                }
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Pilih ikon makanan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: daftarEmoji.map((item) {
                return ChoiceChip(
                  label: Text(
                    item,
                    style: const TextStyle(fontSize: 22),
                  ),
                  selected: emoji == item,
                  selectedColor: const Color(0xFFFFDCE8),
                  onSelected: (_) {
                    setState(() => emoji = item);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: tingkat,
              decoration: dekorasiInput(
                'Tingkat kesulitan',
                'Pilih tingkat',
              ),
              items: ['Mudah', 'Sedang', 'Sulit'].map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => tingkat = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: bahanController,
              decoration: dekorasiInput(
                'Bahan-bahan',
                'Pisahkan setiap bahan dengan koma',
              ),
              maxLines: 3,
              validator: wajibDiisi,
            ),
            const SizedBox(height: 8),
            const Text(
              'Contoh: 2 butir telur, 1 piring nasi, garam',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: langkahController,
              decoration: dekorasiInput(
                'Cara membuat',
                'Pisahkan setiap langkah dengan koma',
              ),
              maxLines: 4,
              validator: wajibDiisi,
            ),
            const SizedBox(height: 8),
            const Text(
              'Contoh: Panaskan minyak, masukkan telur, aduk rata',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: const Color(0xFFE7477D),
                    ),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: simpanResep,
                    icon: const Icon(Icons.save),
                    label: const Text('Simpan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5C93),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}