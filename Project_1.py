#----------------------------------------------------------
# Ryan Groch
# CPDM-198
# Project 1
#----------------------------------------------------------

# You have been asked to write a program for a retail store that will allow them to calculate discounts for their employees when they buy items. 
# Discounts are based on number of years worked as well as if the employee is a manager or hourly employee. They are also allowed no discount once they have received $200 in discounts for the year.  
# Once you complete the discount for the employee, a question should be asked as to if there is another employee.  If there is, collect the input and process the data for the next employee as such. 
# Do this until the user answers “NO” for “Another Employee”.  Once all employees have been processed, display the All Employee Summary and end the program. 

#--------------------------------------------------------------------
#--------------------------------------------------------------------
# This section contains created functions used
#--------------------------------------------------------------------
#--------------------------------------------------------------------

# This function will validate input for number of years employed
def Validate_Years_Employed(int_input):

   try:       
        intYears = int(int_input)

        # if number is positive
        if(intYears > 0):
            global strYearsFlag
            strYearsFlag = True

        # if number is negative
        else:
            print("Number of years must be positive and above zero")

        # if input is not numeric
   except ValueError:
        intYears = int(0)
        print("Number of years must be numeric")
   return intYears
#--------------------------------------------------------------------

#--------------------------------------------------------------------
# This function will validate input for total amount of previous purchases, before discounts
def Validate_Total_Purchases(int_input):

   try:       
        intTotalPurchases = float(int_input)

        # if number is positive
        if(intTotalPurchases >= 0):
            global strPurchasesFlag
            strPurchasesFlag = True

        # if number is negative
        else:
            print("Number must be positive")

        # if input is not numeric
   except ValueError:
        intTotalPurchases = float(0)
        print("Number must be numeric")
   return intTotalPurchases
#--------------------------------------------------------------------

#--------------------------------------------------------------------
# This function will validate input for today's total purchases
def Validate_Todays_Purchases(int_Input):

    try:
        intTodaysPurchases = float(int_Input)

        # if number is positive
        if(intTodaysPurchases >= 0):
            global strTodaysTotalFlag
            strTodaysTotalFlag = True

         # if number is negative
        else:
            print("Number must be positive")

        # if input is not numeric
    except ValueError:
        intTodaysPurchases = float(0)
        print("Number must be numeric")
    return intTodaysPurchases
#--------------------------------------------------------------------

#--------------------------------------------------------------------
# this function will determine if employee is hourly or management
def Validate_Status(strEmployeeStatus):

    global intDiscount
    global strValidateStatusFlag

# if the employee is managment
    if strEmployeeStatus == 'M' or strEmployeeStatus == 'm':
        
        if intYears >= 1 or intYears <= 3:            
            intDiscount = "20%"
            strValidateStatusFlag = True
        else:
            if intYears >= 4 or intYears <= 6:
               intDiscount = "24%"
               strValidateStatusFlag = True
            else:
                if intYears >= 7 or intYears <= 10:
                    intDiscount = "30%"
                    strValidateStatusFlag = True
                else:
                        if intYears >= 11 or intYears <= 14:
                            intDiscount = "35%"
                            strValidateStatusFlag = True
                        else:
                                if intYears > 15:
                                    intDiscount = "40%"
                                    strValidateStatusFlag = True
    

        # if the employee is hourly
    if strEmployeeStatus == 'H' or strEmployeeStatus == 'h':
      
      if intYears >= 1 or intYears <= 3:
         intDiscount = "10%"
         strValidateStatusFlag = True
      else:
           if intYears >= 4 or intYears <= 6:
              intDiscount = "14%"
              strValidateStatusFlag = True
           else:
                if intYears >= 7 or intYears <= 10:
                     intDiscount = "20%"
                     strValidateStatusFlag = True
                else:
                     if intYears >= 11 or intYears <= 14:
                        intDiscount = "25%"
                        strValidateStatusFlag = True
                     else:
                          if intYears > 15:
                             intDiscount = "30%"                              
                             strValidateStatusFlag = True

                             return strEmployeeStatus
#--------------------------------------------------------------------

#--------------------------------------------------------------------
# this function will calculate the year to date amount of discount
def Calculate_YTD_Discounts(intYTD_Discounts):

    intYTD_Discounts = float(intYTD_Discounts)

    # determine the employee's current discount percantage
    # by multiplying the total purchases before today, times, the current discount
    if intDiscount == "10%":
        intYTD_Discounts = intTotalPurchases * .1
    else:
        if intDiscount == "14%":
           intYTD_Discounts = intTotalPurchases * .14
        else:
             if intDiscount == "20%":
                intYTD_Discounts = intTotalPurchases * .2
             else:
                 if intDiscount == "24%":
                    intYTD_Discounts = intTotalPurchases * .24
                 else:
                      if intDiscount == "25%":
                         intYTD_Discounts = intTotalPurchases * .25
                      else:
                           if intDiscount == "30%":
                              intYTD_Discounts = intTotalPurchases * .3
                           else:
                                if intDiscount == "35%":
                                   intYTD_Discounts = intTotalPurchases * .35
                                else:
                                    if intDiscount == "40%":
                                       intYTD_Discounts = intTotalPurchases * .4
    
    return intYTD_Discounts
#--------------------------------------------------------------------

#--------------------------------------------------------------------
# this function determines the employee discount for this purchase
# discount cannot exceed $200
def Calculate_Discount(intEmployeeDiscount):

    intEmployeeDiscount = intEmployeeDiscount

    # if discount is less than 200 dollars before current purchase
    if intYTD_Discounts < 200:
       intEmployeeDiscount = intTodaysPurchases * (intYTD_Discounts / 10)

        # if less than 200 dollars before purchase but exceeds 200 after purchase       
       if intEmployeeDiscount > 200:
           intEmployeeDiscount = 200

    # if discount is above 200 dollars before current purchase
    else:
        intYTD_Discounts > 200
        intEmployeeDiscount = 200
    return intEmployeeDiscount
#--------------------------------------------------------------------
# this function will calculate the total purchase with discounts
def Calculate_Total(intTotal):

    intTotal = intTodaysPurchases * (intEmployeeDiscount / 10)
    return intTotal
#--------------------------------------------------------------------


#--------------------------------------------------------------------
#--------------------------------------------------------------------
# This section will gather and validate input data by calling functions
#--------------------------------------------------------------------
#--------------------------------------------------------------------

# variables set to false to run validation loops
strYearsFlag = bool(False)
strPurchasesFlag = bool(False)
strTodaysTotalFlag = bool(False)
strValidateStatusFlag = bool(False)
strMoreEmployeesFlag = bool(False)

# claim needed variables
intYTD_Discounts = 0
intEmployeeDiscount = 0
intTotal = 0
intRunningTotal_NoDiscount = 0
intRunningTotal_Discount = 0
intRunningTotal_YTD_Discounts = 0

# this will loop if more employees are added
while strMoreEmployeesFlag is False:
       
# loop to gather years worked, and call function to validate
    while strYearsFlag is False:
        intYears = raw_input("How many years has the employee worked? ")
        intYears = Validate_Years_Employed(intYears)
        
# loop to gather total purchases before discounts, and call function to validate
    while strPurchasesFlag is False:
        intTotalPurchases = raw_input("Enter in total amount of previous purchases, before discounts: ")
        intTotalPurchases = Validate_Total_Purchases(intTotalPurchases)
        
# loop to gather today's total purchases and call function to validate
    while strTodaysTotalFlag is False:
        intTodaysPurchases = raw_input("Enter in the total of today's purchases ")
        intTodaysPurchases = Validate_Todays_Purchases(intTodaysPurchases)
       
# loop to determine the employee's status
    while strValidateStatusFlag is False:
        strEmployeeStatus = str(raw_input("What is the employee's status? (Enter 'M' for Management or 'H' for Hourly): "))
        strEmployeeStatus = Validate_Status(strEmployeeStatus)
        

# this will determine if there are any more employees
    strMoreEmployees = raw_input("Are there any more employees? Answer 'Y' or 'N' ")

    # if yes
    if strMoreEmployees == 'Y' or strMoreEmployees == 'y':
          
        # set variables to false to reset validation loops
        strMoreEmployeesFlag = False       
        strYearsFlag = False
        strPurchasesFlag = False
        strTodaysTotalFlag = False
        strValidateStatusFlag = False
    
    # if no
    if strMoreEmployees == 'N' or strMoreEmployees == 'n':
        strMoreEmployeesFlag = True

    # calculate running total of today's purchases before discount applied
    intRunningTotal_NoDiscount = intRunningTotal_NoDiscount + intTodaysPurchases 

    # calculate running total of today's total purchases after discounts applied
    intRunningTotal_YTD_Discounts = intRunningTotal_YTD_Discounts + intRunningTotal_NoDiscount + (intEmployeeDiscount / 10)
    intRunningTotal_YTD_Discounts = intRunningTotal_YTD_Discounts / 10
    intRunningTotal_Discount = intRunningTotal_NoDiscount - intRunningTotal_YTD_Discounts

#--------------------------------------------------------------------
#--------------------------------------------------------------------
# This section will make appropriate calculations by calling functions
#--------------------------------------------------------------------
#-------------------------------------------------------------------- 
                  
# call year to date discount function
intYTD_Discounts = Calculate_YTD_Discounts(intYTD_Discounts)

# call calculating discount function
intEmployeeDiscount = Calculate_Discount(intEmployeeDiscount)

# call total calculations function
intTotal = Calculate_Total(intTotal)
        
#--------------------------------------------------------------------
#--------------------------------------------------------------------
# This section will display the appropriate output
#--------------------------------------------------------------------
#--------------------------------------------------------------------

print ""
print "          EMPLOYEE SUMMARY"
print "Employee discount percentage:", intDiscount
print "The YTD amount of discount:", intYTD_Discounts
print "The total purchase today before, discounts:", intTodaysPurchases 
print "The employee discount for this purchase:", intEmployeeDiscount
print "The total amount, with discounts:", intTotal

print "         ALL EMPLOYEE SUMMARY"
print "The total before discounts:", intRunningTotal_NoDiscount
print "The total after discounts:", intRunningTotal_Discount