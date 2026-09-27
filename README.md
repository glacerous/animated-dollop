# Flutter Practical Reference (Modul 2, 3, 4)

Dokumen ini disusun murni berdasarkan materi silabus Praktikum Mobile:
- **Modul 2**: Widget Dasar (Scaffold, AppBar, Column, Row, TextField, ElevatedButton, Image.network, ListView, GridView).
- **Modul 3**: State Management Sederhana (`StatefulWidget`, `setState`, `TextEditingController`).
- **Modul 4**: Navigasi (`Navigator.push`, `Navigator.pushReplacement`, `Navigator.pushAndRemoveUntil`, `Navigator.pop`, `BottomNavigationBar`).

---

## 1. Model Data (`lib/models/data.dart`)

Struktur model murni dengan class Dart dan dummy list.

```dart
class User {
  final String username;
  final String password;
  final String name;

  User({
    required this.username,
    required this.password,
    required this.name,
  });
}

// User dummy untuk validasi login
final User defaultUser = User(
  username: "124240018",
  password: "sisteminformasi",
  name: "Mahasiswa",
);

class Product {
  final int id;
  final String name;
  final String category;
  final String description;
  final String price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
  });
}

final List<Product> products = [
  Product(
    id: 1,
    name: "Wireless Headphone",
    category: "Electronics",
    price: "750000",
    image: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500",
    description: "Wireless headphone dengan kualitas suara jernih dan baterai tahan lama.",
  ),
  Product(
    id: 2,
    name: "Smart Watch",
    category: "Electronics",
    price: "1200000",
    image: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500",
    description: "Smart watch dengan monitor detak jantung dan pelacak aktivitas.",
  ),
  Product(
    id: 3,
    name: "Running Shoes",
    category: "Sport",
    price: "600000",
    image: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500",
    description: "Sepatu lari ringan dan empuk untuk kenyamanan olahraga.",
  ),
];
```

---

## 2. Halaman Login (`lib/views/login.dart`)

Komponen:
- `TextEditingController` untuk input.
- Validasi username dan password.
- `SnackBar` feedback (hijau jika sukses, merah jika gagal).
- `Navigator.pushReplacement` ke halaman utama (`Root` atau `HomePage`).

```dart
import 'package:flutter/material.dart';
import '../models/data.dart';
import 'root.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username == defaultUser.username && password == defaultUser.password) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Root(username: username),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text("Login Berhasil"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Login Gagal. Username atau Password Salah"),
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 3. Navigasi Tab / Root (`lib/views/root.dart`)

Struktur navigasi halaman utama menggunakan `BottomNavigationBar` (materi Modul 4):
- Tab 0: Home (Daftar Data)
- Tab 1: Profile (Info Pengguna & Tombol Logout)

```dart
import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';

class Root extends StatefulWidget {
  final String username;
  const Root({super.key, required this.username});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      ProfilePage(username: widget.username),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Selamat Datang, ${widget.username}"),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
```

---

## 4. Halaman Home (`lib/views/home.dart`)

Dua alternatif tampilan daftar data sesuai soal:

### Alternatif 1: ListView.builder (Menggunakan ListTile)
```dart
import 'package:flutter/material.dart';
import '../models/data.dart';
import 'detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(product: product),
                ),
              );
            },
            leading: Image.network(
              product.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(product.name),
            subtitle: Text("Rp ${product.price}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }
}
```

### Alternatif 2: GridView.builder
```dart
import 'package:flutter/material.dart';
import '../models/data.dart';
import 'detail.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(product: product),
              ),
            );
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    product.image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("Rp ${product.price}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
```

---

## 5. Halaman Detail (`lib/views/detail.dart`)

Menerima objek melalui constructor dan menyediakan tombol kembali (`Navigator.pop`):

```dart
import 'package:flutter/material.dart';
import '../models/data.dart';

class DetailPage extends StatelessWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  product.image,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Kategori: ${product.category}",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                "Rp ${product.price}",
                style: const TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 32),
              const Text(
                "Deskripsi:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: const TextStyle(height: 1.4),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Kembali"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 6. Halaman Profile / Logout (`lib/views/profile.dart`)

Menampilkan data identitas pengguna dan tombol Logout yang menghapus seluruh tumpukan halaman (`pushAndRemoveUntil`):

```dart
import 'package:flutter/material.dart';
import 'login.dart';

class ProfilePage extends StatelessWidget {
  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              "Username: $username",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 7. Rangkuman Navigator (Modul 4)

1. **Pindah halaman baru (bisa kembali)**:
   ```dart
   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) => const DetailPage(product: item)),
   );
   ```

2. **Ganti halaman saat ini (tidak bisa kembali, misal Login ke Main)**:
   ```dart
   Navigator.pushReplacement(
     context,
     MaterialPageRoute(builder: (context) => Root(username: username)),
   );
   ```

3. **Logout / Reset seluruh route**:
   ```dart
   Navigator.pushAndRemoveUntil(
     context,
     MaterialPageRoute(builder: (context) => const LoginPage()),
     (route) => false,
   );
   ```

4. **Kembali ke halaman sebelumnya**:
   ```dart
   Navigator.pop(context);
   ```
