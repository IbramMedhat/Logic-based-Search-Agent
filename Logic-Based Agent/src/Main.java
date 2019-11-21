import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

public class Main {

	 public static void GenGrid (String grid) throws FileNotFoundException, UnsupportedEncodingException {
		 PrintWriter writer = new PrintWriter("KB2.pl", "UTF-8");
		 int gridWidth = Integer.parseInt(grid.split(";")[0].split(",")[0]);
		 int gridHeight = Integer.parseInt(grid.split(";")[0].split(",")[1]);
		 
		 int imXPosition = Integer.parseInt(grid.split(";")[1].split(",")[0]);
		 int imYPosition = Integer.parseInt(grid.split(";")[1].split(",")[1]);
		 
		 int tXPosition = Integer.parseInt(grid.split(";")[2].split(",")[0]);
		 int tYPosition = Integer.parseInt(grid.split(";")[2].split(",")[1]);
		 
		 int s1XPosition = Integer.parseInt(grid.split(";")[3].split(",")[0]);
		 int s1YPosition = Integer.parseInt(grid.split(";")[3].split(",")[1]);
		 int s2XPosition = Integer.parseInt(grid.split(";")[3].split(",")[2]);
		 int s2YPosition = Integer.parseInt(grid.split(";")[3].split(",")[3]);
		 int s3XPosition = Integer.parseInt(grid.split(";")[3].split(",")[4]);
		 int s3YPosition = Integer.parseInt(grid.split(";")[3].split(",")[5]);
		 int s4XPosition = Integer.parseInt(grid.split(";")[3].split(",")[6]);
		 int s4YPosition = Integer.parseInt(grid.split(";")[3].split(",")[7]);
		 
		 writer.println("grid(" + gridWidth + ", " + gridHeight + ").");
		 
		 writer.println("posS(" + s1XPosition + ", " + s1YPosition + ", " + "stone_1).");
		 writer.println("posS(" + s2XPosition + ", " + s2YPosition + ", " + "stone_2).");
		 writer.println("posS(" + s3XPosition + ", " + s3YPosition + ", " + "stone_3).");
		 writer.println("posS(" + s4XPosition + ", " + s4YPosition + ", " + "stone_4).");
		 
		 
		 writer.println("posTH(" + tXPosition + ", " + tYPosition + ").");
		 
		 // Iron man position is a fluent as it changes according to the state.
		 writer.println("posIM(" + imXPosition + ", " + imYPosition + ", " + "s0).");
		 
		 
		 writer.close(); 
	 }
	 
	 public static void main(String[]args) throws FileNotFoundException, UnsupportedEncodingException {
		 GenGrid("5,5;2,2;5,5;2,3,3,4,4,4,4,5");
		 //GenGrid("5,5;")
	 }

}
