module LoansHelper
   def avalanche(user_id, date_from, extra_payment)
      # Call active record
      loans = User.find(user_id).loans.order(apr: :desc, principal: :asc)

      # Initialize Variables
      date_to = loans.maximum(:due_date)
      last_payment = loans.maximum(:due_date)
      date_range = date_from..date_to
      month_count = 0
      loan_data = {}
      extra = extra_payment
      loans_outstanding = 0

      # Create array of months
      date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
      max_months = date_months.count

      # Build hash tables with loan data
      loans.each do |loan|
         monthly_apr = (loan.apr / 100 / 12)

         discount_factor = (((1+monthly_apr)**(loan.term*12))-1)/(monthly_apr*((1+monthly_apr)**(loan.term*12)))

         min_payment = loan.orig_principal/discount_factor

         if loan.principal > 0
            paid_off = false
            loans_outstanding += 1
         else
            paid_off = true
         end

         loan_data[loan.name] = {orig_principal: loan.orig_principal, principal: loan.principal, monthly_apr: monthly_apr, min_payment: min_payment, paid_off: paid_off}
      end

      # Only run if there are loans to calculate repayment for
      if loans_outstanding > 0
         loop do
            month_extra = extra

            loan_data.each do |loan|
               # Only do for loans not paid off
               if loan[1][:paid_off] == false

                  # calculate monthly interest
                  interest = (loan[1][:monthly_apr]*loan[1][:principal])

                  # if loan will not be paid off with min + extra
                  if ((loan[1][:principal] + interest - loan[1][:min_payment]) > month_extra)
                     # make payment
                     loan[1][:principal] -= (loan[1][:min_payment] + month_extra - interest)

                     # Set extra to zero for rest of loans
                     month_extra = 0

                  # pay off loan
                  else

                     # Reduce # of outstanding loans and set loan to paid_off
                     loans_outstanding -= 1

                     loan[1][:principal] = 0
                     loan[1][:paid_off] = true

                     # Add minimum payments from this loan to monthly extra payment
                     extra += loan[1][:min_payment]

                     if month_extra > 0
                        month_extra -= (loan[1][:principal] + interest)
                     end
                  end
               end
            end

            month_count += 1
            break if (loans_outstanding == 0)
         end
      end

      puts month_count
      puts max_months

      if (month_count >= max_months)
         return(date_months[max_months-1])
      else
         return(date_months[month_count])
      end
   end

   def snowball(user_id, date_from, extra_payment)
      # Call active record
      loans = User.find(user_id).loans.order(principal: :asc, apr: :desc)

      # Initialize Variables
      date_to = loans.maximum(:due_date)
      last_payment = loans.maximum(:due_date)
      date_range = date_from..date_to
      month_count = 0
      loan_data = {}
      extra = extra_payment
      loans_outstanding = 0

      # Create array of months
      date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq
      max_months = date_months.count

      # Build hash tables with loan data
      loans.each do |loan|
         monthly_apr = (loan.apr / 100 / 12)

         discount_factor = (((1+monthly_apr)**(loan.term*12))-1)/(monthly_apr*((1+monthly_apr)**(loan.term*12)))

         min_payment = loan.orig_principal/discount_factor

         if loan.principal > 0
            paid_off = false
            loans_outstanding += 1
         else
            paid_off = true
         end

         loan_data[loan.name] = {orig_principal: loan.orig_principal, principal: loan.principal, monthly_apr: monthly_apr, min_payment: min_payment, paid_off: paid_off}
      end

      # Only run if there are loans to calculate repayment for
      if loans_outstanding > 0
         loop do
            month_extra = extra

            loan_data.each do |loan|
               # Only do for loans not paid off
               if loan[1][:paid_off] == false

                  # calculate monthly interest
                  interest = (loan[1][:monthly_apr]*loan[1][:principal])

                  # if loan will not be paid off with min + extra
                  if ((loan[1][:principal] + interest - loan[1][:min_payment]) > month_extra)
                     # make payment
                     loan[1][:principal] -= (loan[1][:min_payment] + month_extra - interest)

                     # Set extra to zero for rest of loans
                     month_extra = 0

                  # pay off loan
                  else

                     # Reduce # of outstanding loans and set loan to paid_off
                     loans_outstanding -= 1

                     loan[1][:principal] = 0
                     loan[1][:paid_off] = true

                     # Add minimum payments from this loan to monthly extra payment
                     extra += loan[1][:min_payment]

                     if month_extra > 0
                        month_extra -= (loan[1][:principal] + interest)
                     end
                  end
               end
            end

            month_count += 1
            break if (loans_outstanding == 0)
         end
      end

      puts month_count
      puts max_months

      if (month_count >= max_months)
         return(date_months[max_months-1])
      else
         return(date_months[month_count])
      end
   end
end
