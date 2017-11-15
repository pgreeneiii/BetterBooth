class EvaluationsController < ApplicationController
  def index
    @evaluations = Evaluation.all

    render("evaluations/index.html.erb")
  end

  def show
    @evaluation = Evaluation.find(params[:id])

    render("evaluations/show.html.erb")
  end

  def new
    @evaluation = Evaluation.new

    render("evaluations/new.html.erb")
  end

  def create
    @evaluation = Evaluation.new

    course_id = params[:course_id]
    professor_id = params[:professor_id]

    @evaluation.class_id = Section.find_by(:course_id => course_id, :professor_id => professor_id).id
    @evaluation.avg_hours = params[:avg_hours]
    @evaluation.communication = params[:communication]
    @evaluation.engagement = params[:engagement]
    @evaluation.practical = params[:practical]
    @evaluation.learning = params[:learning]
    @evaluation.recommendation = params[:recommendation]
    @evaluation.p1_bid_min = params[:p1_bid_min]
    @evaluation.p1_bid_max = params[:p1_bid_max]
    @evaluation.p2_bid_min = params[:p2_bid_min]
    @evaluation.p2_bid_max = params[:p2_bid_max]
    @evaluation.p3_bid_min = params[:p3_bid_min]
    @evaluation.p3_bid_max = params[:p3_bid_max]
    @evaluation.p4_bid_min = params[:p4_bid_min]
    @evaluation.p4_bid_max = params[:p4_bid_max]


    save_status = @evaluation.save

    if save_status == true
      redirect_to("/evaluations/#{@evaluation.id}", :notice => "Evaluation created successfully.")
    else
      render("evaluations/new.html.erb")
    end
  end

  def edit
    @evaluation = Evaluation.find(params[:id])

    render("evaluations/edit.html.erb")
  end

  def update
    @evaluation = Evaluation.find(params[:id])

    @evaluation.class_id = params[:class_id]
    @evaluation.avg_hours = params[:avg_hours]
    @evaluation.communication = params[:communication]
    @evaluation.engagement = params[:engagement]
    @evaluation.practical = params[:practical]
    @evaluation.learning = params[:learning]
    @evaluation.recommendation = params[:recommendation]
    @evaluation.bid_min = params[:bid_min]
    @evaluation.bid_max = params[:bid_max]

    save_status = @evaluation.save

    if save_status == true
      redirect_to("/evaluations/#{@evaluation.id}", :notice => "Evaluation updated successfully.")
    else
      render("evaluations/edit.html.erb")
    end
  end

  def destroy
    @evaluation = Evaluation.find(params[:id])

    @evaluation.destroy

    if URI(request.referer).path == "/evaluations/#{@evaluation.id}"
      redirect_to("/", :notice => "Evaluation deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Evaluation deleted.")
    end
  end
end
