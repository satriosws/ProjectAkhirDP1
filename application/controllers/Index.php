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
        $pendaftar = $this->m_pmb->jumlahPendaftarPrestasi();
        // echo $this->db->last_query();
        // die;
        $grafik = null;
        $sumtotal = 0;
        foreach ($pendaftar as $key => $value) {
            $sumtotal += $value['jumlah'];
            $grafik[$key] = [
                'name' => $value['tingkat_prestasi'],
                'jumlah' => intval($value['jumlah']),
                'y' => intval($value['jumlah']),
            ];
        }

        $data['subtitle'] = 'Jumlah Pendaftar:' . $sumtotal;
        $data['grafik'] = json_encode($grafik);
        $this->render('index/grafik_tiga', $data);
    }

    public function pendaftarJalurMasuk()
    {
        $data['title'] = 'Grafik Berdasarkan Jalur Masuk';
        $pendaftar = $this->m_pmb->jumlahPendaftarJalurMasuk();
        // echo $this->db->last_query();
        // die;
        $grafik = null;
        $sumtotal = 0;
        foreach ($pendaftar as $key => $value) {
            $sumtotal += $value['jumlah'];
            $grafik[$key] = [
                'name' => $value['nama_jalur'],
                'jumlah' => intval($value['jumlah']),
                'y' => intval($value['jumlah']),
            ];
        }

        $data['subtitle'] = 'Jumlah Pendaftar:' . $sumtotal;
        $data['grafik'] = json_encode($grafik);
        $this->render('index/grafik_empat', $data);
    }

    public function pendapatanbank()
    {
        $data['title'] = 'Grafik Pendapatan Dari Masing-masing Bank';
        $pndtbank = $this->m_pmb->listBank();
        foreach ($pndtbank as $key => $bnk) {
            $pndtbank[$key]['jumlah5'] = $this->m_pmb->jumlahPendapatanBank($bnk['id_bank']);
            $pndtbank[$key]['size'] = rand(10, 30);
        }

        //grafik kelima
        $hasil = null;
        foreach ($pndtbank as $bnk => $bnka) {
            $hasil[$bnk] = [
                "name"  => $bnka['nama_bank'],
                "jumlah" => $bnka['jumlah5'],
                "y"     => $bnka['size'],
                // "sliced" => $sliced,
                // 'selected' => $selected
            ];
        }

        $data['pendaftar'] = $pndtbank;
        $data['grafik5'] = json_encode($hasil);
        $this->render('index/grafik_lima', $data);
    }

    public function jumlahyangbayarbelum()
    {
        $data['title'] = 'Grafik Status Pembayaran Bank';
        $jumlahspbank = $this->m_pmb->listBank();
        foreach ($jumlahspbank as $key => $jsp) {
            $jumlahspbank[$key]['jumlah6'] = $this->m_pmb->jumlahSPBank($jsp['id_bank']);
            $jumlahspbank[$key]['size'] = rand(10, 30);
        }

        //grafik keenam
        $hasil = null;
        foreach ($jumlahspbank as $jsp => $jp) {
            $hasil[$jsp] = [
                "name"  => $jp['nama_bank'],
                "jumlah" => $jp['jumlah6'],
                "y"     => $jp['size'],
                // "sliced" => $sliced,
                // 'selected' => $selected
            ];
        }

        $data['pendaftar'] = $jumlahspbank;
        $data['grafik6'] = json_encode($hasil);
        $this->render('index/grafik_enam', $data);
    }
}
