<?
ob_start();
error_reporting (E_ALL);
ini_set('display_errors',true);

require_once ('_cfg.inc.php');
require_once ('_lib/rdbms/mysqli_lib.inc.php');
require_once ('_lib/session/frontend.inc.php');

$PageElement=array();
session::start();
$hDB1= new sqlLink("localhost","root","root","artex_all");
//$hDB1= new sqlLink("localhost","root","digitaloceandbpwd","cabinet");

if (session::exists('find') and session::set('keyword')){
   if(isset($_REQUEST['keyword']) and mb_strlen($_REQUEST['keyword'])>=3){
     $_['query_str']=trim(preg_replace('/( +)+|\+/',' ',$_REQUEST['keyword']));
     $_['query_str']=substr(join('|',explode(' ',' '.$_['query_str'])),1);
     $hDB1->query($_CFG['SQL']['autocomplete_firm'],$_);
     $PageElement=$hDB1->fetch_field('value');}} 

if (session::exists('new_firm') and session::set('new_firm_name')){
   if(isset($_REQUEST['new_firm_name']) and mb_strlen($_REQUEST['new_firm_name'])>=3){
     $_['query_str']=trim(preg_replace('/( +)+|\+/',' ',$_REQUEST['new_firm_name']));
     $_['query_str']=substr(join('|',explode(' ',' '.$_['query_str'])),1);
     $hDB1->query($_CFG['SQL']['autocomplete_firm'],$_);
     $PageElement=$hDB1->fetch_field('value');}}

if (session::exists('new_firm_item') and session::set('new_firm_item_name')){
   if($_REQUEST['term']==$_REQUEST['new_firm_item_name'] and mb_strlen($_REQUEST['new_firm_item_name'])>=3){
     $_['query_str']=trim(preg_replace('/( +)+|\+/',' ',$_REQUEST['new_firm_item_name']));
     $_['query_str']=substr(join('|',explode(' ',' '.$_['query_str'])),1);
     $hDB1->query($_CFG['SQL']['autocomplete_item'],$_);
     $PageElement=$hDB1->fetch_field('label');}}

if (session::exists('new_firm_address') and session::set('new_firm_town_id','new_firm_street_name')){
   if($_REQUEST['term']==$_REQUEST['new_firm_street_name'] and mb_strlen($_REQUEST['new_firm_street_name'])>=2){
     $_['town_id']=$_REQUEST['new_firm_town_id'];
     $_['query_str']=trim(preg_replace('/( +)+|\+/',' ',$_REQUEST['new_firm_street_name']));
     $_['query_str']=substr(join('|',explode(' ',' '.$_['query_str'])),1);
     $hDB1->query($_CFG['SQL']['autocomplete_street'],$_);
     $PageElement=$hDB1->fetch_field('label');}}

if (session::exists('export') and session::set('export_town_id','export_item_name')){
   if($_REQUEST['term']==$_REQUEST['export_item_name'] and mb_strlen($_REQUEST['export_item_name'])>=1){
     $_['query_str']=trim(preg_replace('/( +)+|\+/',' ',$_REQUEST['export_item_name']));
     $_['query_str']=substr(join('|',explode(' ',' '.$_['query_str'])),1);
     $hDB1->query($_CFG['SQL']['autocomplete_item'],$_);
     $PageElement=$hDB1->fetch_field('label');}}

header('Content-Type: application/json');
echo json_encode($PageElement);
?>