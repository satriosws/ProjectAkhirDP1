<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Index extends BaseController
{

    public function __construct()
    {
        parent::__construct();
        $this->load->model('M_pmb', 'm_pmb');
    }

    public function index()
    {
        $data['title'] = 'Dashboard';
        $this->render('index/index', $data);
    }

    public function pendaftarprodi1()
    {
        $data['title'] = 'Grafik Berdasarkan Prodi 1';
        $prodi = $this->m_pmb->listProdi();
        foreach ($prodi as $key => $p) {
            $prodi[$key]['jumlah'] = $this->m_pmb->jumlahPendaftarProdi1($p['id_prodi']);
            $prodi[$key]['jumlah2'] = $this->m_pmb->jumlahPendaftarProdi2($p['id_prodi']);
            $prodi[$key]['size'] = rand(10, 30);
        }

        //grafik pertama
        $result = null;
        foreach ($prodi as $p => $prod) {
            // if ($prod['jumlah'] > $sum) {
            //     $sum = $prod['jumlah'];
            //     $sliced = true;
            //     $selected = true;
            // }
            $result[$p] = [
                "name"  => $prod['nama_prodi'],
                "jumlah" => $prod['jumlah'],
                "y"     => $prod['size'],
                // "sliced" => $sliced,
                // 'selected' => $selected
            ];
        }

        $data['pendaftar'] = $prodi;
        $data['grafik1'] = json_encode($result);
        $this->render('index/grafik_satu', $data);
    }

    public function pendaftarprodi2()
    {
        $data['title'] = 'Grafik Berdasarkan Prodi 2';
        $prodi = $this->m_pmb->listProdi();
        foreach ($prodi as $key => $p) {
            $prodi[$key]['jumlah'] = $this->m_pmb->jumlahPendaftarProdi1($p['id_prodi']);
            $prodi[$key]['jumlah2'] = $this->m_pmb->jumlahPendaftarProdi2($p['id_prodi']);
            $prodi[$key]['size'] = rand(10, 30);
        }

        //grafik kedua
        $hasil = null;
        foreach ($prodi as $p => $prod) {
            $hasil[$p] = [
                "name"  => $prod['nama_prodi'],
                "jumlah" => $prod['jumlah2'],
                "y"     => $prod['size'],
                // "sliced" => $sliced,
                // 'selected' => $selected
            ];
        }

        $data['pendaftar'] = $prodi;
        $data['grafik2'] = json_encode($hasil);
        $this->render('index/grafik_dua', $data);
    }

    public function pendaftarprestasi()
    {
        $data['title'] = 'Grafik Berdasarkan Prestasi';
        $prestasi = $this->m_pmb->listPrestasi();
        foreach ($prestasi as $key => $p) {
            $prestasi[$key]['jumlah'] = $this->m_pmb->jumlahPendaftarPrestasi($p['tingkat_prestasi']);
            $prestasi[$key]['jumlah3'] = $this->m_pmb->jumlahPendaftarPrestasi($p['tingkat_prestasi']);
            $prestasi[$key]['size'] = rand(10, 30);
        }

        //grafik kedua
        $hasil = null;
        foreach ($prestasi as $p => $pres) {
            $hasil[$p] = [
                "name"  => $pres['tingkat_prestasi'],
                "jumlah" => $pres['jumlah3'],
                "y"     => $pres['size'],
                // "sliced" => $sliced,
                // 'selected' => $selected
            ];
        }

        $data['pendaftar_prestasi'] = $prestasi;
        $data['grafik3'] = json_encode($hasil);
        $this->render('index/grafik_tiga', $data);
    }

    public function pendaftarjalurmasuk()
    {
        $data['title'] = 'Grafik Berdasarkan Jalur Masuk';
        $jalurmasuk = $this->m_pmb->listJalurMasuk();
        foreach ($jalurmasuk as $key => $p) {
            $jalurmasuk[$key]['jumlah'] = $this->m_pmb->jumlahPendaftarJalurMasuk($p['id_jalur']);
            $jalurmasuk[$key]['jumlah4'] = $this->m_pmb->jumlahPendaftarJalurMasuk($p['id_jalur']);
            $jalurmasuk[$key]['size'] = rand(10, 30);
        }

        //grafik kedua
        $hasil = null;
        foreach ($jalurmasuk as $p => $jalurmas) {
            $hasil[$p] = [
                "name"  => $jalurmas['nama_jalur'],
                "jumlah" => $jalurmas['jumlah4'],
                "y"     => $jalurmas['size'],
                // "sliced" => $sliced,
                // 'selected' => $selected
            ];
        }

        $data['pendaftar'] = $jalurmasuk;
        $data['grafik4'] = json_encode($hasil);
        $this->render('index/grafik_empat', $data);
    }

    public function pendapatanpendaftaran()
    {
        $data['title'] = 'Grafik Berdasarkan Pendapatan Bank';
        $bank = $this->m_pmb->listBank();
        foreach ($bank as $key => $p) {
            $bank[$key]['jumlah'] = $this->m_pmb->jumlahPendapatanPendaftaran($p['id_bank']);
            $bank[$key]['jumlah5'] = $this->m_pmb->jumlahPendapatanPendaftaran($p['id_bank']);
            $bank[$key]['size'] = rand(10, 30);
        }

        //grafik kedua
        $hasil = null;
        foreach ($bank as $p => $ban) {
            $hasil[$p] = [
                "name"  => $ban['bank'],
                "jumlah" => $ban['jumlah5'],
                "y"     => $ban['size'],
                // "sliced" => $sliced,
                // 'selected' => $selected
            ];
        }

        $data['pendaftar'] = $bank;
        $data['grafik5'] = json_encode($hasil);
        $this->render('index/grafik_lima', $data);
    }

    public function pendaftarbayar()
    {
        $data['title'] = 'Grafik Perbandingan Pembayaran Peserta';
        $bayar = $this->m_pmb->listBayar();
        foreach ($bayar as $key => $p) {
            $bayar[$key]['jumlah'] = $this->m_pmb->jumlahPendaftarBayar($p['is_bayar']);
            $bayar[$key]['jumlah6'] = $this->m_pmb->jumlahPendaftarBayar($p['is_bayar']);
            $bayar[$key]['size'] = rand(10, 30);
        }

        //grafik kedua
        $hasil = null;
        foreach ($bayar as $p => $bay) {
            $hasil[$p] = [
                "name"  => $bay['keterangan'],
                "jumlah" => $bay['jumlah6'],
                "y"     => $bay['size'],
                // "sliced" => $sliced,
                // 'selected' => $selected
            ];
        }

        $data['pendaftar'] = $bayar;
        $data['grafik6'] = json_encode($hasil);
        $this->render('index/grafik_enam', $data);
    }
}
