class FacturationPdfController < ApplicationController
  def index
    @facture = Facture.find_by_id(params[:id_factures])
    @promise = @facture.promise_to_hire
    test = ((@promise.remuneration_fixe_date.to_i * @promise.remuneration_fixe.to_f.round(2))) * 10 * 15
    @pcalcul = (test/1000).round(2)
    respond_to do |format|
      format.html
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
end
