class StaticPageController < ApplicationController
	def home
    @header = true
  end

  def allHome
  end

  def equipe
  end

#page methodologie
  def methodology
  end

  def portfolio
  end

  def contact
  end

  def nothing
    @header = true
  end

  # save contacter nous
  def save_contact_us
    contact = ContactU.new(first_name: params[:first_name],last_name: params[:last_name],society: params[:society],function: params[:function],email: params[:mail],telephone: params[:telephone],how: params[:how],message: params[:message])
    if contact.save
      flash[:notice] = "Message envoyé avec succès."
    else
      flash[:alert] = "Une erreur s'est produite."
    end
    redirect_back(fallback_location: root_path)
  end

  # save mail for contact
  def save_app_subscriber
    subscriber = Subscriber.new(email:params[:email])
    unless Subscriber.find_by(email:params[:email]).nil?
      flash[:notice] = "Cet email est déjà membre de notre abonné."
    else
      if subscriber.save
        flash[:notice] = "Vous êtes maintenant abonné."
      else
        flash[:alert] = "Une erreur s'est produite."
      end
    end
    redirect_back(fallback_location: root_path)
  end

end
