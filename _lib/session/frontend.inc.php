<?
/*
Front-end variables tracking 
*/
$_FRONT_END=array(); 

class session {

public static function start(){
       global $_FRONT_END;
//     New session init
       session_start();

       if (!isset($_SESSION['FRONT_END']) or !is_array($_SESSION['FRONT_END'])){
           $_SESSION['FRONT_END']=$_FRONT_END;}
       //Remove not tracked 
       $_SESSION['FRONT_END']=array_intersect_key($_SESSION['FRONT_END'],$_FRONT_END);
       //
       $_FRONT_END=array_merge($_FRONT_END,$_SESSION['FRONT_END'],$_REQUEST);

       return  $_FRONT_END;}

public static function diff(){
       global $_FRONT_END;

       //if not XDR return true 
       if(!isset($_SERVER['HTTP_X_REQUESTED_WITH']) or strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) != 'xmlhttprequest'){
          return(true);}

       $vars=func_get_args();

       foreach ($vars as $var){
               if (isset($_REQUEST[$var]) and isset($_SESSION['FRONT_END'][$var])){
                  if ($_REQUEST[$var] != $_SESSION['FRONT_END'][$var]){
                      return(true);}}
               elseif(isset($_REQUEST[$var])){
                      return(true);}}
       return(false);}

public static function exists(){
       $vars=func_get_args();
       foreach ($vars as $var){
               if (!array_key_exists($var,$_REQUEST)){
                   return (false);}}
       return(true);}

public static function set(){
       $vars=func_get_args();
       foreach ($vars as $var){
               if (!isset($_REQUEST[$var]) or $_REQUEST[$var]==''){
                   return (false);}}
       return(true);}

public static function close(){
       global $_FRONT_END;
       $_SESSION['FRONT_END']=$_FRONT_END;
       session_write_close();
       unset($_SESSION['FRONT_END']);}
}
?>
