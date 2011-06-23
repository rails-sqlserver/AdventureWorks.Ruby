class EmployeesController < ApplicationController
  
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      redirect_to @employee, :notice => 'Employee was successfully created.'
    else
      render :action => 'new'
    end
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      redirect_to @employee, :notice => 'Employee was successfully updated.'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    redirect_to employees_url
  end
  
  
end
