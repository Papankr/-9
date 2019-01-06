document.addEventListener('DOMContentLoaded', function () {
    const container = document.querySelector('#explicit__container');

    if (!container) return;

    const form = container.querySelector('#explicit__form');
    const result_div = container.querySelector('#quant');
    form.addEventListener('ajax:success', function(evt) {
        const response = evt.detail[0];
        const json_obj = JSON.parse(JSON.stringify(response));
        let table = document.querySelector('#result_table');
        table.innerHTML = '<tr><th scope="col">Number</th><th scope="col">Array</th><th scope="col">Max len</th></tr>';
        if (!json_obj.key) {
            result_div.innerHTML = "<h3>" + json_obj.error + "</h3>";
        }
        else {
            for (let i=0;i<json_obj.arrlist.length; i++)
            {
                json_obj.arrlist[i].length==json_obj.maxlen ? res=true: res=false
                table.innerHTML+="<tr><th scope='row'>"+(i+1)+"</th><td>"+json_obj.arrlist[i].join(' ')+ "</td><td>"+res+"</td></tr>"
            }
            table.innerHTML+="<tr><th scope='row' id='len'>Max length "+json_obj.maxlen+"</th></tr>"

        }
        result_div.innerHTML="<h3 id='quantity'>Total quantity is "+json_obj.arrlist.length+ "</h3>"
    });
});