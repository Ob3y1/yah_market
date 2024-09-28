@if(($id)==1)
student id is equal to 1
@elseif(($id) < 10)
student id is less than 10
@elseif(($id) < 20)
student id is less than 20
@else
student id is nvalid
@endif
<br>
@switch($grade)
@case('A')
<span style='color:green;'>Grade A</span>
@break
@case('B')
<span style='color:blue;'>Grade B</span>
@break
@case('C')
<span style='color:red;'>Grade C</span>
@break
@default
<span style='color:red;'> Invalid Grade</span>
@endswitch
