<!DOCTYPE html>
<html>
    <!-- FAVICON -->
    <link rel="icon" href="https://cdn4.iconfinder.com/data/icons/single-width-stroke/24/oui-icons-40-128.png" type="image/x-icon" />
    <title>Hive Queries</title>
    <!-- VIEWPORT -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- GOOGLE FONTS -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
    <!-- FONT AWESOME -->
    <link rel="stylesheet" 
          href="https://opensource.keycdn.com/fontawesome/4.7.0/font-awesome.min.css" 
          integrity="sha384-dNpIIXE8U05kAbPhy3G1cz+yZmTzA6CY8Vg/u2L9xRnHjJiAK76m2BIEaSEV+/aU" 
          crossorigin="anonymous" />
    <!-- STYLES -->
    <style type="text/css">
        html, body{
            background: #EEE;            
            font-family: 'Open Sans', sans-serif;
        }
        button{
            background: transparent;
            border: 2px solid cornflowerblue;
            border-radius: 3px;
            color: cornflowerblue;
            cursor: pointer;
            width: 100px;
        }
        button, input, select{            
            font-family: 'Open Sans', sans-serif;
        }
        button:hover{
            font-weight: bolder;
        }        
        label{
            margin: 0 5px;
        }
        table{
            width: 100%;
        }
        td{
            color: #222;
        }
        td,th{
            font-size: 10px;
            padding: 3px;
        }
        tr:hover{
            cursor: pointer;            
        }
        body > div:nth-child(1){ 
            display: flex;
            flex-wrap: wrap;
            margin-bottom: 10px;
        }  
        body > div:nth-child(1) > div{    
            display: flex;
            width: 100%;
        }
        body > div:nth-child(1) > div, button{
            margin: 10px;
        } 
        body > div:nth-child(1) > div > div{ 
            align-items: flex-start;
            display: flex;
            font-size: 10px;
        }
        body > div:nth-child(1) > div div input:disabled{ 
            text-align: center;
            width: 120px;
        }
        body > div:nth-child(1) > div .select div:first-child, body > div:nth-child(1) > div .insert div:nth-child(2){ 
            border: 1px solid lightgray;
            display: flex;
            flex-direction: column;
            padding: 0 10px 5px 0;
        }
        body > div:nth-child(1) > div select{ 
            background: white;
            height: 21px;
        }
        body > div:nth-child(1) > div select:first-child, body > div:nth-child(1) > div .insert div:first-child input{ 
            margin-right: 5px;
        }
        body > div:nth-child(1) > div .insert div:first-child label, body > div:nth-child(1) > div .delete div label:first-child{ 
            margin-left: 0;
        }
        body > div:nth-child(1) > div .update select{ 
            margin-right: 0;
        }
        body > div:nth-child(2) > div{
            align-items: center;      
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            min-height: 300px;
            overflow-x: auto;
        }
        body > div:nth-child(2) > div i{            
            margin-right: 10px;
        }
        body > div:nth-child(2) > div h6{    
            align-self: flex-end;
            border: 1px solid #222;
            color: #222;
            margin: 2px;
            padding: 5px;
            width: 98%;
        }
        body > div:nth-child(1), body > div:nth-child(2) > div{   
            border: 1px solid gray;
            background: white;
        }
        body > div:nth-child(2) > div, button:hover, th, tr:hover{
            background: cornflowerblue;
        }
        body > div:nth-child(2) > div, button:hover, th, tr:hover td{            
            color: white;
        }
    </style>
    <body>
        <div>   
            <div>
                <select>
                    <option>SELECT</option>
                    <option>INSERT</option>
                    <option>UPDATE</option>
                    <option>DELETE</option>
                </select>
                <div id="q" class="select"></div>            
            </div>
            <button><i class="fa fa-terminal" aria-hidden="true"></i> EXECUTE</button>
        </div>        
        <div>
            <div id="spinner">           
                <i class="fa fa-database fa-2x fa-fw" aria-hidden="true"></i>
                <h3>EJECUTA UNA CONSULTA</h3>
            </div>          
        </div>
        <!-- SCRIPTS -->
        <script type="text/javascript">
            window.onload = function () {
                // variables
                var request = new XMLHttpRequest();
                var spn = document.getElementById('spinner');
                var q = document.getElementById('q');
                var columns = ['ip_start', 'ip_end', 'country', 'stateprov', 'district',
                    'city', 'zipcode', 'latitude', 'longitude', 'geoname_id', 'timezone_offset',
                    'timezone_type', 'isp_name', 'connection_type', 'organization_name'];
                var queryType = '';
                // al cargar la pagina se cargara se llamara a la funcion loadQuery()
                loadQuery();
                // cuando la opcion del select se cambien se llamara a la funcion changeQuery()
                document.querySelector('select').onchange = function () {
                    loadQuery();
                };
                // al pulsar el boton se creara el metodo y la ruta del request con
                //    la funcion getRequest(), se abrira el request, se mostrara la
                //    pantalla de cargando y se enviara la request
                document.querySelector('button').onclick = function () {
                    spn.style.background = 'cornflowerblue';
                    spn.style.alignItems = 'center';
                    spn.innerHTML = '<i class="fa fa-cog fa-spin fa-3x fa-fw"></i>'
                            + '<h3>CARGANDO DATOS ... </h3>';
                    var req = getRequest();
                    console.log('REQUEST => ' + req);
                    request.open(req[0], req[1]);
                    request.send();
                };
                // cuando se cambie el ready state es cargaran los datos en base al tipo
                //    de query que se ha realizado
                request.onreadystatechange = function () {
                    if (request.readyState === 4) {
                        if (request.status === 200) {
                            var ipGeo = JSON.parse(request.responseText);
                            console.log(ipGeo);
                            var datos = '';
                            switch (queryType) {
                                case 'SELECT':
                                    if (ipGeo.length !== 0) {
                                        datos = '<table><tr>';
                                        for (var key in ipGeo[0]) {
                                            datos += '<th>' + key + '</th>';
                                        }
                                        datos += '</tr>';
                                        for (var i = 0; i < ipGeo.length; i++) {
                                            datos += '<tr>';
                                            for (var key in ipGeo[i]) {
                                                datos += '<td>' + ipGeo[i][key] + '</td>';
                                            }
                                            datos += '</tr>';
                                        }
                                        datos += '</table>';
                                        datos += '<h6>NUMERO DE REGISTROS: ' + ipGeo.length + '</h6>';
                                        spn.style.background = 'white';
                                        spn.style.alignItems = 'flex-start';
                                    } else {
                                        datos = '<h3 style="color:red;">NO SE HA ENCONTRADO NINGUN REGISTRO</h3>'
                                                + '<i style="color:red;" class="fa fa-exclamation-triangle" aria-hidden="true"></i>';
                                    }
                                    break;
                                case 'INSERT':
                                    datos = '<i class="fa fa-plus-square-o fa-3x" aria-hidden="true"></i>'
                                            + '<h3>EL REGISTRO SE HA INTRODUCIDO CORRECTAMENTE</h3>';
                                    break;
                                case 'DELETE':
                                    datos = '<i class="fa fa-trash-o fa-3x" aria-hidden="true"></i>'
                                            + '<h3>EL REGISTRO SE HA ELIMINADO CORRECTAMENTE</h3>';
                                    break;
                                case 'UPDATE':
                                    datos = '<i class="fa fa-pencil-square-o fa-3x" aria-hidden="true"></i>'
                                            + '<h3>EL REGISTRO SE HA ACTUALIZADO CORRECTAMENTE</h3>';
                                    break;
                            }
                        } else {
                            datos = '<h3>HA OCURRIDO UN ERROR DURANTE LA PETICION</h3>'
                                    + '<h4 style="text-align:center;">' + request.status + ' ' + request.statusText + '</h4>'
                                    + '<i class="fa fa-window-close-o fa-3x" aria-hidden="true"></i>';
                        }
                        spn.innerHTML = datos;
                    }
                };
                // funcion para cargar el formato correspondiente a la opcion de la query que se quiera realizar
                function loadQuery() {
                    s = '';
                    switch (document.querySelector('select').value) {
                        case 'SELECT':
                            s += '<div>';
                            for (var i = 0; i < columns.length; i++) {
                                s += '<span><input type="checkbox" value=' + columns[i] + ' checked>' + columns[i] + '</span>';
                            }
                            s += '</div>'
                                    + '<div>'
                                    + '<label>FROM</label>'
                                    + '<input type="text" value="ip_geolocation_orc" disabled>'
                                    + '<label>WHERE</label>'
                                    + '<input type="text">'
                                    + '<label>ORDER BY</label>'
                                    + '<select>';
                            for (var i = 0; i < columns.length; i++) {
                                s += '<option>' + columns[i] + '</option>';
                            }
                            s += '</select>'
                                    + '<label>LIMIT</label>'
                                    + '<input type="number" min="1" max="100" value="10">'
                                    + '</div>';
                            q.className = 'select';
                            break;
                        case 'INSERT':
                            s += '<div>'
                                    + '<label>INTO</label>'
                                    + '<input type="text" value="ip_geolocation_orc" disabled>'
                                    + '</div>'
                                    + '<div>';
                            for (var i = 0; i < columns.length; i++) {
                                s += '<span><input type="checkbox" value=' + columns[i] + '>' + columns[i] + '</span>';
                            }
                            s += '</div>'
                                    + '<div>'
                                    + '<label>VALUES</label>'
                                    + '<input type="text">'
                                    + '</div>';
                            q.className = 'insert';
                            break;
                        case 'UPDATE':
                            s += '<div>'
                                    + '<input type="text" value="ip_geolocation_orc" disabled>'
                                    + '<label>SET</label>'
                                    + '</div>'
                                    + '<div>'
                                    + '<select>';
                            for (var i = 0; i < columns.length; i++) {
                                s += '<option>' + columns[i] + '</option>';
                            }
                            s += '</select>'
                                    + '</div>'
                                    + '<div>'
                                    + '<label>=</label>'
                                    + '<input type="text">'
                                    + '<label>WHERE</label>'
                                    + '<input type="text">'
                                    + '</div>';
                            q.className = 'update';
                            break;
                        case 'DELETE':
                            s += '<div>'
                                    + '<label>FROM</label>'
                                    + '<input type="text" value="ip_geolocation_orc" disabled>'
                                    + '<label>WHERE</label>'
                                    + '<input type="text">'
                                    + '</div>';
                            q.className = 'delete';
                            break;
                    }
                    q.innerHTML = s;
                }
                // funcion para crear el metodo y la ruta para el request en base a la query
                //    que se este realizando
                function getRequest() {
                    var path = '';
                    var method = '';
                    var query = '';
                    queryType = document.querySelector('select').value;
                    switch (queryType) {
                    case 'SELECT':
                            method = 'GET';
                            path = 'ips/';
                            query += document.querySelectorAll('select')[0].value + ' * '
                            + document.getElementsByTagName('label')[0].innerText + ' '
                            + document.querySelectorAll('input[type=text]')[0].value + ' ';
                            if (document.querySelectorAll('input[type=text]')[1].value !== '') {
                                query += document.getElementsByTagName('label')[1].innerText + ' '
                                        + document.querySelectorAll('input[type=text]')[1].value + ' ';
                            }
                            query += document.getElementsByTagName('label')[2].innerText + ' '
                            + document.querySelectorAll('select')[1].value + ' '
                            + document.getElementsByTagName('label')[3].innerText + ' '
                    + document.querySelector('input[type=number]').value;
                            break;
                            case 'INSERT':
                            method = 'POST';
                    path = 'ips/';
                    query += document.querySelector('select').value + ' '
                            + document.getElementsByTagName('label')[0].innerText + ' '
                            + document.querySelectorAll('input[type=text]')[0].value + '(';
                    var chk = document.querySelectorAll('input:checked');
                    var chks = '';
                    for (var i = 0; i < chk.length; i++) {
                        chks += chk[i].value + ',';
                    }
                    query += chks.slice(0, -1) + ') ' + document.getElementsByTagName('label')[1].innerText
                    + '(' + document.querySelectorAll('input[type=text]')[1].value + ')';
                            break;
                            case 'UPDATE':
                            method = 'PUT';
                    path = 'ips/';
                    query += document.querySelectorAll('select')[0].value + ' '
                            + document.querySelectorAll('input[type=text]')[0].value + ' '
                            + document.getElementsByTagName('label')[0].innerText + ' '
                            + document.querySelectorAll('select')[1].value + ' '
                            + document.getElementsByTagName('label')[1].innerText + ' '
                            + document.querySelectorAll('input[type=text]')[1].value + ' '
                            + document.getElementsByTagName('label')[2].innerText + ' '
                    + document.querySelectorAll('input[type=text]')[2].value;
                            break;
                            case 'DELETE':
                            method = 'DELETE';
                    path = 'ips/';
                    query += document.querySelector('select').value + ' '
                            + document.getElementsByTagName('label')[0].innerText + ' '
                            + document.querySelectorAll('input[type=text]')[0].value + ' '
                            + document.getElementsByTagName('label')[1].innerText + ' '
                    + document.querySelectorAll('input[type=text]')[1].value;
                            break;
                }
                var url = 'http://localhost:8080/' + path + query;
                var req = [method, url];
                return req;
                }
            };
        </script>
    </body>
</html>