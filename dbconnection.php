<?php


function dbconnection()
{
    $con=mysqli_connect("localhost","root","","uploadimage");
    return $con;
}


?>