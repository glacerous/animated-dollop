/* =========================================================================
   COMMON DATA TYPES REFERENCE:
   
   1. String       : For standard text values
                     Example: String name, String category, String imageUrl
                     UI Usage: Text(item.name)
                     
   2. int          : For whole numbers (price, stock, height, duration)
                     Example: int price, int stock, int height
                     UI Usage: Text('Rp ') or Text(' cm')
                     
   3. double       : For floating point decimals (rating, weight, distance)
                     Example: double rating, double weight
                     UI Usage: Text(' / 5.0') or Text(' kg')
                     
   4. bool         : For boolean flags (status, availability)
                     Example: bool isAvailable, bool isDiscount
                     UI Usage: item.isAvailable ? Text('Available') : Text('Out of Stock')
                     
   5. List<String> : For collections of text items (tags, facilities, activities)
                     Example: List<String> activities, List<String> tags
                     UI Usage: Text(item.activities.join(', '))
                     
   6. List<String> : For image gallery URLs
                     Example: List<String> imageGallery
                     UI Usage: Image.network(item.imageGallery[0])
   ========================================================================= */

class DestinationModel {
  String name;
  String category;
  String location;
  String description;
  String openingHours;
  String ticketInfo;
  String attraction;
  String imageUrl;
  String wikipediaUrl;

  DestinationModel({
    required this.name,
    required this.category,
    required this.location,
    required this.description,
    required this.openingHours,
    required this.ticketInfo,
    required this.attraction,
    required this.imageUrl,
    required this.wikipediaUrl,
  });
}

List<DestinationModel> destinationList = [
  DestinationModel(
    name: "Candi Borobudur",
    category: "Wisata sejarah",
    location: "Magelang, Jawa Tengah",
    description: "Candi Buddha yang terkenal dengan teras bertingkat, relief, dan stupa.",
    openingHours: "06.30â€“16.30",
    ticketInfo: "Cek kanal resmi untuk informasi tiket terbaru.",
    attraction: "Relief, stupa, arsitektur candi, dan pemandangan sekitar.",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/7/77/Borobudur-Nothwest-view.jpg",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Borobudur",
  ),
  DestinationModel(
    name: "Pantai Kuta",
    category: "Wisata pantai",
    location: "Badung, Bali",
    description: "Pantai populer dengan garis pantai berpasir dan pemandangan matahari terbenam.",
    openingHours: "Sepanjang hari",
    ticketInfo: "Akses pantai umumnya gratis; biaya parkir dapat berlaku.",
    attraction: "Menikmati sunset, berjalan di tepi pantai, dan berselancar.",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/6/6e/Kuta_Bali_beach.jpg",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Pantai_Kuta",
  ),
  DestinationModel(
    name: "Taman Nasional Komodo",
    category: "Wisata alam",
    location: "Nusa Tenggara Timur",
    description: "Kawasan konservasi yang menjadi habitat komodo dan memiliki ekosistem pulau serta laut yang khas.",
    openingHours: "Sesuai aturan pengelola",
    ticketInfo: "Cek informasi resmi untuk tarif dan ketentuan terbaru.",
    attraction: "Pengamatan komodo, trekking dengan pemandu, dan panorama laut.",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/5/5b/Komodo_Island.jpg",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Taman_Nasional_Komodo",
  ),
  DestinationModel(
    name: "Raja Ampat",
    category: "Wisata bahari",
    location: "Papua Barat Daya",
    description: "Kepulauan yang dikenal dengan keanekaragaman hayati laut, pulau karst, dan perairan jernih.",
    openingHours: "Sesuai jadwal transportasi dan layanan setempat",
    ticketInfo: "Biaya perjalanan dan kontribusi konservasi dapat berlaku.",
    attraction: "Snorkeling, menyelam, dan menikmati lanskap pulau karst.",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/0/0e/Raja_Ampat_Islands.jpg",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Kepulauan_Raja_Ampat",
  ),
  DestinationModel(
    name: "Gunung Bromo",
    category: "Wisata pegunungan",
    location: "Jawa Timur",
    description: "Gunung berapi aktif yang terkenal dengan lautan pasir dan panorama kaldera.",
    openingHours: "Sesuai aturan kawasan",
    ticketInfo: "Cek ketentuan pengelola untuk tiket dan layanan kendaraan.",
    attraction: "Matahari terbit, lautan pasir, dan pemandangan kaldera.",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/4/4e/Mount_Bromo.jpg",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Gunung_Bromo",
  ),

  DestinationModel(
    name: "Danau Toba",
    category: "Wisata alam",
    location: "Sumatera Utara",
    description: "Danau vulkanik besar yang memiliki Pulau Samosir di tengahnya.",
    openingHours: "Sepanjang hari",
    ticketInfo: "Biaya mengikuti lokasi wisata dan aktivitas yang dikunjungi.",
    attraction: "Panorama danau, budaya Batak, dan Pulau Samosir.",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/2/20/Lake_Toba.jpg",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Danau_Toba",
  ),
  DestinationModel(
    name: "Kawah Ijen",
    category: "Wisata pegunungan",
    location: "Jawa Timur",
    description: "Kawasan gunung api yang dikenal dengan danau kawah berwarna toska.",
    openingHours: "Sesuai aturan pengelola",
    ticketInfo: "Cek kanal resmi untuk tarif dan jam kunjungan.",
    attraction: "Danau kawah, jalur pendakian, dan fenomena api biru saat kondisi memungkinkan.",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/5/5b/Ijen_Crater.jpg",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Kawah_Ijen",
  ),
  DestinationModel(
    name: "Taman Mini Indonesia Indah",
    category: "Wisata edukasi",
    location: "Jakarta Timur, DKI Jakarta",
    description: "Taman budaya yang menampilkan keragaman rumah adat dan budaya Indonesia.",
    openingHours: "Sesuai jadwal operasional",
    ticketInfo: "Cek situs resmi untuk harga tiket dan wahana.",
    attraction: "Anjungan daerah, museum, dan pertunjukan budaya.",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/1/1c/Taman_Mini_Indonesia_Indah.jpg",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Taman_Mini_Indonesia_Indah",
  ),
  DestinationModel(
    name: "Lawang Sewu",
    category: "Wisata sejarah",
    location: "Semarang, Jawa Tengah",
    description: "Bangunan bersejarah peninggalan perkeretaapian dengan arsitektur khas.",
    openingHours: "Sesuai jadwal pengelola",
    ticketInfo: "Cek informasi pengelola untuk tiket masuk.",
    attraction: "Arsitektur kolonial, ruang pamer, dan sejarah perkeretaapian.",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/9/9e/Lawang_Sewu_Semarang.jpg",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Lawang_Sewu",
  ),
  DestinationModel(
    name: "Pantai Parangtritis",
    category: "Wisata pantai",
    location: "Bantul, DI Yogyakarta",
    description: "Pantai di pesisir selatan Yogyakarta yang dikenal dengan hamparan pasir luas.",
    openingHours: "Sepanjang hari",
    ticketInfo: "Retribusi kawasan dapat berlaku.",
    attraction: "Pemandangan pantai, menikmati senja, dan wisata pesisir.",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/8/8e/Parangtritis_beach.jpg",
    wikipediaUrl: "https://id.wikipedia.org/wiki/Parangtritis",
  ),
];

