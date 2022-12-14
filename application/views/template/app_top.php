<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Satro wicaksono">
    <title><?= APP_NAME . ' &mdash; By:' . AUTHOR_NAME  ?></title>
    <link href="<?= base_url('public') ?>/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<?= base_url('public') ?>/lib/highchart/code/css/highcharts.css" rel="stylesheet">

    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }

        .b-example-divider {
            height: 3rem;
            background-color: rgba(0, 0, 0, .1);
            border: solid rgba(0, 0, 0, .15);
            border-width: 1px 0;
            box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
        }

        .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 100vh;
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }

        .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
        }

        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }
    </style>
    <!-- Custom styles for this template -->
    <link href="<?= base_url('public') ?>/dashboard/dashboard.css" rel="stylesheet">
    </head>

<body>
    <div class="container-fluid">
        <div class="row">
        <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
        <div class="container-fluid">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link active " aria-current="page" href="<?= site_url('index') ?>">
                                <span data-feather="home" class="align-text-white"></span>
                                Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link " href="<?= site_url('index/pendaftarprodi1') ?>">
                                <span data-feather="pie-chart" class="align-text-bottom"></span>
                                Pendaftar Prodi 1
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<?= site_url('index/pendaftarprodi2') ?>">
                                <span data-feather="pie-chart" class="align-text-bottom"></span>
                                Pendaftar Prodi 2
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<?= site_url('index/pendaftarprestasi') ?>">
                                <span data-feather="pie-chart" class="align-text-bottom"></span>
                                Pendaftar Berdasarkan Prestasi
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<?= site_url('index/pendaftarjalurmasuk') ?>">
                                <span data-feather="pie-chart" class="align-text-bottom"></span>
                                Pendaftar Berdasarkan Jalur Masuk
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<?= site_url('index/pendapatanbank') ?>">
                                <span data-feather="pie-chart" class="align-text-bottom"></span>
                                Pendapatan Berdasarkan Bank
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<?= site_url('index/jumlahyangbayarbelum') ?>">
                                <span data-feather="pie-chart" class="align-text-bottom"></span>
                                Perbandingan Pembayaran Peserta
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>