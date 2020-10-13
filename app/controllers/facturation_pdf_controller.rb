class FacturationPdfController < ApplicationController
  before_action :authenticate_cadre!,only: [:promise_cadre]
  before_action :authenticate_client! , except: :promise_cadre
  def index
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
    test = ((@promise.remuneration_fixe_date.to_i * @promise.remuneration_fixe.to_f.round(2))) * 10 * 20
    @pcalcul = (test/1000).round(2)
    respond_to do |format|
      format.pdf {render layout: 'facture_layout.html',
                    template: 'facturation_pdf/reporte',
                    pdf: 'Facture oiam',
                    margin: { top: 10, bottom: 10, left: 10, right: 10 },
                    header: {
                      html: { template: 'facturation_pdf/header' },
                      spacing: 0
                    },
                    footer: {
                      html: { template: 'facturation_pdf/footer' },
                      spacing: -15
                    }
                  }
    end
  end
  def promise
    @promise = PromiseToHire.find_by_id(params[:id_promise])
		@job = @promise.offre_job
    @cadre = @promise.cadre.cadre_info
    respond_to do |format|
      format.pdf {render layout: 'promise_layout.html',
                    template: 'facturation_pdf/promise',
                    pdf:"Promesse b'embauche OIAM ",
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
                    pdf: "Promesse b'embauche OIAM ",
                    margin: { top: 15, bottom: 15, left: 10, right: 10 }
                  }
    end
  end
end
