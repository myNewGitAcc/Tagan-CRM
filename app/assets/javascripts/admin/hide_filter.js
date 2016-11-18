$( document ).ready(function() {
    $('.filter-is-visible').on( "click", function() {
        $('#sidebar').toggleClass('hide-filter');
        $('.filter-is-visible').toggleClass('filter-is-hidden');
        $('#main_content').toggleClass('advanced-chart');
        $('.highcharts-container').removeAttr('style').toggleClass('highcharts-container-width');
        $('.highcharts-root').animate({
            width: "100%",
            height: '100%',
            opacity: 1
        }, 500);
    });
});