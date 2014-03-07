class Incumbent < ActiveRecord::Base
  self.primary_key  = "id"

  def self.find_all(params = Hash.new())
    incumbents = Array.new
    data = Incumbent.all.limit(params[:limit]).offset(params[:offset])
    data = data.where('nama like ?', "%#{params[:nama].gsub('_', ' ')}%") if params[:nama]
    data = data.where('agama like ?', "%#{params[:agama].gsub('_', ' ')}%") if params[:agama]
    data = data.where('id_partai = ?', params[:partai]) if params[:partai]
    data = data.where('id_dapil = ?', params[:dapil]) if params[:dapil]
    data = data.where('id_provinsi = ?', params[:provinsi]) if params[:provinsi]
    data = data.where('jenis_kelamin = ?', params[:jenis_kelamin]) if params[:jenis_kelamin]
    data = data.where('lembaga = ?', params[:lembaga]) if params[:lembaga]
    data = data.where('tahun = ?', params[:tahun]) if params[:tahun]
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
        nama: get_data_provinsi(self)
      },
      dapil: {
        id: self.id_dapil,
        nama: get_data_dapil(self)
      },
      partai: {
        id: self.id_partai,
        nama: get_data_partai(self)
      },
      urutan: self.urutan,
      foto_url:  self.foto_url.to_s,
      tanggal_mulai: self.foto_url.to_s,
      tanggal_akhir: self.tanggal_berakhir.to_s,
      keterangan: self.keterangan
    }
     
  end

  private
  def get_data_provinsi(field)
    return nil if field.id_provinsi.blank?
    provinsi_end = HTTParty.get("#{Rails.configuration.pemilu_api_endpoint}/candidate/api/provinsi/#{field.id_provinsi}?#{Rails.configuration.pemilu_api_key}", timeout: 500)
    provinsi = provinsi_end.parsed_response['data']['results']['provinsi'].first rescue nil
    nama_propinsi = provinsi["nama"] rescue nil
  end

  def get_data_dapil(field)
    return nil if field.id_dapil.blank?
    dapil_end = HTTParty.get("#{Rails.configuration.pemilu_api_endpoint}/candidate/api/dapil/#{field.id_dapil}?#{Rails.configuration.pemilu_api_key}", timeout: 500)
    dapil = dapil_end.parsed_response['data']['results']['dapil'].first rescue nil
    nama_dapil = dapil["nama"] rescue nil
  end

  def get_data_partai(field)
    return nil if field.id_partai.blank?
    partai_end = HTTParty.get("#{Rails.configuration.pemilu_api_endpoint}/candidate/api/partai/#{field.id_partai}?#{Rails.configuration.pemilu_api_key}", timeout: 500)
    partai = partai_end.parsed_response['data']['results']['partai'].first rescue nil
    nama_partai = partai["nama"] rescue nil
  end

end
