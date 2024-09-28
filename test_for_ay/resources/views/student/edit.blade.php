
<h4>Edit & Update Student
                        <a href="{{ url('students') }}" >BACK</a>
                    </h4>
                

                    <form action="{{ url('update-student/'.$student->id) }}" method="POST">
                        @csrf
                        @method('PUT')  
 <table>
                        <tr>
                         <td>   Student Name</td>
                          <td>  <input type="text" name="name" value="{{$student->name}}" class="form-control"></td>
                        </tr>
                       
                        <tr>
                            <td>Student Email</td>
                            <td><input type="text" name="email" value="{{$student->email}}" ></td>
                        </tr>
                        <tr>
                            <td>Student Course</td>
                            <td><input type="text" name="course" value="{{$student->course}}" ></td>
                            </tr>
                        <tr>
                       
                          <td>Student Section</td>
                           <td> <input type="text" name="section" value="{{$student->section}}" ></td>
                           </tr>
                        <tr>
                       
                            <button type="submit" >Update Student</button>
			</table>   

                    </form>
