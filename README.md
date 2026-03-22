# SISOP-1-2026-IT-044

## SOAL 1
### Deskripsi Soal
Membuat `awk` yang dapat menganalisis data `passenger.csv` yaitu:
* `a`: Jumlah seluruh penumpang
* `b`: Jumlah gerbong penumpang
* `c`: Data penumpang tertua
* `d`: Rata-rata usia penumpang
* `e`: Jumlah penumpang _business class_ 

### Pengerjaan
**1. BEGIN**
```awk
BEGIN {
    FS = ","
    mode = ARGV[2]
    delete ARGV[2]
}
```
- `FS = ","` → set pemisah kolom menjadi koma karena file CSV
- `ARGV[2]` → mengambil argumen ketiga dari command line (a/b/c/d/e)
- `delete ARGV[2]` → menghapus argumen tersebut dari ARGV agar tidak terbaca sebagai nama file

**2. Membaca Data**
```awk
NR == 1 { next }
{
    nama    = $1
    usia    = $2
    kelas   = $3
    gerbong = $4
}
```
- `NR == 1 { next }` → skip baris pertama (header)
- `$1, $2, $3, $4` → kolom-kolom CSV sesuai urutannya

**3. Sub soal**
* (a) Total Penumpang
  ```awk
  count_passenger++
  ```
	Counter yang bertambah 1 setiap baris data dibaca.

* (b) Jumlah gerbong
	```awk
	gerbong_list[gerbong] = 1
	```
	Menggunakan array asosiatif dengan key = nama gerbong. Jika gerbong  yang sama muncul lagi, nilainya tetap 1 sehingga tidak terhitung dobel. Di END, jumlah key dihitung dengan `for (g in gerbong_list) carriage++`.
* (c) Penumpang tertua
  ```awk
	if (NR == 2 || usia > max_usia) {
	    max_usia = usia
  	  oldest = nama
	}
	```
	- `NR == 2` → inisialisasi di baris data pertama
	- Setiap menemukan usia lebih besar, `max_usia` dan `oldest` diupdate
* (d) Rata-rata usia
  ```awk
	total_usia += usia

	di END:
	average_age = int(total_usia / count_passenger)
	```
	- Menjumlahkan seluruh usia setiap baris dibaca
	- `int()` untuk membulatkan hasil tanpa angka di belakang koma
* (e) Business class
  ```awk
	if (kelas == "Business") {
  	  business_passenger++
	}
	```
	Memfilter baris yang kolom ketiga (`$3`) bernilai "Business".

**4. Opsi Tidak Valid**

Jika user memasukkan opsi selain a/b/c/d/e, program menampilkan pesan error beserta contoh penggunaan yang benar.
```awk
} else {
    print "Soal tidak dikenali. Gunakan a, b, c, d, atau e."
    print "Contoh penggunaan: awk -f file.sh data.csv a"
}
```

### Output


