import 'package:flutter/material.dart';
import '../models/dest.dart';

class DetailScreen extends StatelessWidget {
  final DestinationModel destination;

  const DetailScreen({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(destination.name),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER GAMBAR FULL LEBAR (Tanpa margin atas)
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

            // 2. SHEET KONTEN
            Transform.translate(
              offset: const Offset(0, -20), // Membuat sheet sedikit menumpuk ke atas gambar
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // A. KATEGORI BADGE & LOKASI
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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

                    // B. NAMA UTAMA
                    Text(
                      destination.name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    // C. KEY-VALUE ITEMS (MINIMALIS & BERSIH)
                    // Key-value details:
                    _buildRowItem(Icons.star_outline_rounded, "Fasilitas", destination.attraction),
                    _buildRowItem(Icons.access_time_rounded, "Waktu Buka", destination.openingHours),
                    _buildRowItem(Icons.confirmation_number_outlined, "Info Tiket", destination.ticketInfo),
                    _buildRowItem(Icons.link_rounded, "Sumber", destination.wikipediaUrl),
                    // Jika data berupa List<String>:
                    // _buildRowItem(Icons.local_activity_outlined, "Aktivitas", destination.activities.join(', ')),

                    const Divider(height: 32),

                    // D. FREE TEXT / DESKRIPSI BEBAS DI BAWAH
                    const Text(
                      "Deskripsi",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      destination.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                        height: 1.6, // Spasi baris lega & enak dibaca
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
  // HELPER ROW ITEM: Minimalis, Bersih, Anti-Jiplak
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
            width: 90,
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
   COMMON ICONS REFERENCE:
   - Waktu / Jam     : Icons.access_time_rounded / Icons.schedule_outlined
   - Tiket / Biaya   : Icons.confirmation_number_outlined / Icons.payments_outlined
   - Tempat / Lokasi : Icons.location_on_outlined / Icons.map_outlined
   - Fasilitas       : Icons.star_outline_rounded / Icons.park_outlined
   - Link / Web      : Icons.link_rounded / Icons.info_outline
   - Hewan / Makanan : Icons.pets_outlined / Icons.restaurant_outlined
   ========================================================================= */
