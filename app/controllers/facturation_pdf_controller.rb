class FacturationPdfController < ApplicationController
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
    test = ((@promise.remuneration_fixe_date.to_i * @promise.remuneration_fixe.to_f.round(2))) * 10 * 15
    @pcalcul = (test/1000).round(2)
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
                    }
                  }
    end
  end
  def promise
    @promise = PromiseToHire.find_by_id(params[:id_promise])
		@job = @promise.offre_job
    @cadre = @promise.cadre.cadre_info
    respond_to do |format|
      format.html
      format.pdf {render layout: 'promise_layout.html',
                    template: 'facturation_pdf/promise',
                    pdf: 'Promise',
                    margin: { top: 10, bottom: 10, left: 10, right: 10 }
                  }
    end
  end
end
