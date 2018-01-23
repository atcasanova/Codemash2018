import java.io.PrintStream;

public class Lock2
{
  private static String key = "lockpickingisfun";
  private static String cipher = "?8hiyKT5fw*W^J~art3t.47i";
  
  public static void main(String[] args)
  {
    if (args.length != 1)
    {
      System.out.println("Provide codeword to open the lock!");
      System.exit(-1);
    }
    String input = args[0];
    StringBuffer codeword = new StringBuffer();
    for (int i = 0; i < cipher.length(); i++) {
      codeword.append((char)(key.charAt(i % key.length()) - cipher.charAt(i) + 54));
    }
		System.out.println(codeword.toString());
    if (codeword.toString().equals(input)) {
		System.out.println(codeword.toString());
      System.out.println("Correct codeword! The Lock is open!");
    } else {
		System.out.println(codeword.toString());
      System.out.println("Wrong codeword!");
    }
  }
}

