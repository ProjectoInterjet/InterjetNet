<?php
$hostname ="localhost";  //nuestro servidor
$database ="dbsistema";//Nombre de nuestra base de datos
$username ="root";//Nombre de usuario de nuestra base de datos (yo utilizo el valor por defecto)
$password ="";//Contraseña de nuestra base de datos (yo utilizo por defecto)
$conexion = mysqli_connect($hostname,$username,$password)//Conexión a nuestro servidor mysql
//mysqli_select_db($conexion,$dbname);
or
trigger_error(mysql_error(),E_USER_ERROR); //mensaaje de error si no se puede conectar
mysqli_select_db($conexion, $database);//seleccion de la base de datos con la qu se desea trabajar
 
  //variables que almacenan los valores que enviamos por nuestra app, (observar que se llaman igual en nuestra app y aqui)
  $direccion=$_POST['direccion'];
  $coordenadas=$_POST['coordenadas'];
 
  if (empty($_POST["coordenadas"]) AND $_POST["direccion"]!==''){
  echo "Faltan DATOS los campos estan vacios"; 
  }else{
 
$query_search = "insert into gps(direccion,coordenadas) values ('".$direccion."','".$coordenadas."')";//Sentencia sql a realizar
$query_exec = mysqli_query($conexion,$query_search) or die(mysqli_error($conexion));//Ejecuta la sentencia sql.
  }
?>
