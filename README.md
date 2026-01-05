# Tasky Note – Aplikasi Todolist dengan Flutter

Aplikasi Mobile sederhana yang menyajikan beberapa resep masakan dalam format list interaktif. Dirancang untuk memenuhi submission akhir kelas **Memulai Pemrograman Android**, sekaligus sebagai portfolio awal untuk posisi **Android Developer (Entry-Level)**. Dibangun dengan arsitektur modern dan praktik terbaik dari industri.

---

## Tampilan Aplikasi

<table align="center">
  <tr>
    <td align="center"><strong>Home</strong></td>
    <td align="center"><strong>Add Todo</strong></td>
    <td align="center"><strong>Detail</strong></td>
  </tr>
  <tr >
    <td align="center">
      <img src="https://github.com/user-attachments/assets/f852e9d2-6601-4bb1-9993-d6b175445579" width="250" alt="Registration Page"/>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/55c87e59-d640-4c9d-9829-9999c08fa061" width="250" alt="Home Page"/>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/569ae89f-0387-4143-8775-6ed7057d2530" width="250" alt="Detail Page"/>
    </td>
  </tr>
</table>


---

## Fitur Utama

### Halaman Utama
- Menampilkan **10+ item artikel/event** dengan judul dan gambar.
- Disusun dalam **RecyclerView** dengan desain bersih dan responsif.
- Menerapkan **handler click** untuk membuka detail masing-masing item.

### Halaman Detail
- Menampilkan informasi lengkap dari item yang dipilih:
  - Gambar, Judul, dan Deskripsi detail.
- Menggunakan **ScrollView** agar konten tetap terbaca saat rotasi layar.
- Konsisten dengan data yang ditampilkan di halaman utama.

### Halaman About
- Menampilkan:
  - Foto diri
  - Nama lengkap
  - Email akun Dicoding

---

## ✨ Teknologi yang di gunakan

| Kategori             | Teknologi / Tools            |
|----------------------|------------------------------|
| Bahasa Pemrograman   | Kotlin                       |
| Tampilan List        | RecyclerView                 |
| Navigasi             | Intent                       |
| UI Responsif         | ConstraintLayout, ScrollView |
| Manajemen Resource   | Drawable, String             |
| Orientasi Support    | ScrollView Rotation-Safe     |

---


## Cara Menjalankan Proyek

1. Clone repositori:
   ```bash
   git clone https://github.com/taufiqurrohman132/Apk-ResepMakanan.git
