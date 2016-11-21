function changeChart(categories, data) {
    $('#sidebar').toggleClass('hide-filter');
    $('.filter-is-visible').toggleClass('filter-is-hidden');
    $('#main_content').toggleClass('advanced-chart');
    $('.highcharts-container').removeAttr('style').toggleClass('highcharts-container-width');
    $('.highcharts-root').toggleClass('hightchart-root-widht');
    loadChart(categories, data);
}