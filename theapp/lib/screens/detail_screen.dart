import 'package:flutter/material.dart';
import '../models/dest.dart';

class DetailScreen extends StatefulWidget {
  final DestinationModel destination; // Menerima data model dari halaman sebelumnya

  const DetailScreen({super.key, required this.destination});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // Status favorite sederhana
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    // Menampilkan notifikasi popup (SnackBar) singkat di bawah
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Ditambahkan ke favorit' : 'Dihapus dari favorit',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(destination.name),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Tombol aksi Favorite di AppBar kanan atas
          IconButton(
            tooltip: isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. HEADER GAMBAR UTAMA (FULL LEBAR)
            // ==========================================
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                destination.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  ),
                ),
              ),
            ),

            // ==========================================
            // 2. KONTEN SHEET MELENGKUNG DI ATAS GAMBAR
            // ==========================================
            Transform.translate(
              offset: const Offset(0, -20), // Memberi efek tumpang tindih ke atas gambar
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- KATEGORI & LOKASI ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Badge Kategori
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            destination.category,
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.teal.shade800),
                          ),
                        ),
                        // Info Lokasi / Asal
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(destination.location, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // --- NAMA / JUDUL BESAR ---
                    Text(
                      destination.name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    // ==========================================
                    // 3. DAFTAR INFO DETAIL (KEY-VALUE)
                    // Tinggal tambah / hapus baris _buildRowItem as needed
                    // ==========================================
                    _buildRowItem(Icons.star_outline_rounded, "Fasilitas", destination.attraction),
                    _buildRowItem(Icons.access_time_rounded, "Waktu Buka", destination.openingHours),
                    _buildRowItem(Icons.confirmation_number_outlined, "Info Tiket", destination.ticketInfo),
                    _buildRowItem(Icons.link_rounded, "Sumber", destination.wikipediaUrl),

                    // NOTE: Jika tipe data adalah List<String> (misal: tags, aktivitas, habitat):
                    // _buildRowItem(Icons.local_activity_outlined, "Aktivitas", destination.activities.join(', ')),

                    const Divider(height: 32),

                    // ==========================================
                    // 4. BAGIAN FREE TEXT / DESKRIPSI LENGKAP
                    // ==========================================
                    const Text(
                      "Deskripsi",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      destination.description, // Paragraf teks bebas
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                        height: 1.6, // Jarak spasi baris agar enak dibaca
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // HELPER FUNCTION: Cetakan baris informasi agar kode rapi dan modular
  // =========================================================================
  Widget _buildRowItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.teal),
          const SizedBox(width: 12),
          SizedBox(
            width: 90, // Lebar label agar kolom nilai di sebelah kanan sejajar rapi
            child: Text(
              label,
              style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

/* =========================================================================
   CONTEKAN ICON UNIVERSAL (Tinggal copy namanya):
   
   1. WAKTU / JADWAL:
      - Icons.access_time_rounded       (Jam biasa)
      - Icons.schedule_outlined         (Jadwal waktu)
      - Icons.calendar_today_outlined   (Tanggal / Kalender)

   2. BIAYA / UANG / TIKET:
      - Icons.confirmation_number_outlined (Tiket)
      - Icons.payments_outlined            (Uang / Pembayaran)
      - Icons.attach_money_rounded         (Harga)

   3. LOKASI / TEMPAT:
      - Icons.location_on_outlined      (Pin Lokasi)
      - Icons.map_outlined              (Peta)
      - Icons.place_outlined            (Tempat)

   4. FASILITAS / KEUNGGULAN:
      - Icons.star_outline_rounded      (Bintang / Fasilitas)
      - Icons.park_outlined             (Taman / Wisata Alam)
      - Icons.attractions_outlined      (Wahana)

   5. LINK / INFO / KONTAK:
      - Icons.info_outline              (Informasi)
      - Icons.link_rounded              (Link / URL)
      - Icons.public_outlined           (Website)
      - Icons.phone_outlined            (Telepon)

   6. TEMATIK KHUSUS:
      - Icons.pets_outlined             (Hewan)
      - Icons.restaurant_outlined       (Makanan)
      - Icons.directions_car_outlined   (Kendaraan)
   ========================================================================= */
