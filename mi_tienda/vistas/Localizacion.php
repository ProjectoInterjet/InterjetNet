<?php
//activamos almacenamiento en el buffer
ob_start();
session_start();
if (!isset($_SESSION['nombre'])) {
  header("Location: login.html");
}else{
require 'header.php';

if ($_SESSION['ubicacion']==1) {

 ?>
    <div class="content-wrapper">
    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
      <div class="row">
        <div class="col-md-12">
      <div class="box">
<div class="box-header with-border">
  <h1 class="box-title">Ubicación</h1> <a href="https://app.tracking.here.com/workspace/devices"> <button class="btn btn-info">Consultar ubicación de mi paquete</button></a></h1>
  <div class="box-tools pull-right">
    
  
  </div>
</div>
<!--box-headercomienza el mapa--> 
<!--centro-->
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/master.css">
      
       <meta name="viewport" content="initial-scale=1.0,width=device-width" />
        <script src="https://js.api.here.com/v3/3.1/mapsjs-core.js" type="text/javascript" charset="utf-8"></script>
        <script src="https://js.api.here.com/v3/3.1/mapsjs-service.js" type="text/javascript" charset="utf-8"></script>
        <script src="https://js.api.here.com/v3/3.1/mapsjs-ui.js" type="text/javascript" charset="utf-8"></script>
        <link rel="stylesheet" type="text/css" href="https://js.api.here.com/v3/3.1/mapsjs-ui.css" />
        <script src="https://js.api.here.com/v3/3.1/mapsjs-mapevents.js"
       type="text/javascript" charset="utf-8"></script>

       <script
  src="https://code.jquery.com/jquery-3.2.1.js"
  integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
  crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
  </head>
    <body>
        <div class="container">
            <div class="h1"> Ubicación actual</div>
            <div style="width: 70vw; height: 70vh" id="map"></div>    
            <input type="text"  id="iteraciones">



            

        <!--Aqui llegaran las coordenadas-->
    <input type="text"  id="Latitud_input" placeholder="Latitud" value="20.47841">
    <input type="text"  id="Longitud_input" placeholder="Longitud" value="-99.21697">
        <!--Script mapa Here-->
     <script type="text/javascript" charset="utf-8">
        //se inicia el objeto
        var platform = new H.service.Platform({
        'apikey': 'YStmyVlw-uk4mOTHM8KZ20X12gCY8DUteOmqI0q0qwU'
        });
        // se cargan los mapas por default
        var defaultLayers = platform.createDefaultLayers();
        // se inicia el mapa en el elmento donde se colocara
        var map = new H.Map(
        document.getElementById('map'),
        defaultLayers.vector.normal.map,
        {
            zoom: 15,
            center: { lng:-99.21697, lat: 20.47841 }
        });
        // Ae crean las capas y se ponen en español:
        var ui = H.ui.UI.createDefault(map, defaultLayers, 'es-ES');
        var mapEvents = new H.mapevents.MapEvents(map);
        // Se agrega la funcion para hacer el mapa interactivo
        map.addEventListener('tap', function(evt) {
        // se carga el evento de mosue y tap
        console.log(evt.type, evt.currentPointer.type); 
        });
        //se inician los eventos
        var behavior = new H.mapevents.Behavior(mapEvents);
        //se carga la Latitud de la ubicación del usuario
    function geolocaliza1(){
        var Latitud = document.getElementById('Latitud_input').value;
        return Latitud;
        }
        //Se carga la longitud de la ubicación del usuario
    function geolocaliza2(){
        var Longitud = document.getElementById('Longitud_input').value;
        return Longitud;
        }  
     //Se crea el icono que utilizaremos para marcar la ubicación
        var animatedSvg =
        '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" x="0px" ' + 
        'y="0px" style="margin:-112px 0 0 -32px" width="136px"' + 
        'height="150px" viewBox="0 0 136 150"><ellipse fill="#000" ' +
        'cx="32" cy="128" rx="36" ry="4"><animate attributeName="cx" ' + 
        'from="32" to="32" begin="0s" dur="1.5s" values="96;32;96" ' + 
        'keySplines=".6 .1 .8 .1; .1 .8 .1 1" keyTimes="0;0.4;1"' + 
        'calcMode="spline" repeatCount="indefinite"/>' +    
        '<animate attributeName="rx" from="36" to="36" begin="0s"' +
        'dur="1.5s" values="36;10;36" keySplines=".6 .0 .8 .0; .0 .8 .0 1"' + 
        'keyTimes="0;0.4;1" calcMode="spline" repeatCount="indefinite"/>' +
        '<animate attributeName="opacity" from=".2" to=".2"  begin="0s" ' +
        ' dur="1.5s" values=".1;.7;.1" keySplines=" .6.0 .8 .0; .0 .8 .0 1" ' +
        'keyTimes=" 0;0.4;1" calcMode="spline" ' +
        'repeatCount="indefinite"/></ellipse><ellipse fill="#1b468d" ' +
        'cx="26" cy="20" rx="16" ry="12"><animate attributeName="cy" ' +
        'from="20" to="20" begin="0s" dur="1.5s" values="20;112;20" ' +
        'keySplines=".6 .1 .8 .1; .1 .8 .1 1" keyTimes=" 0;0.4;1" ' +
        'calcMode="spline" repeatCount="indefinite"/> ' +
        '<animate attributeName="ry" from="16" to="16" begin="0s" ' + 
        'dur="1.5s" values="16;12;16" keySplines=".6 .0 .8 .0; .0 .8 .0 1" ' +
        'keyTimes="0;0.4;1" calcMode="spline" ' +
        'repeatCount="indefinite"/></ellipse></svg>';
        //se crea un grupo de marcas de here para poder almacenar las marcas creadas
        group = new H.map.Group();
        map.addObject(group);
        //esta variable tendra el control de marcas creadas en Here
        var iteracion=0;
        //La siguiente función sirve para eliminar y colocar la marcar en el mapa con el fin de no saturar de marcas diferentes y ademas ayuda a cambiar sus coordenadas
    function ubicar(I){
        
        var it = I;
    
            if( it < 1 ) {
                var icon = new H.map.DomIcon(animatedSvg),
                coords = {lat: geolocaliza1(), lng: geolocaliza2()},
                marker = new H.map.DomMarker(coords, {icon: icon});
                group.addObject(marker);
               iteracion++;        
               
            } else {
                iteracion = iteracion - 1 ;
                map.removeObject(group);
                group = new H.map.Group();
                map.addObject(group); }
        }
    //creacion de una marca con nueva ubicacion cada 2 segundos
    setInterval('ubicar(iteracion)',2000);
</script>
        <div>
            <button class="Primario btn" name="Primario" >
                <a  type="submit" href="home.php">Inicio</a>
            </button>
        </div>
    </div>
  </body>
</html>

 <script type="text/javascript">
    //Scrip para obtener lar cooordenadas y colocarlas en los input
    $(document).ready(function(){
        setInterval(
                function(){
                    $.get('../controllers/CoordenadasLat.php', function(corde1){$('#Latitud_input').val(corde1)})
                &&
                    $.get('../controllers/CoordenadasLog.php', function(corde2){$('#Longitud_input').val(corde2) })
                },10000 //intervalo de 2 segundos
            );
    });
//
</script>



<!--fin centro-->
      </div>
      </div>
      </div>
      <!-- /.box -->



      

    </section>
    <!-- /.content -->
  </div>
<?php 
}else{
 require 'noacceso.php'; 
}

require 'footer.php';
 ?>
 <script src="scripts/ventasfechacliente.js"></script>
 <?php 
}

ob_end_flush();
  ?>

