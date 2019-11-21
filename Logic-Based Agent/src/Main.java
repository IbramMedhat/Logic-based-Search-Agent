import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

public class Main {

	 public static void GenGrid (String grid) throws FileNotFoundException, UnsupportedEncodingException {
		 PrintWriter writer = new PrintWriter("KB2.pl", "UTF-8");
		 //Parsing first the height and width of the grid which are first elements before (;)
		 int gridWidth = Integer.parseInt(grid.split(";")[0].split(",")[0]);
		 int gridHeight = Integer.parseInt(grid.split(";")[0].split(",")[1]);
		 
		 //Parsing the iron man x and y position which is 2nd element when splitting on (;)
		 int imXPosition = Integer.parseInt(grid.split(";")[1].split(",")[0]);
		 int imYPosition = Integer.parseInt(grid.split(";")[1].split(",")[1]);
		 
		 //parsing Thanos x and y position which is 3rd element when splitting on (;)
		 int tXPosition = Integer.parseInt(grid.split(";")[2].split(",")[0]);
		 int tYPosition = Integer.parseInt(grid.split(";")[2].split(",")[1]);
		 
		 //parsing the 4 stones x and y position as the 4th element when splitting on (;)
		 int s1XPosition = Integer.parseInt(grid.split(";")[3].split(",")[0]);
		 int s1YPosition = Integer.parseInt(grid.split(";")[3].split(",")[1]);
		 int s2XPosition = Integer.parseInt(grid.split(";")[3].split(",")[2]);
		 int s2YPosition = Integer.parseInt(grid.split(";")[3].split(",")[3]);
		 int s3XPosition = Integer.parseInt(grid.split(";")[3].split(",")[4]);
		 int s3YPosition = Integer.parseInt(grid.split(";")[3].split(",")[5]);
		 int s4XPosition = Integer.parseInt(grid.split(";")[3].split(",")[6]);
		 int s4YPosition = Integer.parseInt(grid.split(";")[3].split(",")[7]);
		 
		 // Writing the fact including height and width of the grid to the KB file
		 writer.println("grid(" + gridWidth + ", " + gridHeight + ").");
		 
		// Writing the facts including X and Y positions of each stone to the KB file
		 writer.println("posS(" + s1XPosition + ", " + s1YPosition + ", " + "stone_1).");
		 writer.println("posS(" + s2XPosition + ", " + s2YPosition + ", " + "stone_2).");
		 writer.println("posS(" + s3XPosition + ", " + s3YPosition + ", " + "stone_3).");
		 writer.println("posS(" + s4XPosition + ", " + s4YPosition + ", " + "stone_4).");
		 
		 // Writing the fact describing X and Y positions of Thanos to the KB file
		 writer.println("posTH(" + tXPosition + ", " + tYPosition + ").");
		 
		 // Writing the fact of iron man X and Y position in initial situation s0 to the KB file
		 writer.println("posIM(" + imXPosition + ", " + imYPosition + ", " + "s0).");
		 
		 
		 writer.close(); 
	 }
	 
	 public static void main(String[]args) throws FileNotFoundException, UnsupportedEncodingException {
		 GenGrid("5,5;2,2;5,5;2,3,3,4,4,4,4,5");
		 //Secind grid is the one in the project description
	 }

}
