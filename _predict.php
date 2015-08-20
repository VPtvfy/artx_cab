<?
ob_start();
error_reporting (E_ALL);
ini_set('display_errors',true);

require_once ('_cfg.inc.php');
require_once ('lib/rdbms/mysqli_lib.inc.php');
require_once ('lib/session/frontend.inc.php');

//$_FRONT_END=array(); //$_ client state
$PageElement=array();
session::start();
$hDB1= new sqlLink("localhost","root","root","artex_all");

    switch ($_FRONT_END['event']){
      case 'keyword':
            if(isset($_REQUEST['term']) or $_REQUEST['term']!=""){
               $_['keyword']=trim(preg_replace('/( +)+|\+/',' ',$_REQUEST['term']));
               $_['query_str']=substr(join('|',explode(' ',' '.$_['keyword'])),1);
               $hDB1->query($_CFG['SQL']['autocomplete_firm'],$_);
               $PageElement=$hDB1->fetch_field('value');}
            break;
      case 'new_firm_name':
            if(isset($_REQUEST['term']) or $_REQUEST['term']!=""){
               $_['keyword']=trim(preg_replace('/( +)+|\+/',' ',$_REQUEST['term']));
               $_['query_str']=substr(join('|',explode(' ',' '.$_['keyword'])),1);
               $hDB1->query($_CFG['SQL']['autocomplete_firm'],$_);
               $PageElement=$hDB1->fetch_field('value');}
            break;
      case 'new_firm_item':
            if(isset($_REQUEST['term']) or $_REQUEST['term']!=""){
               $_['keyword']=trim(preg_replace('/( +)+|\+/',' ',$_REQUEST['term']));
               $_['query_str']=substr(join('|',explode(' ',' '.$_['keyword'])),1);
               $hDB1->query($_CFG['SQL']['autocomplete_item'],$_);
               $PageElement=$hDB1->fetch_field('value');}
            break;
           }
session::close();

//var_dump($PageElement);
//print_r($hDB1->querylog);
header('Content-Type: application/json');
echo json_encode($PageElement);
//var_dump($_);
?>