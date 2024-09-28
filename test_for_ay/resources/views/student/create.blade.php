<h4>Add Student</h4>
            
                

                    <form action="{{ url('add-student') }}" method="POST">
                        @csrf

                       <table>
                        <tr>
                            <td>Student Name</td>
                           <td> <input type="text" name="name" ></td>
                            </tr>
                            <tr>
                      
                            <td>Student Email</td>
                            <td><input type="text" name="email" ></td>
                            </tr>
                            <tr>
                            <td>Student Course</td>
                            <td><input type="text" name="course" ></td>
                            </tr>
                            <tr>
                            <td>Student Section</td>
                           <td> <input type="text" name="section" ></td>
                           </tr>
                            <tr>
                           <td> <button type="submit" >Save Student</button></td>
			</tr>

                    </form>
<br>
 <a href="{{ url('students') }}" >Show All Student</a>

