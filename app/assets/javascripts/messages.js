//= require jquery
//= require jquery_ujs


$(function() {
    var faye = new Faye.Client('http://localhost:9292/faye');
    faye.setHeader("Access-Control-Allow-Origin", "http://localhost:3000");
    faye.subscribe("/messages/new", function(data) {
        console.log(data)
        eval(data);
    });
});