instrument { name = "Media Movil Volatilidad [600]", 
             short_name = "Media Movil Volatilidad [600]",
             description = "Expresa el Volatilidad insitutcional de Media Movil Ribbon De Gabriel Arjona [GAMA] en el periodo 2000", 
             icon = "indicators:Ichimoku", 
             overlay = true
}


input_group {
    "Color Alcista",
    ColorAlcista = input { default = rgba(37,161,243,255), type = input.color }
}
            
input_group {
    "Color Bajista",
    ColorBajista = input { default = rgba(240,140,38,255), type = input.color }
}
            

input_group {
    "Color Alcista Con Volatilidad Institucional",
    ColorAlcistaConVolatilidadInstitucional = input { default = rgba(16,96,150,255), type = input.color }
}

input_group {
    "Color Bajista Con Volatilidad Institucional",
    ColorBajistaConVolatilidadInstitucional = input { default = rgba(147,81,16,255), type = input.color }
}

input_group {
    "Media Movil Ribbon De Gabriel Arjona",
    period = input (600, "Periodo", input.integer, 1),
}



PrecioMedioReal = hl2
PrecioDeCierre = tma (close, period)
PrecioDeApertura = tma (open, period)
PrecioMaximo = tma (high, period)
PrecioMinimo = tma (low, period)
PrecioMedio = tma (hl2, period)

GAMA2000 = (PrecioDeCierre + PrecioDeApertura + PrecioMaximo + PrecioMinimo + PrecioMedio) / 5

if fill_visible then
    fill (PrecioMedioReal, GAMA2000, "", PrecioMedioReal > GAMA2000 and ColorAlcista or ColorBajista)
end

VolatilidadMaximo = highest (tr, period)
VolatilidadMinimo = lowest (tr, period)
VolatilidadMedio =  ((VolatilidadMaximo - VolatilidadMinimo) / 2 ) + VolatilidadMinimo
VolatilidadIntermedioRetail = (VolatilidadMedio + VolatilidadMinimo) / 2
VolatilidadIntermedioInstitcional = (VolatilidadMedio + VolatilidadMaximo) / 2

if tr < VolatilidadIntermedioInstitcional == true then AlternativePrecioDeCierreInstitucional = tma (close, period) end
if tr < VolatilidadIntermedioInstitcional  == true then AlternativePrecioDeAperturaInstitucional = tma (open, period) end
if tr < VolatilidadIntermedioInstitcional == true then AlternativePrecioMaximoInstitucional = tma (high, period) end
if tr < VolatilidadIntermedioInstitcional == true then AlternativePrecioMinimoInstitucional = tma (low, period) end
if tr < VolatilidadIntermedioInstitcional == true then AlternativePrecioMedioInstitucional = tma (hl2, period) end



GAMA2000DeBajoVolatilidad = (PrecioDeCierre + PrecioDeApertura + PrecioMaximo + PrecioMinimo + PrecioMedio + AlternativePrecioDeCierreInstitucional + AlternativePrecioDeAperturaInstitucional + AlternativePrecioMaximoInstitucional + AlternativePrecioMinimoInstitucional + AlternativePrecioMedioInstitucional) / 10

if fill_visible then
    fill (PrecioMedioReal, GAMA2000DeBajoVolatilidad , "", PrecioMedioReal > GAMA2000DeBajoVolatilidad  and ColorAlcista or ColorBajista)
end


if tr >= VolatilidadIntermedioInstitcional == true then PrecioDeCierreInstitucional = tma (close, period) end
if tr >= VolatilidadIntermedioInstitcional  == true then PrecioDeAperturaInstitucional = tma (open, period) end
if tr >= VolatilidadIntermedioInstitcional == true then PrecioMaximoInstitucional = tma (high, period) end
if tr >= VolatilidadIntermedioInstitcional == true then PrecioMinimoInstitucional = tma (low, period) end
if tr >= VolatilidadIntermedioInstitcional == true then PrecioMedioInstitucional = tma (hl2, period) end

GAMA2000DeAltoVolatilidad = (PrecioDeCierre + PrecioDeApertura + PrecioMaximo + PrecioMinimo + PrecioMedio + PrecioDeCierreInstitucional + PrecioDeAperturaInstitucional + PrecioMaximoInstitucional + PrecioMinimoInstitucional + PrecioMedioInstitucional) / 10

if fill_visible then
    fill (PrecioMedioReal, GAMA2000DeAltoVolatilidad, "", PrecioMedioReal > GAMA2000DeAltoVolatilidad and ColorAlcistaConVolatilidadInstitucional or ColorBajistaConVolatilidadInstitucional)
end