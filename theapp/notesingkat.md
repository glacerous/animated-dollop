# Catatan Singkat Alur Kodingan Aplikasi (Gaya Santai & Istilah Teknis)

Catatan ini menjelaskan alur pembuatan dan cara kerja aplikasi dari awal sampai akhir, seolah kamu lagi jelasin langsung ke teman atau dosen. Setiap istilah teknis ("sebutan kerennya") ditulis jelas biar gampang dipahami.

---

### Langkah 1: Siapkan Wadah & Data Mentah di Folder `models/`
> *"Pertama, kita bikin blueprint (cetakan) datanya dulu biar terstruktur, terus kita isi data tiruannya (mock data)."*

1. **Bikin Class Model (Blueprint/Cetakan)**:
   - Istilah teknis: **Data Modeling / Encapsulation**.
   - Contohnya di `user.dart` dan `dest.dart`. Kita tentuin variabel apa aja yang dipunya, misal: `name` bertipe `String`, `price` bertipe `int`, `imageUrl` bertipe `String`.
2. **Bikin Dummy Data (Mock Data / Seed Data)**:
   - Istilah teknis: **Mock Data / In-Memory Dataset**.
   - Kita bikin sebuah `List` yang isinya objek-objek tiruan dari class model tadi (misal: `List<DestinationModel> destinationList = [...]`). Ini jadi sumber data utama sebelum aplikasi pakai API/database sungguhan.

---

### Langkah 2: Pintu Masuk Aplikasi di `main.dart`
> *"Di sini titik awal (entry point) aplikasi dijalankan dan nentuin layar mana yang dibuka pertama kali."*

1. **Fungsi `main()`**:
   - Istilah teknis: **Entry Point Function**.
   - Menjalankan perintah `runApp(const MainApp())`.
2. **Widget `MaterialApp`**:
   - Istilah teknis: **Root Widget / App Configuration**.
   - Di properti `home`, kita pasang `LoginScreen()`. Artinya: *"Begitu aplikasi dibuka di HP, langsung tampilin halaman Login dulu ya!"*

---

### Langkah 3: Halaman Masuk di `LoginScreen`
> *"User disuruh ngisi username dan password, terus kita cocokkan datanya dengan data dummy kita."*

1. **Nangkap Teks Inputan**:
   - Istilah teknis: **TextEditingController**.
   - Kita pasang controller di tiap kolom input (`_userController`, `_passController`) biar kita bisa baca teks apa yang diketik sama user (`controller.text`).
2. **Mencocokkan Data (Validasi & Filtering)**:
   - Istilah teknis: **Authentication Logic / Data Lookup**.
   - Pakai logika `users.any(...)` atau `firstWhereOrNull`: Kita cek apakah ada akun di list dummy yang punya username dan password cocok.
3. **Pindah Halaman Tanpa Balik**:
   - Istilah teknis: **Route Replacement / Screen Transition**.
   - Kalau benar, pakai `Navigator.pushReplacement(...)` ke halaman `Root`.
   - *Kenapa pushReplacement?* Biar halaman login **dibuang dari tumpukan (stack) memori**, jadi kalau user tekan tombol Back di HP, aplikasi keluar, bukan balik ke halaman login lagi.
4. **Kasih Pesan Muncul di Bawah**:
   - Istilah teknis: **Feedback Notification / SnackBar**.
   - Pakai `ScaffoldMessenger.of(context).showSnackBar(...)` buat kasih info "Login Berhasil" atau "Login Gagal".

---

### Langkah 4: Wadah Tab Navigasi di `Root`
> *"Ini halaman induk (wrapper) yang punya menu navigasi bawah (BottomNavigationBar) buat gonta-ganti layar tanpa me-reload aplikasi."*

1. **Nyimpan Indeks Halaman Aktif**:
   - Istilah teknis: **State Management (Local State)**.
   - Kita simpan variabel angka `int _selectedIndex = 0;` (0 = tab Home, 1 = tab Profile).
2. **Koleksi Halaman (List of Widgets)**:
   - Istilah teknis: **Polymorphic Collection**.
   - Kita punya list widget: `[HomeScreen(), ProfileScreen(username: widget.username)]`.
3. **Ganti Tampilan saat Menu Ditekan**:
   - Istilah teknis: **State Mutation / UI Re-rendering**.
   - Pas menu bawah disentuh (`onTap`), kita panggil fungsi `setState(() { _selectedIndex = index; });`. Ini nyuruh Flutter ngerender ulang layar sesuai tab yang dipilih.

---

### Langkah 5: Daftar Katalog di `HomeScreen`
> *"Menampilkan semua item wisata/produk dalam bentuk kartu-kartu rapi (kisi-kisi / grid)."*

1. **Tampilan Kartu Dinamis**:
   - Istilah teknis: **Lazy Loading / Dynamic Grid Builder**.
   - Pakai `GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2))`.
   - Mengambil data dari `destinationList` yang ada di model tadi.
2. **Bisa Diklik & Pindah Halaman Bawa Data**:
   - Istilah teknis: **Routing / Passing Arguments via Constructor**.
   - Kartunya dibungkus `InkWell` atau `GestureDetector`.
   - Pas diklik (`onTap`), kita pakai `Navigator.push(...)` dan lempar seluruh objek `item` langsung ke constructor `DetailScreen(destination: item)`.
   - *Kenapa push biasa?* Biar halaman detail ditumpuk di atas Home, sehingga otomatis ada tombol panah kembali (Back) di AppBar.

---

### Langkah 6: Rincian Lengkap di `DetailScreen`
> *"Menampilkan semua rincian dari satu item yang tadi diklik di Home."*

1. **Menerima Data Lemparan**:
   - Istilah teknis: **Widget Parameter Injection / Immutability**.
   - Diterima sebagai `final DestinationModel destination;`.
2. **Tata Letak Rapi (Layouting)**:
   - Istilah teknis: **Scrollable View & Helper Widgets**.
   - Dibungkus `SingleChildScrollView` biar kalau layarnya kekecilan tetap bisa di-scroll dan gak error overflow (garis kuning-hitam).
   - Teks dan foto disusun rapi menggunakan `Column`, `Row`, `Image.network`, dan helper method `_buildRowItem(...)` biar kodingan modular.
3. **Tombol Interaktif (Favorite/Love)**:
   - Istilah teknis: **Stateful Toggle**.
   - Pakai `setState(() { isFavorite = !isFavorite; });` buat ganti warna dan ikon love dari garis (`favorite_border`) jadi merah penuh (`favorite`).

---

### Langkah 7: Akun & Tombol Keluar di `ProfileScreen`
> *"Menampilkan identitas user yang sedang aktif dan tombol untuk keluar secara bersih (Logout)."*

1. **Menampilkan Data User**:
   - Mengambil data user berdasarkan parameter `username` yang dioper dari Root.
2. **Proses Logout (Pembersihan Tumpukan Layar)**:
   - Istilah teknis: **Clear Navigation Stack / Push and Remove Until**.
   - Tombol logout menjalankan:
     ```dart
     Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(builder: (context) => const LoginScreen()),
       (route) => false, // Artinya: buang semua history rute halaman sebelumnya
     );
     ```
   - *Kenapa harus gini?* Biar seluruh halaman (Detail, Home, Root) yang tersimpan di memori dibersihkan total. Jadi aplikasi bener-bener kembali ke titik nol di `LoginScreen`.
