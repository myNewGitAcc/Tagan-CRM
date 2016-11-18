function loadChart(categories, data) {
    Highcharts.chart('hightchart', {
        title: {
            text: 'Graph',
            x: -20 //center
        },
        subtitle: {
            text: 'Your balance',
            x: -20
        },
        xAxis: {
            categories: categories
        },
        yAxis: {
            title: {
                text: 'Balance ($)'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            valueSuffix: '$'
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: [{
            name: 'Amount',
            data: data
        }]
    });
};
