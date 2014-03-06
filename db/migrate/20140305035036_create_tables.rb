class CreateTables < ActiveRecord::Migration
  def change
    create_table :incumbents, :id => false, :primary_key => :id  do |t|
      t.string  :id, :null => false, :limit => 25
      t.string  :lembaga
      t.integer :tahun
      t.integer :id_provinsi
      t.string  :nama_provinsi
      t.string  :id_dapil
      t.string  :nama_dapil
      t.integer :id_partai
      t.string  :nama_partai
      t.integer :urutan
      t.string  :nama
      t.string  :jenis_kelamin
      t.string  :agama
      t.date    :tempat_lahir
      t.date    :tanggal_lahir
      t.string  :status_perkawinan
      t.string  :nama_pasangan
      t.integer :jumlah_anak
      t.string  :kelurahan_tinggal
      t.string  :kecamatan_tinggal
      t.string  :kab_kota_tinggal
      t.string  :provinsi_tinggal
      t.string  :foto_url
      t.date    :tanggal_mulai
      t.date    :tanggal_berakhir
      t.text    :keterangan
      t.timestamps
    end

    
  end
end
