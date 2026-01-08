# Tasky Note – Aplikasi Todolist dengan Flutter

Aplikasi mobile sederhana yang menyajikan **Todo List** dalam bentuk **list interaktif**.  
Aplikasi ini dikembangkan untuk memenuhi **submission akhir kelas Membuat Aplikasi Flutter untuk Pemula**, sekaligus sebagai **portofolio awal** untuk posisi **Mobile Developer (Entry-Level)**.  

Aplikasi dibangun dengan struktur yang rapi serta menerapkan praktik dasar yang umum digunakan dalam pengembangan aplikasi mobile.

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
- Menampilkan **Todo List** 
- Disusun menggunakan ListView.builder dengan tampilan bersih dan responsif.
- Menerapkan **handler click** untuk membuka detail masing-masing item.

### Halaman Detail
- Menampilkan informasi lengkap dari item yang dipilih:
  - Judul, Deskripsi detail, Tanggal dan waktu, dan Status
- Menggunakan SingleChildScrollView agar konten tetap bisa di-scroll saat layar kecil atau rotasi.
- Data ditampilkan secara konsisten dengan yang ada di halaman utama.

### Halaman Add Todo
- Form input untuk menambahkan todo baru:
  - TextField untuk judul dan deskripsi
  - DatePicker & TimePicker untuk tanggal dan waktu
- Tombol Save untuk menyimpan data todo.
- Validasi input sederhana sebelum data disimpan.
  
---

## ✨ Teknologi yang Digunakan

| Kategori              | Teknologi / Tools                     |
|-----------------------|----------------------------------------|
| Bahasa Pemrograman    | Dart                                   |
| Framework             | Flutter                                |
| Tampilan List         | ListView.builder                       |
| Navigasi              | Navigator (push / pop)                 |
| UI Responsif          | Layout Widget (Column, Row, Expanded)  |
| Scroll Konten         | SingleChildScrollView                  |

---


## Cara Menjalankan Proyek

1. Clone repositori:
   ```bash
   git clone https://github.com/taufiqurrohman132/tasky-note-flutter.git
