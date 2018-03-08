<!DOCTYPE html>
<html>
<head>
	<title>
		Students List
	</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body class="container">
	<h1>STUDENT TABLE</h1>
	<form method="post">
		<label>  search Student by name</label>
		<input type="name" name="name" class=".form-control ">
		<button type="submit" class="btn btn-default">Submit</button>
	</form>
	<table class="table table-striped">
		<thead>
			<th>
				ID
			</th>

			<th>
				Name
			</th>

			<th>
				Department Name
			</th>

			<th>
				Total Credit
			</th>
		</thead>
		<tbody>
			<?php 
				$conn = new mysqli('localhost', 'libin', 'password', 'University');
				if ($conn->connect_error) {
    				die("Connection failed: " . $conn->connect_error);
				}
				if ($_SERVER['REQUEST_METHOD'] === 'POST') {
					$nam = $_POST['name'];
					$datastmt = "SELECT * FROM student WHERE name LIKE '%" . $nam . "%';";
				}
				else
				{
					$datastmt = "SELECT * FROM student;";
				}
				$result = $conn->query($datastmt);
	 				if ($result->num_rows > 0) {
	    			// output data of each row
	    			while($row = $result->fetch_assoc()) {
	        			echo "<tr> <td>" . $row["ID"]. "</td><td>" . $row["name"]. "</td><td>" . $row["dept_name"]."</td><td>" . $row["tot_cred"]. "</td><tr>" ;
					    }
					} else {
					    echo "0 results";
					}
				$conn->close();
 			?>
		</tbody>
	</table>
</body>
</html>
