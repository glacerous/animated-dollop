import 'package:flutter/material.dart';
import '../models/dest.dart';

/* =========================================================================
   VARIASI LAYOUT DETAIL SCREEN:
   - Menampilkan Chip & Wrap untuk tags/kategori.
   - Menampilkan horizontal image gallery preview (ListView horizontal).
   - Menampilkan visual review / rating bintang.
   - SnackBar interaktif saat toggle favorite.
   ========================================================================= */

class DetailScreen extends StatefulWidget {
  final DestinationModel destination;

  const DetailScreen({super.key, required this.destination});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    // SnackBar feedback interaktif sesuai status favorit
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Ditambahkan ke daftar favorit!' : 'Dihapus dari favorit.',
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: isFavorite ? Colors.teal : Colors.grey[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.destination;

    // Simulasi data galeri gambar preview tambahan
    final List<String> sampleGallery = [
      item.imageUrl,
      item.imageUrl,
      item.imageUrl,
    ];

    // Simulasi tags / highlight fasilitas (contoh penggunaan Wrap & Chip)
    final List<String> tags = [
      item.category,
      "Populer",
      "Rekomendasi",
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: isFavorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.redAccent : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. GAMBAR UTAMA DENGAN HERO / TAMPILAN PENUH
            SizedBox(
              width: double.infinity,
              height: 240,
              child: Image.network(
                item.imageUrl,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => Container(
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                ),
              ),
            ),

            // 2. KONTEN DETAIL
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- BARIS NAMA & RATING ---
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Visual Rating Bintang
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber.shade200),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.star, size: 16, color: Colors.amber),
                            SizedBox(width: 4),
                            Text('4.8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(item.location, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // --- CONTOH WIDGET WRAP & CHIP (Sangat sering untuk Tag / Kategori) ---
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: tags.map((tag) {
                      return Chip(
                        label: Text(tag, style: const TextStyle(fontSize: 11)),
                        backgroundColor: Colors.teal.shade50,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: BorderSide(color: Colors.teal.shade100),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 10),

                  // --- KEY-VALUE INFO ROWS ---
                  _buildRowItem(Icons.star_outline_rounded, "Fasilitas", item.attraction),
                  _buildRowItem(Icons.access_time_rounded, "Waktu Buka", item.openingHours),
                  _buildRowItem(Icons.confirmation_number_outlined, "Info Tiket", item.ticketInfo),
                  _buildRowItem(Icons.link_rounded, "Sumber", item.wikipediaUrl),

                  const SizedBox(height: 16),

                  // --- CONTOH HORIZONTAL SCROLL GALLERY (ListView horizontal) ---
                  const Text(
                    "Galeri Foto",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sampleGallery.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              sampleGallery[index],
                              width: 120,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => Container(
                                width: 120,
                                color: Colors.grey[200],
                                child: const Icon(Icons.broken_image, color: Colors.grey),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- PARAGRAF DESKRIPSI ---
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.5),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRowItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.teal),
          const SizedBox(width: 12),
          SizedBox(
            width: 85,
            child: Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
