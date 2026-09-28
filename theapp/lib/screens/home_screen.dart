import 'package:flutter/material.dart';
import '../models/dest.dart'; // 1. Model data sumber
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      // --- APPBAR UTAMA ---
      appBar: AppBar(
        title: const Text('Daftar Data'), // Ganti judul halaman sesuai tema
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      // --- BODY GRID 2 KOLOM ---
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, // Rasio ukuran Card (gambar + teks)
        ),
        itemCount: destinationList.length, // 2. Sesuaikan nama list data dari model
        itemBuilder: (context, index) {
          final item = destinationList[index]; // 3. Objek data per-item

          return InkWell(
            onTap: () {
              // Navigasi ke halaman detail sambil mengirim data item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(destination: item),
                ),
              );
            },
            child: Card(
              elevation: 1,
              clipBehavior: Clip.antiAlias, // Potong gambar melengkung mengikuti sudut card
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==========================================
                  // 1. BAGIAN GAMBAR
                  // ==========================================
                  Expanded(
                    child: Image.network(
                      item.imageUrl, // Field URL gambar
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),

                  // ==========================================
                  // 2. BAGIAN TEKS INFORMASI
                  // ==========================================
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- [UTAMA] NAMA / JUDUL ITEM ---
                        Text(
                          item.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          maxLines: 2, // Maksimal 2 baris agar nama panjang tidak terpotong
                          overflow: TextOverflow.ellipsis,
                        ),

                        // --- [OPSIONAL 1] BADGE KATEGORI / TIPE ---
                        // (Bisa dihapus / dikomen jika soal tidak ada kategori)
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            item.category, // Field kategori/tipe
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade800,
                            ),
                          ),
                        ),

                        // --- [OPSIONAL 2] SUB-INFO PENDUKUNG ---
                        // (Contoh: lokasi, harga, asal, jenis, dll)
                        const SizedBox(height: 4),
                        Text(
                          item.location, // Field info pendukung
                          style: const TextStyle(fontSize: 11, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
