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

       $_FRONT_END=array_intersect_key(array_merge($_FRONT_END,$_SESSION['FRONT_END'],$_REQUEST),$_FRONT_END);

       return  $_FRONT_END;}

public static function diff(){
       global $_FRONT_END;
       $vars=func_get_args();
       foreach ($vars as $var){
               if (isset($_REQUEST[$var])){ 
                    if ((isset($_SESSION['FRONT_END'][$var]) and $_REQUEST[$var]!=$_SESSION['FRONT_END'][$var]) or !isset($_SESSION['FRONT_END'][$var]))
                        return(true);}}
        return(false);}

public static function close(){
       global $_FRONT_END;
       $_SESSION['FRONT_END']=$_FRONT_END;
       session_write_close();
       unset($_SESSION);}
}
?>
