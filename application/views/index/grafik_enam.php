<main class="ms-sm-auto px-md-4 bg-primary">
    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2"><?php echo !empty($title) ? $title : null ?></h1>
        <h3>Total Pendaftar : 648 Peserta</h3>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div id="pendaftar"></div>
        </div>
    </div>
</main>
<script>
getGrafikPie('pendaftar', <?= $grafik6 ?>,
    'Grafik Jumlah Total yang Sudah bayar dan yang Belum berdasarkan Masing-masing Bank');

function getGrafikPie(selector, data, title) {

    Highcharts.chart(selector, {
        chart: {
            type: 'column'
        },
        title: {
            text: title
        },
        xAxis: {
            categories: ['BCA', 'Mandiri', 'BRI', 'BNI']
        },
        credits: {
            enabled: false
        },
        series: [{
            name: 'Sudah',
            data: [143, 142, 143, 130]
        }, {
            name: 'Belum',
            data: [20, 29, 19, 22]
        }]
    });
}
</script>