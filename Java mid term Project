import java.io.BufferedReader;
import java.io.InputStreamReader;

/**
 * 
 */

/**Ryan Groch
 * Week 5
 * Test 1
 */
public class Test {

	/** This program will show a Loan Amortization Schedule based on user input.
	 *  The user will enter in a loan amount, number of years for the loan, and annual interest rate.
	 */
	public static void main(String[] args) {
		
		//declare variables	
		int intYears = 0;
		double dblAnnualInterest = 0;
		double dblLoanAmount = 0;	
		double dblMonthlyInterest = 0;
		double dblMonthlyPayment = 0;
		double dblPrincipal = 0;

		int intCounter = 1;
		
		System.out.print("Ryan Groch - Loan Amortization Schedule" + "\n");
		System.out.print("Class - IT-161" + "\n" + "\n");
		
		//gather input for the loan amount
		System.out.print("Enter in loan amount: " + "\n");
		dblLoanAmount = ReadIntegerFromUser();
		
		//gather input for the number of years for the loan
		System.out.print("Enter in number if years for loan: " + "\n");
		intYears = ReadIntegerFromUser();
		
		//gather input for the annual interest rate for the loan
		System.out.print("Enter in the annual interest rate: " + "\n");
		dblAnnualInterest = ReadDoubleFromUser();
		
//--------------------------------------------------------------------------------	
		
		//calculate the monthly interest rate
		dblMonthlyInterest = dblAnnualInterest / 1200;
		
		//now calculate the monthly payment using the monthly interest rate
		dblMonthlyPayment = (dblLoanAmount * dblMonthlyInterest / (1 - 1 / Math.pow(1 + dblMonthlyInterest, intYears * 12)));
		
		//display monthly payment
		System.out.print("Monthly Payment: " + Math.round(dblMonthlyPayment * 100.0) / 100.0 + "\n");
		 
		//calculate total payment and display
		 dblLoanAmount = Math.round(dblMonthlyPayment * intYears * 12 * 100.0) / 100.0;
		 System.out.print("Total Payment is: " + dblLoanAmount + "\n" + "\n");
		
		 //calculate the monthly interest 
		 dblMonthlyInterest = dblAnnualInterest / (intYears * 12) * 100;
		 
		 //calculate the principal balance
		 dblPrincipal = dblMonthlyPayment - dblMonthlyInterest;
		 
//--------------------------------------------------------------------------------	
		 
		//create amortization schedule with payment number, interest, principal, and balance
		System.out.print("Payment#\tInterest \tPrincipal \tBalance" + "\n");
		
		//loop and display results
		while(dblLoanAmount >= 0) 
		{
			dblLoanAmount -= dblMonthlyPayment;
			
			System.out.printf(intCounter++  + "\t" + "\t" + Math.round(dblMonthlyInterest * 100.0) / 100.0 + "\t" + "\t" + Math.round(dblPrincipal * 100.0) / 100.0 + "\t" + "\t" +  "%.2f%n",dblLoanAmount);
			
			
			dblMonthlyInterest -= dblAnnualInterest - intYears;
			dblPrincipal += dblAnnualInterest;				
		}
	}

//--------------------------------------------------------------------------------
		// this method will read an integer input from the user
		
		public static int ReadIntegerFromUser()
		{
			int intValue = 0;
			
			try
			{
				String strBuffer = "";
				
				//Input Stream
				BufferedReader burInput = new BufferedReader(new InputStreamReader(System.in));
				
				//read a line from the user
				strBuffer = burInput.readLine();
				
				//convert from string to integer
				intValue = Integer.parseInt(strBuffer);
			}
			catch(Exception excError)
			{
				System.out.println(excError.toString());
			}
			
			//return integer value
			return intValue;
		}
//--------------------------------------------------------------------------------
		// this method will read a double input from the user
				
		public static double ReadDoubleFromUser( )
		{

			double sngValue = 0;

			try
			{
				String strBuffer = "";	

				// Input stream
				BufferedReader burInput = new BufferedReader( new InputStreamReader( System.in ) ) ;

				// Read a line from the user
				strBuffer = burInput.readLine( );
				
				// Convert from string to float
				sngValue = Float.parseFloat( strBuffer );
			}
			catch( Exception excError )
			{
				System.out.println( excError.toString( ) );
			}
			

			// Return float value
			return sngValue;
		}
}
