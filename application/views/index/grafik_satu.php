<main class="ms-sm-auto px-md-4 bg-primary">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2"><?php echo !empty($title) ? $title : null ?></h1>
        <h3>Total Pendaftar : 1000</h3>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="pendaftar"></div>
        </div>
    </div>
</main>
<script>
    getGrafikPie('pendaftar', <?= $grafik1 ?>, 'Grafik Pendaftar Berdasarkan Prodi Pilihan 1');

    function getGrafikPie(selector, data, title) {
        Highcharts.chart(selector, {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: title
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.jumlah:.1f} Pendaftar</b>'
            },
            accessibility: {
                point: {
                    valueSuffix: '%'
                }
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                }
            },
            series: [{
                name: 'Pendaftar',
                colorByPoint: true,
                data: data
            }]
        });
    }
</script>
</main>