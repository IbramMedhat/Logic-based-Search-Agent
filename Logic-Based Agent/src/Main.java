import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

public class Main {

	 public static void GenGrid (String grid) throws FileNotFoundException, UnsupportedEncodingException {
		 PrintWriter writer = new PrintWriter("endgame.pl", "UTF-8");
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
		 
		 writer.println("gridSize(" + gridWidth + ", " + gridHeight + ").");
		 
		 // Iron man position is a fluent as it changes according to the state.
		 writer.println("positionIM(" + imXPosition + ", " + imYPosition + ", " + "s0).");
		 
		 writer.println("positionTH(" + tXPosition + ", " + tYPosition + ").");
		 
		 writer.println("positionS(" + s1XPosition + ", " + s1YPosition + ", " + "s1, s0).");
		 writer.println("positionS(" + s2XPosition + ", " + s2YPosition + ", " + "s2, s0).");
		 writer.println("positionS(" + s3XPosition + ", " + s3YPosition + ", " + "s3, s0).");
		 writer.println("positionS(" + s4XPosition + ", " + s4YPosition + ", " + "s4, s0).");
		 writer.close(); 
	 }
	 
	 public static void main(String[]args) throws FileNotFoundException, UnsupportedEncodingException {
		 GenGrid("5,5;1,2;3,4;1,1,2,1,2,2,3,3");
	 }

}
