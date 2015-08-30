<?
ob_start();
error_reporting (E_ALL);
ini_set('display_errors',true);

require_once ('_cfg.inc.php');
require_once ('_lib/rdbms/mysqli_lib.inc.php');
require_once ('_lib/xml/xslt.inc.php');
require_once ('_lib/session/frontend.inc.php');

$_FRONT_END['alpha']='';
$_FRONT_END['town']='';
$_FRONT_END['keyword']='';

$_PAGE='index';
$PageElement=array();
session::start();
echo '<hr>$_REQUEST<br>';
var_dump($_REQUEST);
echo '<hr>$_SESSION<br>';
var_dump($_SESSION['FRONT_END']);
echo '<hr>$_FRONT_END<br>';
var_dump($_FRONT_END);
echo '<br>';
echo '<br>';
echo '<hr>$_SESSION::diff()<br>';
var_dump(session::diff());
echo '<hr>$_SESSION::diff(keyword,town)<br>';
var_dump(session::diff('alpha'));
var_dump(session::diff('keyword'));
var_dump(session::diff('town'));
echo '<hr> d s e <br/>';
var_dump(session::diff('alpha','keyword','town'));
var_dump(session::set('alpha'));
var_dump(session::exists('alpha'));
session::close();
?>
<html>
<body>
<div>
<form>
<input type='text' name='keyword' value='<?echo $_FRONT_END['keyword'];?>'></input>
<input type='text' name='town'    value='<?echo $_FRONT_END['town'];?>'></input>
<input type='submit'></input>
</form>
</div>
</body>
</html>
