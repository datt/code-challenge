class CompaniesController < ApplicationController
  before_action :fetch_company, except: [:index, :create, :new, :destroy]

  # @todo Pagination must be applied
  # can use ransack gem for overall search and pagination functionalities
  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to_index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to_index
    else
      render :edit
    end
  end

  # @author: Datt Dongare
  # @todo: Data must not be destroyed, Use soft delete.
  # add 'active' field and just update it to false
  # Add default_scope in model :active for listing
  def destroy
    if @company.destroy
      redirect_to_index('destroy')
    else
      redirect_to company_path(@company), \
        notice: t('model.error.delete', model_i18n_keys)
    end
  end

  private

  def company_params
    params.require(:company).permit(
      :name,
      :legal_name,
      :description,
      :zip_code,
      :phone,
      :email,
      :owner_id
    )
  end

  # Changing the method name to fetch_company
  # Though it could not be applicable here shouldn't be encouraged
  # https://github.com/rubocop-hq/ruby-style-guide/issues/423
  def fetch_company
    @company = Company.find(params[:id])
  end

  # @author: Datt Dongare
  # redirects to companies path with action message
  # @param [String] action, used for retrieving the i18n key
  def redirect_to_index(action = 'save')
    redirect_to companies_path, notice: t("model.#{action}", model_i18n_keys)
  end

  # @author: Datt Dongare
  # @return [Hash] with keys used in translation file
  def model_i18n_keys
    # used memoization
    @model_i18n_keys ||= {
      model: 'Company',
      identity: @company.name
    }
  end
end
