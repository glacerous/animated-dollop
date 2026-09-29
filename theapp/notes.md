# Catatan Alur Navigasi, Arsitektur & Teori OOP Aplikasi Flutter

Dokumen ini menjelaskan alur jalannya data dan navigasi layar dari main.dart, Login, Root (BottomNav), Home, Detail, hingga Profile (Logout), serta **pemetaan konsep teori Object-Oriented Programming (OOP) & Arsitektur Flutter** yang diterapkan.

---

## Ringkasan Konsep Teori & Penerapannya

| Teori / Konsep | Penjelasan Singkat | Contoh Penerapan di Kode |
| :--- | :--- | :--- |
| **Encapsulation (Enkapsulasi)** | Membatasi akses langsung ke data/state internal dengan menjadikannya privat (`_`) dan hanya memaparkan interface yang diperlukan. | - Prefix underscore pada state class: `_LoginScreenState`, `_RootState`, `_DetailScreenState`.<br>- Variabel privat: `_usernameController`, `_selectedIndex`, `_isFavorite`. |
| **Inheritance (Pewarisan)** | Membuat kelas baru berdasarkan kelas yang sudah ada untuk mewarisi sifat dan perilakunya. | - `class MainApp extends StatelessWidget`<br>- `class Root extends StatefulWidget`<br>- `class _RootState extends State<Root>` |
| **Polymorphism (Polimorfisme)** | Kemampuan objek/fungsi memperlakukan bentuk turunan yang berbeda melalui antarmuka yang sama (`@override`). | - Override method `@override Widget build(BuildContext context)` di setiap widget.<br>- Override lifecycle `@override void dispose()`.<br>- List bertipe heterogen turunan Widget: `final List<Widget> pages = [HomeScreen(), ProfileScreen()]`. |
| **Abstraction (Abstraksi)** | Menyembunyikan detail implementasi yang kompleks dan hanya menampilkan fungsionalitas esensial. | - Penggunaan abstract class dari framework: `StatelessWidget`, `StatefulWidget`, `State`.<br>- Model data (`User`, `DestinationModel`) yang memodelkan entitas nyata menjadi representasi data terstruktur. |
| **Constructor & Immutability** | Menjamin objek bersifat *immutable* (tidak dapat diubah sembarangan) setelah dibuat dengan `final` dan `const`. | - `const MainApp({super.key})`<br>- `final String username;` pada constructor `Root({super.key, required this.username})`. |
| **State Management (Epik / Lokal)** | Pengelolaan data dinamis yang mempengaruhi rendering UI menggunakan lifecycle framework. | - `setState(() { ... })` saat mengubah tab di `Root` dan saat bookmark di `DetailScreen`.<br>- Pembersihan resource memori dengan `dispose()` controller. |

---

## 1. Titik Awal: main.dart
- **Tujuan**: Menginisialisasi aplikasi utama dan menetapkan layar pertama.
- **Teori Terkait**:
  - **Inheritance & Polymorphism**: `MainApp` mewarisi `StatelessWidget` dan meng-`@override` method `build()`.
- **Fungsi Kunci**:
  ```dart
  void main() {
    runApp(const MainApp());
  }
  ```
- **Alur**:
  - `MaterialApp` mendefinisikan root widget tema dan navigasi.
  - Properti `home: const LoginScreen()` menetapkan bahwa halaman pertama yang dibuka saat aplikasi dijalankan adalah **LoginScreen**.

---

## 2. Halaman Masuk: LoginScreen (`lib/screens/login_screen.dart`)
- **Tujuan**: Mengambil input akun dari user dan mencocokkannya dengan data dummy.
- **Teori Terkait**:
  - **Encapsulation**: Controller input `_usernameController` dan `_passwordController` diberi prefix `_` (privat di file tersebut).
  - **Resource Management (Lifecycle)**: Mengimplementasikan `dispose()` untuk mencegah kebocoran memori (*memory leak*).
- **Alur Validasi**:
  ```dart
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
  ```
  > **Catatan Navigasi**: Menggunakan `Navigator.pushReplacement` agar user tidak bisa menekan tombol "Back" di HP untuk kembali ke halaman login setelah berhasil masuk.

---

## 3. Pengelola Tab: Root (`lib/root.dart`)
- **Tujuan**: Menampung BottomNavigationBar dan mengatur pergantian layar antara **Home** dan **Profile** tanpa memuat ulang seluruh aplikasi.
- **Teori Terkait**:
  - **Encapsulation**: State `_selectedIndex` bersifat privat dan hanya bisa diubah melalui event di dalam kelas tersebut.
  - **Polymorphism**: `List<Widget> pages` menampung elemen-elemen berbeda (`HomeScreen` dan `ProfileScreen`) yang sama-sama merupakan turunan dari antarmuka `Widget`.
- **Data Masuk**: Menerima parameter `username` dari `LoginScreen`.
- **Alur Kerja**:
  ```dart
  final List<Widget> pages = [
    const HomeScreen(),
    ProfileScreen(username: widget.username),
  ];
  ```
  - Pada `Scaffold.body`, dipanggil `pages[_selectedIndex]`.
  - Ketika item bar ditekan, fungsi `onTap: (index)` mengupdate `_selectedIndex` lewat `setState()` sehingga tampilan otomatis berganti.

---

## 4. Halaman Katalog: HomeScreen (`lib/screens/home_screen.dart`)
- **Tujuan**: Menampilkan daftar koleksi item dalam bentuk kartu grid 2 kolom.
- **Teori Terkait**:
  - **Abstraction**: Data diabstraksikan ke dalam entitas model `DestinationModel` (bukan tipe data mentah yang tercecer).
  - **Loose Coupling**: `HomeScreen` tidak peduli dari mana data berasal, ia hanya bertugas merender koleksi objek model.
- **Alur Navigasi ke Detail**:
  ```dart
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
  ```
  > **Catatan Navigasi**: Menggunakan `Navigator.push` biasa agar di halaman detail otomatis muncul tombol panah kembali (<-) di AppBar. Objek `item` dikirimkan secara langsung ke constructor `DetailScreen`.

---

## 5. Halaman Rincian: DetailScreen (`lib/screens/detail_screen.dart`)
- **Tujuan**: Menampilkan seluruh properti data spesifik dari objek yang dipilih.
- **Teori Terkait**:
  - **Immutability**: Objek `destination` bertipe `final DestinationModel destination`, menjaga agar data asli tidak termutasi secara tidak sengaja di layar rincian.
  - **Encapsulation**: Helper method `_buildRowItem(...)` dan state `_isFavorite` bersifat privat untuk menjaga kerapian modul.
- **Fitur Kunci**:
  1. **Header Gambar Penuh**: Menampilkan foto item (`destination.imageUrl`) dengan `errorBuilder` sebagai *fallback*.
  2. **Info Key-Value**: Menggunakan helper `_buildRowItem(icon, label, value)` agar kode modular.
  3. **Favorite Toggle (Stateful)**:
     ```dart
     void _toggleFavorite() {
       setState(() {
         isFavorite = !isFavorite;
       });
       ScaffoldMessenger.of(context).showSnackBar(...);
     }
     ```
  4. **Deskripsi Paragraf**: Menampilkan teks panjang dengan *readability* yang baik.

---

## 6. Halaman Akun & Keluar: ProfileScreen (`lib/screens/profile_screen.dart`)
- **Tujuan**: Menampilkan info akun user yang sedang aktif dan menyediakan akses keluar (logout).
- **Data Masuk**: Menerima `username` dari `Root`.
- **Alur Logout**:
  ```dart
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false,
  );
  ```
  > **Catatan Navigasi**: Menggunakan `Navigator.pushAndRemoveUntil` dengan predikat `(route) => false`. Ini akan menghapus seluruh tumpukan halaman (Home, Detail, Root, dll) dari memori dan mengembalikan aplikasi ke kondisi bersih di **LoginScreen**.

---

## Ringkasan Perbedaan Metode Navigasi
| Metode | Penggunaan | Contoh di Aplikasi |
| :--- | :--- | :--- |
| `Navigator.push` | Membuka halaman baru (bisa kembali) | `HomeScreen` ➔ `DetailScreen` |
| `Navigator.pop` | Menutup halaman aktif dan kembali ke sebelumnya | Tombol Back / Panah AppBar |
| `Navigator.pushReplacement` | Menimpa halaman aktif dengan halaman baru | `LoginScreen` ➔ `Root` |
| `Navigator.pushAndRemoveUntil` | Menghapus semua riwayat halaman lalu membuka halaman baru | `ProfileScreen` (Logout) ➔ `LoginScreen` |
