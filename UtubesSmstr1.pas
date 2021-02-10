program TiketingParkir;
uses crt, sysutils;
const
     maks = 1000;
     namafile = 'TiketingParkir.DAT';
type
    TPark = record
                  nama:string[20];
                  noKendaraan:string[10];
                  jenisKendaraan:string[10];
                  lamaParkir:integer;
                  bayarParkir:real;
                  statusHapus:boolean;
    end;
    TParkList = array[1..maks] of TPark;

var
   tiket:TParkList;
   banyakData:integer;
   pilihanMenu:byte;
   pilihUrut:byte;
   found: boolean;
   namaCari,noCari:string;
   ulangi : char;



function index (namaCari, noCari : string) : integer;
var
   i: integer;
begin
     found:=false;
     i:=0;

     while (i<=banyakData) AND (not(found)) do
     begin
          i:=i+1;
          if(tiket[i].nama = namaCari) AND (tiket[i].noKendaraan = noCari) then
             found:=true;
     end;
     if found then
        index :=i;

end;

function searchData(namaCari, noCari : string): boolean;
var
   i:integer;
begin
     found:=false;
     namaCari:=upcase(namaCari);
     noCari:=upcase(noCari);
     i:=0;

     while (i<=banyakData) AND (not(found)) do
     begin
          i:=i+1;
          if(tiket[i].nama = namaCari) AND (tiket[i].noKendaraan = noCari) then
             found:=true;
     end;
     if found then
        searchData:=found;
end;

procedure urutAsc;
var
   i,j : integer;
   temp : TParkList;
begin
     for i:= 1 to (banyakData-1) do
     begin
          for j:=banyakData downto (i+1) do
          begin
               if pilihUrut = 1 then
               begin
                  if tiket[j].bayarParkir < tiket[j-1].bayarParkir then
                  begin
                        temp[j] := tiket[j];
                        tiket[j] := tiket[j-1];
                        tiket[j-1] := temp[j];
                   end;
                end
                   else if pilihUrut = 2 then
                   begin
                        if tiket[j].lamaParkir < tiket[j-1].lamaParkir then
                        begin
                             temp[j] := tiket[j];
                             tiket[j] := tiket[j-1];
                             tiket[j-1] := temp[j];
                        end;
                   end;
           end;
      end;
end;

procedure urutDec;
var
   i,j : integer;
   temp : TParkList;
begin
     for i:= 1 to (banyakData-1) do
     begin
          for j:=banyakData downto (i+1) do
          begin
               if pilihUrut = 1 then
                  begin
                       if tiket[j].bayarParkir > tiket[j-1].bayarParkir then
                       begin
                            temp[j] := tiket[j];
                            tiket[j] := tiket[j-1];
                            tiket[j-1] := temp[j];
                       end;
                   end
                       else if pilihUrut = 2 then
                       begin
                            if tiket[j].lamaParkir > tiket[j-1].lamaParkir then
                            begin
                                 temp[j] := tiket[j];
                                 tiket[j] := tiket[j-1];
                                 tiket[j-1] := temp[j];
                            end;
                       end;
          end;
     end;
end;

procedure tabel;
var
   i : integer;
begin
     clrscr;
     writeln('************************************* DATA HASIL PENGURUTAN ***********************************');
     writeln('                                    Jl.Kenangan mantan no.123                                  ');
     writeln('-----------------------------------------------------------------------------------------------');
     writeln('|  NO  |      NAMA       |  NOMER KENDARAAN  |  JENIS KENDARAAN  |  DURASI[jam]  |    BAYAR   |');
     writeln('-----------------------------------------------------------------------------------------------');
     for i:=1 to banyakData do
     begin
     writeln('| ',i:2,'   ',
             '| ',format('%-15s',[tiket[i].nama]),' ',
             '| ',format('%-17s',[tiket[i].noKendaraan]),' ',
             '| ',format('%-17s',[tiket[i].jenisKendaraan]),' ',
             '| ',format('%-13d',[tiket[i].lamaParkir]),' ',
             '| ',format('%-10g',[tiket[i].bayarParkir]), ' |');
     end;
     writeln('-----------------------------------------------------------------------------------------------');
end;

procedure tampilUrut;
var
   formatPilih : byte;
begin
repeat
      clrscr;
      writeln('====================================== PENGURUTAN DATA =======================================');
      writeln('----------------------------------------------------------------------------------------------');
      writeln;
      gotoxy(41,5);writeln('1.Ascending');
      gotoxy(41,6);writeln('2.Descending');
      gotoxy(40,7);write('Pilih [1/2] : ');readln(formatPilih);
      writeln;
      gotoxy(37,10);writeln('Pilih data yang diurutkan');
      gotoxy(38,11);writeln('1. Bayar Parkir');
      gotoxy(38,12);writeln('2. Lama Parkir');
      gotoxy(37,13);write('Pilihan Anda [1/2] : ');readln(pilihUrut);
           if formatPilih = 1 then
           begin
                if pilihUrut = 1 then
                begin
                     urutAsc;
                     tabel;
                end
                   else if pilihUrut = 2 then
                   begin
                        urutAsc;
                        tabel;
                   end;
           end
           else if formatPilih = 2 then
           begin
                if pilihUrut = 1 then
                begin
                     urutDec;
                     tabel;
                end
                   else if pilihUrut = 2 then
                   begin
                        urutDec;
                        tabel;
                   end;
           end;
write('Urut data kembali?[Y/N] : ');readln(ulangi);
until (upcase(ulangi) = 'N');
end;


procedure kotak;
var
   i:integer;
begin
     clrscr;
     gotoxy(29,5);write('+');
     for i:=1 to 40 do
     begin
          gotoxy(29+i,5);write('-');
     end;
     write('+');

     for i:= 1 to 14 do
     begin
          gotoxy(70,5+i);writeln('|');
     end;
     gotoxy(70,20);write('+');

     for i:=1 to 40 do
     begin
          gotoxy(29+i,20);write('-');
     end;

     for i:= 1 to 14 do
     begin
          gotoxy(29,5+i);writeln('|');
     end;
     gotoxy(29,20);write('+');
end;

procedure simpanDataKeFile;
var
   f:file of TPark;
   i:integer;
begin
     clrscr;
     kotak;
     assign(f, namafile);
     rewrite(f);
     for i:=1 to banyakData do
         write(f, tiket[i]);
     close(f);
     textcolor(green);
     gotoxy(35,12);writeln('  BERHASIL MENYIMPAN ', banyakData, ' DATA');
     gotoxy(32,13);writeln(' TEKAN ENTER UNTUK MENUTUP PROGRAM ');
     readln;
end;


procedure hapusData;
var
   i:integer;
begin
     repeat
     clrscr;
     writeln('************************************** HAPUS DATA KENDARAAN ***********************************');
     writeln('                             HAPUS BERDASARKAN NAMA DAN NO KENDARAAN                            ');
     gotoxy(35,10);write('Masukkan nama         : ');readln(namaCari);
     gotoxy(35,11);write('Masukkan no kendaraan : ');readln(noCari);
     namaCari := upcase(namaCari);
     noCari := upcase(noCari);
     i:=index(namaCari,noCari);
     if searchData(namaCari, noCari) then
     begin
          for i := index(namaCari,noCari) to banyakData - 1 do
          begin
               tiket[i]:=tiket[i+1];
          end;
          banyakData:=banyakData - 1;
          tiket[i].statusHapus := true;
          gotoxy(40,13);writeln('DATA BERHASIL DIHAPUS!!!');
     end
     else if searchData(namaCari, noCari) = false then
     begin
         gotoxy(42,13);writeln('DATA INVALID!!!');
     end;
     gotoxy(37,14);write('Hapus data kembali?[Y/N] : ');readln(ulangi);
     until (upcase(ulangi) = 'N');
end;

{function duplikasi(nama, noKendaraan : string):boolean;
var i : integer;
begin
     i:=0;
     found:=false;
     while (tiket[i].nama <> nama) or (tiket[i].noKendaraan <> noKendaraan)do
     begin
          i:=i+1;
          if (tiket[i].nama = nama) or (tiket[i].noKendaraan = noKendaraan) then
          begin
               banyakData := banyakData -1;
               found:=true;
          end
          else
               banyakData := banyakData;
     end;
     if found then
        duplikasi := found
        else
            duplikasi:=false;
end;}


procedure tambahData;
var i:integer;
begin
repeat
    clrscr;
    if banyakData < maks then
    begin
         banyakData := banyakData + 1;
         writeln('========================================== TAMBAH DATA ========================================');
         gotoxy(38,3);writeln('Penambahan data ke - ',banyakData);
         writeln;
         with tiket[banyakData] do
         begin
         //i:=index(nama, noKendaraan);
         //repeat
              write('Nama                                    : ');readln(nama);
              write('Nomer Kendaraan                         : ');readln(noKendaraan);
              noKendaraan:=upcase(noKendaraan);
              nama:=upcase(nama);
         //until (searchData(nama,noKendaraan)=true) and (tiket[i].nama <> nama) or (tiket[i].noKendaraan <> noKendaraan);
              repeat
                    write('Jenis Kendaraan [motor,mobil,truk,bus]  : ');readln(jenisKendaraan);
                    jenisKendaraan := upcase(jenisKendaraan);
              until (jenisKendaraan = 'MOTOR') or (jenisKendaraan = 'MOBIL') or (jenisKendaraan = 'TRUK') or (jenisKendaraan = 'BUS');

              write('Lama Parkir per jam                     : ');readln(lamaParkir);
              if jenisKendaraan = 'MOTOR' then
                 bayarParkir :=  2000*lamaParkir
              else if jenisKendaraan = 'MOBIL' then
                   bayarParkir := 3000*lamaParkir
              else if jenisKendaraan = 'TRUK' then
                   bayarParkir := 4000*lamaParkir
              else if jenisKendaraan = 'BUS' then
                   bayarParkir := 5000*lamaParkir;
         end;
    end
       else
           writeln('Data telah penuh.');
       gotoxy(38,11);writeln('DATA BERHASIL DI TAMBAH!!');
       gotoxy(36,12);write('Tambah data kembali?[Y/N] : ');readln(ulangi);
until (upcase(ulangi) = 'N');
end;

procedure viewData;
var
   i:integer;
begin
     clrscr;
     for i:= 1 to banyakData do
     begin
         if tiket[i].statusHapus <> false then
         begin
              writeln('********************************DATA TIKET PARKIR MALL APA ADANYA******************************');
              writeln('                                    Jl.Kenangan mantan no.123                                  ');
              writeln('-----------------------------------------------------------------------------------------------');
              writeln('|  NO  |      NAMA       |  NOMER KENDARAAN  |  JENIS KENDARAAN  |  DURASI[jam]  |    BAYAR   |');
              writeln('-----------------------------------------------------------------------------------------------');
              for i:=1 to banyakData do
              begin
                   writeln('| ',i:2,'   ',
                           '| ',format('%-15s',[tiket[i].nama]),' ',
                           '| ',format('%-17s',[tiket[i].noKendaraan]),' ',
                           '| ',format('%-17s',[tiket[i].jenisKendaraan]),' ',
                           '| ',format('%-13d',[tiket[i].lamaParkir]),' ',
                           '| ',format('%-10g',[tiket[i].bayarParkir]), ' |');
              end;
         writeln('-----------------------------------------------------------------------------------------------');
         writeln('TEKAN ENTER UNTUK KEMBALI');
         readln;
         end;
      end;

end;


procedure bacaDataDariFile;
var
   f:file of TPark;
begin
     clrscr;
     kotak;
     gotoxy(30,11);writeln('   SELAMAT DATANG DI MALL APA ADANYA   ');
     gotoxy(30,12);writeln('   Jl.Kenangan Mantan no.123 Bandung   ');
     gotoxy(30,13);writeln('       Buka Setiap Hari 7x24 Jam        ');
     gotoxy(30,14);writeln('       TEKAN ENTER UNTUK MEMULAI        ');
     assign(f, namaFile);
     {$i-}
          reset(f);
     {$i+}
     if IOResult <> 0 then
        rewrite(f);

     banyakData:=0;
     while not eof(f) do
     begin
          banyakData:=banyakData + 1;
          read(f,tiket[banyakData]);
     end;
     close(f);
     readln;
end;



procedure cariKendaraan;
var
   i:integer;
begin
     repeat
     clrscr;
     writeln('====================================== CARI DATA KENDARAAN ====================================');
     writeln('                 Pihak Mall Tidak Bertanggung Jawab Atas Kehilangan Kendaraan Anda             ');
     writeln('-----------------------------------------------------------------------------------------------');
     writeln;
     gotoxy(26,7);writeln('Cari data berdasarkan nama dan nomor kendaraan');
     gotoxy(37,9);write('Masukkan nama         : ');readln(namaCari);
     gotoxy(37,10);write('Masukkan no kendaraan : ');readln(noCari);

     namaCari:=upcase(namaCari);
     noCari:=upcase(noCari);
     i:=index(namaCari, noCari);

     if searchData(namaCari, noCari) then
     begin
          clrscr;
          writeln('================================= DATA KENDARAAN DITEMUKAN !!! ================================');
          writeln('|  NO  |      NAMA       |  NOMER KENDARAAN  |  JENIS KENDARAAN  |  DURASI[jam]  |    BAYAR   |');
          writeln('-----------------------------------------------------------------------------------------------');
               writeln('| ',i:2,'   ',
                       '| ',format('%-15s',[tiket[i].nama]),' ',
                       '| ',format('%-17s',[tiket[i].noKendaraan]),' ',
                       '| ',format('%-17s',[tiket[i].jenisKendaraan]),' ',
                       '| ',format('%-13d',[tiket[i].lamaParkir]),' ',
                       '| ',format('%-10g',[tiket[i].bayarParkir]), ' |');
          writeln('-----------------------------------------------------------------------------------------------');
     end
     else if searchData(namaCari, noCari) = false then
     begin
         gotoxy(42,12);writeln('DATA INVALID!!!');
      end;
     write('Cari data kembali?[Y/N] : ');readln(ulangi);
     until (upcase(ulangi) = 'N');
end;

procedure editData;
var
   i:integer;
begin
     repeat
     clrscr;
     writeln('========================================== EDIT DATA ==========================================');
     writeln('                                EDIT DATA SESUAI DENGAN KRITERIA                               ');
     writeln('-----------------------------------------------------------------------------------------------');
     writeln;
     gotoxy(21,8);writeln('ISI DATA MANA YANG MAU DIUBAH MENGGUNAKAN NAMA DAN NOMOR');
     gotoxy(35,10);write('Masukkan nama         : ');readln(namaCari);
     gotoxy(35,11);write('Masukkan no kendaraan : ');readln(noCari);
     namaCari:=upcase(namaCari);
     noCari:=upcase(noCari);
     i:=index(namaCari, noCari);

     if searchData(namaCari, noCari) then
     begin
          clrscr;
          writeln('================================= DATA KENDARAAN DIUBAH !!! ===================================');
          writeln('                                     SILAHKAN EDIT DATANYA                                     ');
          writeln('-----------------------------------------------------------------------------------------------');
          with tiket[i] do
          begin
          write('Masukkan Nama Pengguna                          : ');readln(nama);
          write('Masukkan No Kendaraan                           : ');readln(noKendaraan);
          write('Masukkan Jenis Kendaraan [motor,mobil,truk,bus] : ');readln(jenisKendaraan);
          write('Masukkan Durasi[jam]                            : ');readln(lamaParkir);
          nama:=upcase(nama);
          noKendaraan:=upcase(noKendaraan);
          jenisKendaraan:=upcase(jenisKendaraan);
          if  jenisKendaraan = 'MOTOR' then
                 bayarParkir :=  2000*lamaParkir
              else if jenisKendaraan = 'MOBIL' then
                 bayarParkir := 3000*lamaParkir
              else if jenisKendaraan = 'TRUK' then
                 bayarParkir := 4000*lamaParkir
              else if jenisKendaraan = 'BUS' then
                  bayarParkir := 5000*lamaParkir;
          writeln('Bayar Parkir Anda Yang Baru               : ', bayarParkir:0:0);
          end;
          writeln('==================================== DATA BERHASIL DIUBAH !!! =================================');
          writeln('-----------------------------------------------------------------------------------------------');
     end
     else if searchData(namaCari, noCari) = false then
         begin
              gotoxy(40,13);writeln('DATA INVALID!!!');
         end;
     write('Edit data kembali?[Y/N] : ');readln(ulangi);
     until (upcase(ulangi) = 'N');
end;


begin
     textcolor(11);
     banyakData:=0;
     bacaDataDariFile;
     repeat
           clrscr;
           writeln('=================================== PROGRAM TIKETING PARKIR ===================================');
           writeln('                                        MALL APA ADANYA                                        ');
           writeln('                               Jl.Kenangan mantan no.123 Bandung                               ');
           writeln('===============================================================================================');
           writeln;
           gotoxy(40,8);writeln('1. Penambahan Data');
           gotoxy(40,9);writeln('2. View Data');
           gotoxy(40,10);writeln('3. Hapus Data Perorang');
           gotoxy(40,11);writeln('4. Edit Data');
           gotoxy(40,12);writeln('5. Cari Data');
           gotoxy(40,13);writeln('6. Urutkan Data');
           gotoxy(40,14);writeln('0. Keluar dari Aplikasi');
           gotoxy(40,15);write('Pilihan Anda : ');readln(pilihanMenu);
           case pilihanMenu of
                1: tambahData;
                2: viewData;
                3: hapusData;
                4: editData;
                5: cariKendaraan;
                6: tampilUrut;
           end;
      until pilihanMenu = 0;
      simpanDataKeFile;
end.
