# Catatan Alur Navigasi & Arsitektur Aplikasi Flutter

Dokumen ini menjelaskan alur lengkap jalannya data dan navigasi layar dari main.dart, Login, Root (BottomNav), Home, Detail, hingga Profile (Logout).

---

## 1. Titik Awal: main.dart
- **Tujuan**: Menginisialisasi aplikasi utama dan menetapkan layar pertama.
- **Fungsi Kunci**:
  `dart
  void main() {
    runApp(const MainApp());
  }
  `
- **Alur**:
  - MaterialApp mendefinisikan root widget.
  - Properti home: const LoginScreen() menetapkan bahwa halaman pertama yang dibuka saat aplikasi dijalankan adalah **LoginScreen**.

---

## 2. Halaman Masuk: LoginScreen (lib/screens/login_screen.dart)
- **Tujuan**: Mengambil input akun dari user dan mencocokkannya dengan data dummy.
- **Komponen Kunci**:
  - TextEditingController: Digunakan untuk membaca nilai yang diketik pada TextField username dan password (_usernameController.text).
  - models/user.dart: Tempat menyimpan list akun (users).
- **Alur Validasi**:
  `dart
  if (users.any((user) => user.username == username && user.password == password)) {
    // 1. Tampilkan feedback berhasil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login Berhasil!'), backgroundColor: Colors.green),
    );

    // 2. Pindah ke Root & hapus halaman Login dari stack
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Root(username: username)),
    );
  }
  `
  > **Catatan Navigasi**: Menggunakan Navigator.pushReplacement agar user tidak bisa menekan tombol "Back" di HP untuk kembali ke halaman login setelah berhasil masuk.

---

## 3. Pengelola Tab: Root (lib/root.dart)
- **Tujuan**: Menampung BottomNavigationBar dan mengatur pergantian layar antara **Home** dan **Profile** tanpa memuat ulang seluruh aplikasi.
- **Data Masuk**: Menerima parameter username dari LoginScreen.
- **Komponen Kunci**:
  - int _selectedIndex = 0: Variabel state untuk menandai tab mana yang aktif.
  - List<Widget> pages: Daftar widget yang ditampilkan sesuai indeks tab.
    `dart
    final List<Widget> pages = [
      const HomeScreen(),
      ProfileScreen(username: widget.username),
    ];
    `
- **Alur Kerja**:
  - Pada Scaffold.body, dipanggil pages[_selectedIndex].
  - Ketika item bar ditekan, fungsi onTap: (index) mengupdate _selectedIndex lewat setState() sehingga tampilan otomatis berganti.

---

## 4. Halaman Katalog: HomeScreen (lib/screens/home_screen.dart)
- **Tujuan**: Menampilkan daftar koleksi item dalam bentuk kartu grid 2 kolom.
- **Data Masuk**: Membaca list dari file model (destinationList di models/dest.dart).
- **Komponen Kunci**:
  - GridView.builder: Merender kartu secara efisien (hanya item yang terlihat di layar yang dirender).
  - childAspectRatio: 0.75: Menjaga proporsi tinggi vs lebar kartu agar gambar dan teks tidak berantakan.
- **Alur Navigasi ke Detail**:
  `dart
  InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(destination: item),
        ),
      );
    },
    child: Card(...),
  )
  `
  > **Catatan Navigasi**: Menggunakan Navigator.push biasa agar di halaman detail otomatis muncul tombol panah kembali (<-) di AppBar. Objek item dikirimkan secara langsung ke constructor DetailScreen.

---

## 5. Halaman Rincian: DetailScreen (lib/screens/detail_screen.dart)
- **Tujuan**: Menampilkan seluruh properti data spesifik dari objek yang dipilih.
- **Data Masuk**: inal DestinationModel destination yang dikirim dari HomeScreen.
- **Fitur & Komponen Kunci**:
  1. **Header Gambar Penuh**: Menampilkan foto item (destination.imageUrl) dengan errorBuilder sebagai pengaman jika URL gambar rusak.
  2. **Info Key-Value**: Menggunakan fungsi helper _buildRowItem(icon, label, value) agar kode modular dan rapi.
  3. **Favorite Toggle (Stateful)**:
     `dart
     void _toggleFavorite() {
       setState(() {
         isFavorite = !isFavorite;
       });
       ScaffoldMessenger.of(context).showSnackBar(...);
     }
     `
  4. **Deskripsi Paragraf**: Menampilkan teks panjang dengan spasi baris yang nyaman (height: 1.6).

---

## 6. Halaman Akun & Keluar: ProfileScreen (lib/screens/profile_screen.dart)
- **Tujuan**: Menampilkan info akun user yang sedang aktif dan menyediakan akses keluar (logout).
- **Data Masuk**: Menerima username dari Root.
- **Pencarian Data**:
  `dart
  final user = users.firstWhere(
    (u) => u.username == username,
    orElse: () => User(username: username, password: '', name: 'Pengguna'),
  );
  `
- **Alur Logout**:
  `dart
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false,
  );
  `
  > **Catatan Navigasi**: Menggunakan Navigator.pushAndRemoveUntil dengan predikat (route) => false. Ini akan menghapus seluruh tumpukan halaman (Home, Detail, Root, dll) dari memori dan mengembalikan aplikasi ke kondisi bersih di **LoginScreen**.

---

## Ringkasan Perbedaan Metode Navigasi
| Metode | Penggunaan | Contoh di Aplikasi |
| :--- | :--- | :--- |
| Navigator.push | Membuka halaman baru (bisa kembali) | HomeScreen ➔ DetailScreen |
| Navigator.pop | Menutup halaman aktif dan kembali ke sebelumnya | Tombol Back / Panah AppBar |
| Navigator.pushReplacement | Menimpa halaman aktif dengan halaman baru | LoginScreen ➔ Root |
| Navigator.pushAndRemoveUntil | Menghapus semua riwayat halaman lalu membuka halaman baru | ProfileScreen (Logout) ➔ LoginScreen |
