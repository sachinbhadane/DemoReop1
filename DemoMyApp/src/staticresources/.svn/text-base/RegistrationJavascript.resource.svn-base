// JavaScript Document
	function del()
			{
				if(confirm("Are you sure, to delete record?")){return true;} else {return false;}
			}

// JavaScript Document
function chkvalue(str1,str2,str3)
{
document.getElementById(str1).className='form-text-box';
if(trim(document.getElementById(str1).value)!="")
{
document.getElementById(str2).style.display='none';
document.getElementById(str3).style.display='inline';
return true;
}
else
{
document.getElementById(str2).style.display='inline';
document.getElementById(str3).style.display='none';
return false;
}
}




function trim(stringToTrim) 
{return stringToTrim.replace(/^\s+|\s+$/g,"");}
function chkpassword(tBox,str1,str2,str3)
{         
document.getElementById(str1).className='form-text-box';
var curVal = tBox.value;  
    
if ((/[^A-Za-z]/.test(curVal)) && (/[^0-9]/.test(curVal))  && (curVal.length > 5 )) 
{
document.getElementById(str3).style.display='none';
document.getElementById(str2).style.display='inline';
document.getElementById(str1).className='form-text-box';
return true; 
} 
else
{           
document.getElementById(str3).style.display='inline';
document.getElementById(str2).style.display='none';
document.getElementById(str1).className='form-text-box-error';
return false;    
}  
}
function chkemail(email,str1,str2) {
document.getElementById(str1).className='form-text-box';
   var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
   var address = email;
   if(reg.test(address) == false) {
     // alert('Invalid Email Address');
     document.getElementById(str2).style.display='inline';
document.getElementById(str1).className='form-text-box-error';
      return false;
   }
else {document.getElementById(str2).style.display='none';
return true;
}
//return true;
}
function emsgstar(str){
if(str=="English"){
document.getElementById('Speaking').innerHTML='&nbsp;';
document.getElementById('Listening').innerHTML='&nbsp;';
document.getElementById('Writing').innerHTML='&nbsp;';
document.getElementById('Reading').innerHTML='&nbsp;';
}
else
{
document.getElementById('Speaking').innerHTML='*&nbsp;';
document.getElementById('Listening').innerHTML='*&nbsp;';
document.getElementById('Writing').innerHTML='*&nbsp;';
document.getElementById('Reading').innerHTML='*&nbsp;';
}
}                                                 
