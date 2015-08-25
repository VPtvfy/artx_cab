<?
class vidget {
public  function __construct(id){
        $this->hash='';
        $this->sync=false;
        $this->model=array();}

public function vidget_hash(){
       $_=func_get_args();
       ksort($_);
       $_=join('_',$_);
       if ($this->hash!=$_){
           $this->sync=false;
           $this->hash=$_;}
       else
       return(false);}

}
?>