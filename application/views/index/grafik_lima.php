<main class="ms-sm-auto px-md-4 bg-primary">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2"><?php echo !empty($title) ? $title : null ?></h1>
        <h3>Total Bayar : Rp. 97200000</h3>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="pendaftar"></div>
        </div>
    </div>
</main>
<script>
getGrafikPie('pendaftar', <?= $grafik5 ?>, 'Grafik Pendaftar Berdasarkan Pendapatan Masing-masing Bank');

function getGrafikPie(selector, data, title) {
    var bca = 24450000;
    var mandiri = 25650000;
    var bni = 22800000;
    var bri = 24300000;

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
            pointFormat: '{series.name}: <b>{point.jumlah:.1f} Hasil Pendapatan </b>'
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
            name: 'Pendapatan',
            colorByPoint: true,
            data: [{
                name: 'BCA',
                jumlah: bca,
                y: Math.floor(Math.random() * 30) + 1,
            }, {
                name: 'Mandiri',
                jumlah: mandiri,
                y: Math.floor(Math.random() * 30) + 1,
            }, {
                name: 'BNI',
                jumlah: bni,
                y: Math.floor(Math.random() * 30) + 1,
            }, {
                name: 'BRI',
                jumlah: bri,
                y: Math.floor(Math.random() * 30) + 1,
            }],
        }]
    });
}
</script>