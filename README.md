# Blok Wiki - Ensiklopedia Mini Minecraft

Aplikasi mobile Flutter bertema **Minecraft** untuk UTS Mobile Programming (Semester Ganjil 2025/2026).
Aplikasi ini berisi info blok, mob, item, dan biome, plus resep crafting bergaya grid 3x3.

> Proyek penggemar (fan project) untuk keperluan belajar. Minecraft adalah merek dagang Mojang/Microsoft.
> Aplikasi ini tidak memakai aset resmi; tampilan dibuat dengan widget Flutter.

## Tema dan Tujuan
Membantu pemain pemula mengenal elemen dasar Minecraft lewat tampilan bersih bergaya blok
(border tebal, bayangan keras, warna rumput/tanah/emas).

## Halaman dan Fungsinya
| Halaman | File | Fungsi |
|---|---|---|
| Beranda | `lib/screens/home_screen.dart` | Sapaan, kotak pencarian, kategori, mob populer, tips harian, item pilihan |
| Jelajah | `lib/screens/explore_screen.dart` | Daftar semua data, pencarian, filter kategori, grid responsif |
| Detail | `lib/screens/detail_screen.dart` | Deskripsi, statistik, tips, resep (jika ada), item terkait, tombol favorit |
| Crafting | `lib/screens/crafting_screen.dart` | Daftar resep crafting 3x3, ketuk hasil untuk membuka detail |

Navigasi: `BottomNavigationBar` (Beranda, Jelajah, Crafting) dan `Navigator.push` (ke Detail).

## Struktur Proyek
```
lib/
  main.dart                  titik masuk aplikasi
  models/                    MinecraftItem, Recipe (fromJson / toJson)
  services/data_service.dart pembaca data (JSON lokal, siap diganti API)
  theme/                     warna, tema, pemetaan ikon
  widgets/                   komponen reusable (PixelCard, BlockIcon, dll.)
  screens/                   halaman aplikasi
assets/data/minecraft.json   data dummy
```

## Data Dummy dan Kesiapan API
Data ada di `assets/data/minecraft.json` (20 entri dan 5 resep). Model memiliki `fromJson`,
dan seluruh akses data lewat `DataService.load()`. Untuk tahap API, ganti isi `load()` dengan
`http.get(...)` lalu `jsonDecode`; model dan UI tidak perlu diubah.
Resep terhubung ke item lewat `resultItemId`.

## Cara Menjalankan
1. Pasang Flutter SDK (versi 3.x) dan pastikan `flutter doctor` bersih.
2. Di folder proyek ini, buat folder platform (android/ios) yang belum ada:
   ```
   flutter create --project-name minecraft_wiki .
   ```
   Lalu hapus `test/widget_test.dart` bila muncul (file bawaan yang tidak dipakai).
3. Ambil dependensi:
   ```
   flutter pub get
   ```
4. Jalankan di emulator atau perangkat:
   ```
   flutter run
   ```

## Identitas
Nama: ................ | NIM: ................ | Kelas: ................
