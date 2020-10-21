class FacturationPdfController < ApplicationController
  # before_action :authenticate_cadre!, only: [:promise_cadre]
  # before_action :authenticate_client! , except: :promise_cadre
  def index
    # if current_admin.nil? && current_client.nil?
    #   flash[:alert] = "Ooups!"
    #   redirect_to root_path
    #   return
    # end

    @facture = Facture.find_by_id(params[:id_factures])
    if (@facture.created_at.day < 10)
      @day = "0"+ @facture.created_at.day.to_s
    else
      @day = @facture.created_at.day
    end
    if (@facture.created_at.month < 10)
      @month = "0"+ @facture.created_at.month.to_s
    else
      @month = @facture.created_at.month
    end
    @year = @facture.created_at.year
    @facture_id = @facture.id.to_s
    while (@facture_id.length < 5) do
      @facture_id = "0"+ @facture_id
    end
    @promise = @facture.promise_to_hire
    @pcalcul = @facture.prix
    respond_to do |format|
      format.pdf {render layout: 'facture_layout.html',
                    template: 'facturation_pdf/reporte',
                    pdf: 'Facture',
                    margin: { top: 10, bottom: 10, left: 10, right: 10 },
                    header: {
                      html: { template: 'facturation_pdf/header' },
                      spacing: 0
                    },
                    footer: {
                      html: { template: 'facturation_pdf/footer' },
                      spacing: -15
                    },
                    :save_to_file => Rails.root.join('public/facture', "Facture#{@facture.numero_facture}.pdf"),
                    :save_only    => true
                  }
    end
  end
  def promise
    # if current_admin.nil? && current_client.nil?
    #   flash[:alert] = "Ooups!"
    #   redirect_to root_path
    #   return
    # end
    @promise = PromiseToHire.find_by_id(params[:id_promise])
    @job = @promise.offre_job
    @cadre = @promise.cadre.cadre_info
    respond_to do |format|
      format.pdf {render layout: 'promise_layout.html',
                    template: 'facturation_pdf/promise',
                    pdf:"Promesse d'embauche OIAM ",
                    margin: { top: 15, bottom: 15, left: 10, right: 10 }
                  }
    end
  end
  def promise_cadre
    @promise = PromiseToHire.find_by_id(params[:id_promise])
    @cadre = current_cadre.cadre_info
    @job = @promise.offre_job
    @current_client = @job.client
    respond_to do |format|
      format.pdf {render layout: 'promise_cadre.html',
                    template: 'facturation_pdf/promise_cadre',
                    pdf: "Promesse d'embauche OIAM ",
                    margin: { top: 15, bottom: 15, left: 10, right: 10 }
                  }
    end
  end
end
