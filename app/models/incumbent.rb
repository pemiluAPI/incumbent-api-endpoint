class Incumbent < ActiveRecord::Base
  self.primary_key  = "id"

  def self.find_all(params = Hash.new(), get_total = false)
    incumbents = Array.new
    data = (get_total) ? Incumbent.all : Incumbent.limit(params[:limit]).offset(params[:offset])
    data = data.where('nama like ?', "%#{params[:nama].gsub('_', ' ')}%") if params[:nama]
    data = data.where('agama like ?', "%#{params[:agama].gsub('_', ' ')}%") if params[:agama]
    data = data.where('id_partai = ?', params[:partai]) if params[:partai]
    data = data.where('id_dapil = ?', params[:dapil]) if params[:dapil]
    data = data.where('id_provinsi = ?', params[:provinsi]) if params[:provinsi]
    data = data.where('jenis_kelamin = ?', params[:jenis_kelamin]) if params[:jenis_kelamin]
    data = data.where('lembaga = ?', params[:lembaga]) if params[:lembaga]
    data = data.where('tahun = ?', params[:tahun]) if params[:tahun]
    return data.count if get_total
    data.each do |field|
      incumbents << field.details
    end
    incumbents
  end

  def details
    {
      id: self.id,
      tahun: self.tahun,
      lembaga: self.lembaga,
      nama: self.nama,
      jenis_kelamin: self.jenis_kelamin,
      agama: self.agama,
      tempat_lahir: self.tempat_lahir.to_s,
      tanggal_lahir: self.tanggal_lahir.to_s,
      status_perkawinan: self.status_perkawinan,
      nama_pasangan: self.nama_pasangan,
      jumlah_anak: self.jumlah_anak.to_s,
      kelurahan_tinggal: self.kelurahan_tinggal,
      kecamatan_tinggal: self.kecamatan_tinggal,
      kab_kota_tinggal: self.kab_kota_tinggal,
      provinsi_tinggal: self.provinsi_tinggal,
      provinsi: {
        id: self.id_provinsi,
        nama: self.nama_provinsi
      },
      dapil: {
        id: self.id_dapil,
        nama: self.nama_dapil
      },
      partai: {
        id: self.id_partai,
        nama: self.nama_partai
      },
      urutan: self.urutan,
      foto_url:  self.foto_url.to_s,
      tanggal_mulai: self.foto_url.to_s,
      tanggal_akhir: self.tanggal_berakhir.to_s,
      keterangan: self.keterangan
    }
  end

end
