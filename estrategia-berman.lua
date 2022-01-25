instrument {
  name = "estrategia berman",
  short_name = "berman",
  icon = "",
  overlay = true
}

exibir_tracamento = input(
  1, 
  "deseja exibir o tracamento?",
  input.string_selection,
  {"sim", "nao"}
)

input_group{
  "EMA",
  ema_color = input{ default = "blue", type = input.color }
}

input_group{
  "banda superior",
  bbsup_color = input{ default = "red", type = input.color }
}

input_group{
  "banda inferior",
  bbinf_color = input{ default = "yellow", type = input.color }
}

input_group{
  "CALL",
  call_color = input{ default = "green", type = input.color }
}

input_group{
  "PUT",
  put_color = input{ default = "red", type = input.color }
}

sec = security(current_ticker_id, "5m")

if sec and sec.open_time == open_time then
  ssmaa = sma(close, '20')
  upper_band = sma + (stdev(close, 20) * 2.5)
  lower_band = sma - (stdev(close, 20) * 2.5)
  emaa = ema(close, '100')
  
  if exibir_tracamento == 1 then
    plot(emaa, "ema", ema_color)
    plot(upper_band, "UPPER_BAND", bbsup_color)
    plot(lower_band, "LOWER_BAND", bbinf_color)
  end
  
  plot_shape(
    (high >= upper_band and emaa > upper_band),
    "PUT",
    shape_style.arrowdown,
    shape_size.huge,
    put_color,
    shape_location.abovebar,
    0,
    "PUT",
    put_color
  )

  plot_shape(
    (low <= lower_band and emaa < lower_band),
    "CALL",
    shape_style.arrowup,
    shape_size.huge,
    call_color,
    shape_location.belowbar,
    0,
    "CALL",
    call_color
  )
  
  
end
