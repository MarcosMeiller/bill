class BillMovementController < ApplicationController
  def index
    bill = params_bill
    bill_api = BillService.call(bill)
    result = calculate(bill,bill_api)
    render json: result
  end

  private

  def calculate (bill,bill_api)
    costo_financiamiento = (bill["monto"] * bill_api["advance_percent"].to_i) * (bill_api["document_rate"] / 30 * 31)
    giro_recibir = (bill["monto"] * bill_api["advance_percent"].to_i) - (costo_financiamiento + bill_api["commission"])
    exedentes = bill["monto"] - (bill["monto"] * bill_api["advance_percent"])
    results = { "costo_financiamiento" => costo_financiamiento, "giro_recibir" => giro_recibir, "exedentes" => exedentes }
  end

  def params_bill
    params.require(:bill).permit(:rut_emisor, :rut_deudor, :monto, :folio, :date)
  end
end
