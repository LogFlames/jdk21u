import java.util.Scanner;

public class Login {
    public static void main(String[] args) {
        final String SECRET_PASSWORD = "hello123";
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter password: ");
        String input = scanner.nextLine();

        if (SECRET_PASSWORD.equals(input)) {
            System.out.println("Authorized.");
        } else {
            System.out.println("Invalid password.");
        }

        scanner.close();
    }
}
