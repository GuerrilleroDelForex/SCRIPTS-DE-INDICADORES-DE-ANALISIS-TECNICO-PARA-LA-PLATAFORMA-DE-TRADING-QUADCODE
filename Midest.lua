instrument { name = "Midest", overlay = true }

period = input (200, "Periodo", input.integer, 1   )

input_group {
    "Colores",
    VerdeSuave = input { default = rgba(37,225,84,255), type = input.color },
    VerdeFuerte = input { default = rgba(26,111,40,255), type = input.color },
    Amarillo = input { default = rgba(251,233,12,255), type = input.color },
    RojoSuave = input { default = rgba(255,108,88,255), type = input.color },
    RojoFuerte = input { default = rgba(170,47,30,255), type = input.color },
    AzulSuave = input { default = rgba(37,161,243,255), type = input.color },
    AzulFuerte = input { default = rgba(16,96,150,255), type = input.color },
    CafeSuave = input { default = rgba(240,140,38,255), type = input.color },
    CafeFuerte = input { default = rgba(147,81,16,255), type = input.color },
    Blanco = input { default = rgba(255,255,255,255), type = input.color },
    Negro = input { default = rgba(1,1,1,255), type = input.color }
}

input_group {
    "Amplitud",
    Anchura = input { default = 1, type = input.line_width}
}


Maximo = highest (period)
Minimo = lowest (period)
Medio = Minimo + ((Maximo-Minimo)/2)
ChoppinessIndex = 100 * log (sum (tr, period) / (highest (period) - lowest (period))) / log (period)



plot (Maximo, "Maximo", VerdeSuave, Anchura)
plot (Medio, "Midest", Amarillo, Anchura)
plot (Minimo, "Minimo", RojoSuave, Anchura)

if ChoppinessIndex > 50 and open > Medio then plot_candle { open, high, low, close, "", AzulFuerte} end
if ChoppinessIndex > 50 and open > Medio then plot_candle { open, low, high, close, "", AzulFuerte} end

if ChoppinessIndex <= 50 and open > Medio then plot_candle { open, high, low, close, "", VerdeSuave} end
if ChoppinessIndex <= 50 and open > Medio then plot_candle { open, low, high, close, "", VerdeSuave} end

if ChoppinessIndex > 50 and open < Medio then plot_candle { open, high, low, close, "", CafeFuerte} end
if ChoppinessIndex > 50 and open < Medio then plot_candle { open, low, high, close, "", CafeFuerte} end

if ChoppinessIndex <= 50 and open < Medio then plot_candle { open, high, low, close, "", RojoSuave} end
if ChoppinessIndex <= 50 and open < Medio then plot_candle { open, low, high, close, "", RojoSuave} end


