<?
/*
Front-end variables tracking 

$_FRONT_END is merger of $_SESSION['FRONT_END'] and $_REQUEST arrays with types casting
$_FRONT_END store into $_SESSION['FRONT_END'] and keeps until end of session 
*/
class session {
public static function start(){
       global $_FRONT_END;
//     New session init
       session_start();
       if (!isset($_FRONT_END) or !is_array($_FRONT_END)){
           $_FRONT_END=array();}
       if (!isset($_SESSION['FRONT_END']) or !is_array($_SESSION['FRONT_END'])){
           $_SESSION['FRONT_END']=$_FRONT_END;}
//
//       foreach (array_keys($_REQUEST) as $key){
//               if (isset($_FRONT_END[$key])){
//                   settype($_REQUEST[$key],gettype($_FRONT_END[$key]));}}

       $_FRONT_END=array_intersect_key(array_merge($_FRONT_END,$_SESSION['FRONT_END'],$_REQUEST),$_FRONT_END);
//     First key of REQUEST is
       if (isset($_REQUEST) and is_array($_REQUEST)){
                 $_FRONT_END['event']=key($_REQUEST);}

       return  $_FRONT_END;}

public static function close(){
       global $_FRONT_END;
       $_SESSION['FRONT_END']=$_FRONT_END;
       session_write_close();
       unset($_FRONT_END);
       unset($_SESSION);}
}
?>
