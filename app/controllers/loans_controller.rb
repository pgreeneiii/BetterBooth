class LoansController < ApplicationController
  def index
    @loans = Loan.all

    render("loans/index.html.erb")
  end

  def calc
     @loans = User.find(params[:id]).loans.order(principal: :asc)

      date_from = Date.today
      date_to = @loans.maximum(:due_date)
      @last_payment = @loans.maximum(:due_date)
      date_range = date_from..date_to

      date_months = date_range.map {|d| Date.new(d.year, d.month, 1) }.uniq

      @data = {}

      date_months.each do |date|
         @data[date] = {}
      end

      # Store User's Loan data as hash, with an array that has original principal, principal, monthly apr, and minimum payment
      @loan_data = {}

      # Initiate balance variable - used to check repayment plan
      balance = 0
      @loans.each do |loan|
         monthly_apr = (loan.apr / 100 / 12)

         discount_factor = (((1+monthly_apr)**(loan.term*12))-1)/(monthly_apr*((1+monthly_apr)**(loan.term*12)))

         min_payment = loan.orig_principal/discount_factor

         @loan_data[loan.name] = [loan.orig_principal, loan.principal, monthly_apr, min_payment]

         # Set balance to check when loans are all paid off
         balance += loan.principal
      end



      date_months.each do |month|


         # loan[1][x]
         ## 0 = Original principal
         ## 1 = principal
         ## 2 = monthly APR
         ## 3 = minimum payment

         @loan_data.each do |loan|
            balance -= (loan[1][3] + 0)
         end

         if balance <= 0
            @last_payment = month
            break
         end
      end

     # Need a do, while loop that generates an array of hashes where the KEY is the month-year and the data is the principal, interest, payment, additional payment. Loop should continue until principal is less than zero.

     render("loans/calc.html.erb")
  end

  def show
    @loan = Loan.find(params[:id])

    render("loans/show.html.erb")
  end

  def new
    @loan = Loan.new

    render("loans/new.html.erb")
  end

  def create
    @loan = Loan.new

    @loan.name = params[:name]
    @loan.principal = params[:principal]
    if params[:due_date].nil?
      due_date = nil
    else
       date_array = params[:due_date].split('-')
       due_date = Date.new(date_array[0].to_i,date_array[1].to_i)
    end

    @loan.due_date = due_date
    @loan.apr = params[:apr]
    @loan.user_id = params[:user_id]

    save_status = @loan.save

    if save_status == true
      redirect_to("/loans/#{@loan.id}", :notice => "Loan created successfully.")
    else
      render("loans/new.html.erb")
    end
  end

  def edit
    @loan = Loan.find(params[:id])

    year = @loan.due_date.year
    month = @loan.due_date.month
    if month < 10
      month = "0#{month}"
   end

    @date = "#{year}-#{month}"

    render("loans/edit.html.erb")
  end

  def update
    @loan = Loan.find(params[:id])

    @loan.name = params[:name]
    @loan.principal = params[:principal]
    if params[:due_date].nil?
      due_date = nil
    else
       date_array = params[:due_date].split('-')
       due_date = Date.new(date_array[0].to_i,date_array[1].to_i)
    end

    @loan.due_date = due_date
    @loan.apr = params[:apr]
    @loan.user_id = params[:user_id]

    save_status = @loan.save

    if save_status == true
      redirect_to("/loans/#{@loan.id}", :notice => "Loan updated successfully.")
    else
      render("loans/edit.html.erb")
    end
  end

  def destroy
    @loan = Loan.find(params[:id])

    @loan.destroy

    if URI(request.referer).path == "/loans/#{@loan.id}"
      redirect_to("/", :notice => "Loan deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Loan deleted.")
    end
  end
end
