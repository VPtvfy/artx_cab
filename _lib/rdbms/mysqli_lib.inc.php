<?
class sqlLink extends mysqli{
public  $querylog=array();
//----------------------------------------------------------------------------------------------------------------------------------------------------------
private function logError($error='',$detail=''){
        $this->querylog[]=array('error'=>$error,'detail'=>$detail);}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
private function logQuery($query,$detail='',$execution_time='',$transfer_time=''){
        $_=array();
        $_['query']=$query;
        if (isset($detail->affected_rows)){$_['affected_rows'] = $detail->affected_rows;}
        if (isset($detail->insert_id)){$_['insert_id'] = $detail->insert_id;}
        if (isset($detail->num_rows)){$_['num_rows'] = $detail->num_rows;}
        if (isset($detail->param_count)){$_['param_count'] = $detail->param_count;}
        if (isset($detail->field_count)){$_['field_count'] = $detail->field_count;}
        if (isset($detail->errno) and $detail->errno>0){$_['errno'] = $detail->errno;
           $_['error'] = $detail->error;}
        $_['Execution time'] =$execution_time;
        $_['Transfer time'] =$transfer_time;
        $this->querylog[]=$_;}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
public  function timeStat(){
        static $timeStamp=0.0;
        if ($timeStamp==0.0){
            $timeStamp=microtime(true);
            return(0.0);}
        $delta=microtime(true)-$timeStamp;
        $timeStamp=microtime(true);
        return ($delta);}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
public  function __construct($host="localhost",$user="root",$password="",$db=""){
        $this->querylog=array();
        parent::__construct("p:".$host, $user, $password);

        if ($this->connect_errno != 0){
            $this->logError("Connection Error $user@$host",$this->connect_error);}
        else {
           if (!empty($db)){
               if (!parent::select_db($db)){
                  $this->logError("Database selection error $user@$host:$db");}}
           parent::query("SET NAMES utf8");}}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
private function getParameterType($parameters){
        $type='';
        foreach ($parameters as $parameter){
                 if(is_numeric($parameter)){
                    if (is_int($parameter)){$type.='i';}
                    else {$type.='d';}}
                 else {$type.='s';}}
        return(array_merge(array(&$type),$parameters));}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
private function exec($query,$_=''){
        if ($_!=''){
            preg_match_all('/:[_a-zA-Z][_a-zA-Z0-9]+/is',$query,$names);
            if (is_array($names[0]) and $names[0]!=array()){
                $query=preg_replace('/:[_a-zA-Z][_a-zA-Z0-9]+/is','?',$query);
                $parameters=array();
                foreach ($names[0] as $vname){
                        if (!isset($_[substr($vname,1)])){$_[substr($vname,1)]='';}
                        $parameters[]=&$_[substr($vname,1)];}}}
         $this->timeStat();
         if($hCursor=parent::prepare($query)){
            if (isset($parameters)){
               $parameters=$this->getParameterType($parameters);
               call_user_func_array(array(&$hCursor,'bind_param'),$parameters);}
            $hCursor->execute();
            $execution_time=$this->timeStat();
            $hResult=$hCursor->get_result();
            $hCursor->store_result();
            $transfer_time=$this->timeStat();
            $this->logQuery($query,$hCursor,$execution_time,$transfer_time);
            return($hResult);}
         else{
           $this->logError($query,$this->error);}}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
public  function query($query,$_=''){
        $this->query=preg_split("/;\s*\r\n/",$query);
        $hResult=array();
        while (list($key,$query)=each($this->query)){
              if (!empty($query)){
                  $this->hCursor=$this->exec($query,$_);
                  $hResult[]=$this->hCursor;}}
        return ($hResult);}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
public  function fetch_assoc($rootkey="rowset",$childkey="row"){
        $rowset[$rootkey]=array();
        if (is_object($this->hCursor)){
           $this->hCursor->data_seek(0);
           while ($hROW=$this->hCursor->fetch_array(MYSQLI_ASSOC)){
                 array_push ($rowset[$rootkey],array($childkey=>$hROW));}}
        return $rowset;}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
public  function fetch_first(){
        if (is_object($this->hCursor)){
           $this->hCursor->data_seek(0);
           return($this->hCursor->fetch_array(MYSQLI_ASSOC));}}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
public  function fetch_next(){
        if (is_object($this->hCursor)){
           return($this->hCursor->fetch_array(MYSQLI_ASSOC));}}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
public  function fetch_last(){
        if (is_object($this->hCursor)){
           $this->hCursor->data_seek($this->hCursor->num_rows-1);
           return($this->hCursor->fetch_array(MYSQLI_ASSOC));}}
//----------------------------------------------------------------------------------------------------------------------------------------------------------
public  function fetch_all(){
        $rowset=array();
        if (is_object($this->hCursor)){
           $this->hCursor->data_seek(0);
           while ($hROW=$this->hCursor->fetch_array(MYSQLI_ASSOC)){
                 array_push($rowset,$hROW);}}
        return $rowset;}

//----------------------------------------------------------------------------------------------------------------------------------------------------------
public  function fetch_field($field){
        $rowset=array();
        if (is_object($this->hCursor)){
           $this->hCursor->data_seek(0);
           while ($hROW=$this->hCursor->fetch_array(MYSQLI_ASSOC)){
                 array_push($rowset,$hROW[$field]);}}
        return $rowset;}

}
?>