function urlParameters() {
    var QueryString = function () {
        // This function is anonymous, is executed immediately and
        // the return value is assigned to QueryString!
        var query_string = {};
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i=0;i<vars.length;i++) {
            var pair = vars[i].split("=");
            // If first entry with this name
            if (typeof query_string[pair[0]] === "undefined") {
                query_string[pair[0]] = decodeURIComponent(pair[1]);
                // If second entry with this name
            } else if (typeof query_string[pair[0]] === "string") {
                var arr = [ query_string[pair[0]],decodeURIComponent(pair[1]) ];
                query_string[pair[0]] = arr;
                // If third or later entry with this name
            } else {
                query_string[pair[0]].push(decodeURIComponent(pair[1]));
            }
        }
        return query_string;
    }();
    
    if (QueryString['q%5Bcreated_at_gteq%5D'] != '') {
        $('#q_created_at_gteq').val(QueryString['q%5Bcreated_at_gteq%5D'])
    }
    if (QueryString['q%5Bcreated_at_lteq%5D'] != '') {
        $('#q_created_at_lteq').val(QueryString['q%5Bcreated_at_lteq%5D'])
    }
    if (QueryString['q%5Binternal_account_id%5D'] != '') {
        $('#q_internal_account_id_eq').val(QueryString['q%5Binternal_account_id%5D'])
    }
    if (QueryString['q%5Bunit%5D'] != '') {
        if (QueryString['q%5Bunit%5D'] === 'day') {
            $('#day_checkbox').prop("checked", true );
        }
        if (QueryString['q%5Bunit%5D'] === 'week') {
            $('#week_checkbox').prop("checked", true );
        }
        if (QueryString['q%5Bunit%5D'] === 'month') {
            $('#month_checkbox').prop("checked", true );
        }
    }
}