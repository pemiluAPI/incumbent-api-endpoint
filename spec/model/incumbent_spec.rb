require 'spec_helper'

describe Incumbent do
  before (:each) do
    @incumbent = create(:incumbent)
  end

  it "should return all Incumbents" do
     @incumbent = create(:incumbent, :id => "002")
     Incumbent.find_all.count.should == 2
  end

  it "should details of Incumbent" do
     @incumbent.details.should == details
  end

  def details
    {
      id: "DPD001",
      tahun: 2009,
      lembaga: "DPD",
      nama: "Tgk. Abdurrahman",
      jenis_kelamin: "L",
      agama: "Islam",
      tempat_lahir: "",
      tanggal_lahir: "1962-06-19",
      status_perkawinan: "Kawin",
      nama_pasangan: nil,
      jumlah_anak: "",
      kelurahan_tinggal: nil,
      kecamatan_tinggal: nil,
      kab_kota_tinggal: nil,
      provinsi_tinggal: nil,
      provinsi: {
        id: 11,
        nama: "ACEH"
      },
      dapil: {
        id: "1100-00-0000",
        nama: "ACEH"
      },
      partai: {
        id: nil,
        nama: nil
      },
      urutan: 1,
      foto_url:  "",
      tanggal_mulai: "",
      tanggal_akhir: "",
      keterangan: nil
    }
  end
end
