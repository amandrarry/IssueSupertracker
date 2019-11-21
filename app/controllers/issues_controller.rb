class IssuesController < ApplicationController
  before_action :set_current_user
  before_action :set_issue, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  
  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all.order(sort_column + ' ' + sort_direction)
    @issues = @issues.where(Type: params[:Type]) if params[:Type]
    @issues = @issues.where(Priority: params[:Priority]) if params[:Priority]
    @issues = @issues.where(Status: params[:Status]) if params[:Status]
    respond_to do |format|
      
      if params.has_key?(:assignee)
        if User.exists?(id: params[:assignee])
          @issues = @issues.where(assignee_id: params[:assignee])
        else
          format.json {render json: {"error":"User with id="+params[:assignee]+" does not exist"}, status: :unprocessable_entity}
        end
      end
      
      if params.has_key?(:type)
        @issues = @issues.where(Type: params[:type])
      end
      
      if params.has_key?(:priority)
        @issues = @issues.where(Priority: params[:priority])
      end
      
      if params.has_key?(:status)
        if params[:status] == "New&Open"
          @issues = @issues.where(Status: ["Open","New"])
        else
        @issues = @issues.where(Status: params[:status])
        end
      end

      if params.has_key?(:watcher)
        if User.exists?(id: params[:watcher])
          @issues = Issue.joins(:watchers).where(watchers:{user_id: params[:watcher]})
        else
          format.json {render json: {"error":"User with id="+params[:watcher]+" does not exist"}, status: :unprocessable_entity}
        end
      end

      format.html
      format.json {render json: @issues, status: :ok, each_serializer: IssueIndexSerializer}
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)
    @issue.user_id = current_user.id
    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    respond_to do |format|
      @issue_to_update = Issue.find(params[:id])
      @issue_to_update.update_attribute("Status", params[:status])
      
      format.html { redirect_to @issue_to_update }
      format.json { render json: @issue_to_update, status: :ok }
    end
  end

  # POST /issues/{issue_id}/vote
  def vote
        respond_to do |format|
          @issue_to_vote = Issue.find(params[:id])
          if !Vote.exists?(:issue_id => @issue_to_vote.id, :user_id => current_user.id)
            @vote = Vote.new
            @vote.user_id = current_user.id
            @vote.issue_id = @issue_to_vote.id
            @vote.save
            @issue_to_vote.increment!("Votes")
          else
            @vote = Vote.where(issue_id: params[:id], user_id: current_user.id).take
            @vote.destroy
            @issue_to_vote.decrement!("Votes")
          end
          format.html { redirect_to @issue_to_vote }
          format.json { render json: @issue_to_vote, status: :ok }
        end
    end

  # POST /issues/{issue_id}/watcher
    def watcher
        respond_to do |format|
          @issue_to_watcher = Issue.find(params[:id])
          if !Watcher.exists?(:issue_id => @issue_to_watcher.id, :user_id => current_user.id)
            @watcher = Watcher.new
            @watcher.user_id = current_user.id
            @watcher.issue_id = @issue_to_watcher.id
            @watcher.save
            @issue_to_watcher.increment!("Watchers")
          else
            @watcher = Watcher.where(issue_id: params[:id], user_id: current_user.id).take
            @watcher.destroy
            @issue_to_watcher.decrement!("Watchers")
          end
          if params[:index] != "index"
            format.html { redirect_to @issue_to_watcher }
            format.json { render json: @issue_to_watcher, status: :ok }
          else
            format.html { redirect_to issues_url, notice: 'Watching Issue' }
            format.json { head :no_content }
          end
          
        end
    end

    # POST /issues/{issue_id}/comment
   
  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    def sort_column
      Issue.column_names.include?(params[:sort]) ? params[:sort] : ''
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : ''
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:Title, :Description, :Type, :Priority, :Status, :assignee_id, :attachment)
    end
end
