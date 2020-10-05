class FacturationPdfController < ApplicationController
  def index
    @facture = Facture.find_by_id(params[:id_factures])
    @promise = @facture.promise_to_hire
    test = ((@promise.remuneration_fixe_date.to_i * @promise.remuneration_fixe.to_f.round(2))) * 10 * 15
    @pcalcul = (test/1000).round(2)
    respond_to do |format|
      format.html
      format.pdf {render template: 'facturation_pdf/reporte',pdf: 'Reporte' }
    end
  end
end
